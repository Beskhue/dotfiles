import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
--import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.IndependentScreens
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.UrgencyHook

import qualified DBus as D
import qualified DBus.Client as D

import Control.Monad (when, join)
import Data.Maybe (maybeToList)

import MyMonitors

myModMask = mod4Mask

barActive = "#c0333333"
barYellow = "#f9d300"
barPurple = "#9f78e1"
barRed = "#fb4934"
barRedUnderline = "#992618"


myStartupHook =
  -- Set background image.
  spawn "feh --bg-scale /home/thomas/Backgrounds/wallpaper-pixelart1.png" >>
  -- Autostart .desktop
  spawnOnce "dex -a" >>
  spawnOnce "thingshare_init" >>
  -- Patch in fellscreen support.
  addEWMHFullscreen

myKeys = [ ((myModMask, xK_f), spawn "firefox" )
         , ((myModMask, xK_p), spawn "rofi -combi-modi run,drun -show combi -modi combi" )
         , ((controlMask .|. shiftMask, xK_4), spawn "thingshare_screenshot region")
         , ((controlMask .|. shiftMask, xK_3), spawn "thingshare_screenshot window")
         , ((0, 0x1008FF11), spawn "amixer sset Master $(($(amixer sget Master | grep -oP \"\\[\\d*%\\]\" | head -n 1  | tr -d \"[]%\")-3))%")
         , ((0, 0x1008FF12), spawn "amixer sset Master toggle")
         , ((0, 0x1008FF13), spawn "amixer sset Master $(($(amixer sget Master | grep -oP \"\\[\\d*%\\]\" | head -n 1  | tr -d \"[]%\")+3))%; amixer sset Master unmute")
         , ((0, 0x1008FF14), spawn "playerctl play-pause")
         , ((0, 0x1008FF15), spawn "playerctl stop")
         , ((0, 0x1008FF16), spawn "playerctl previous")
         , ((0, 0x1008FF17), spawn "playerctl next")
         ]

-- Patch in fullscreen support.
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

-- Output a string to a DBus.
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

polybarLogHook dbus = def 
    {  ppOutput = dbusOutput dbus
     , ppCurrent = wrap ("%{B" ++ barActive ++ "}%{u" ++ barYellow ++  "}<") ">%{-u}%{B-}"
     , ppVisible = wrap ("%{B" ++ barActive ++ "}%{u" ++ barPurple ++ "} ") " %{-u}%{B-}"
     , ppUrgent = wrap ("%{u" ++ barRedUnderline ++ "}%{F" ++ barRed ++ "} ") "!%{F-}%{-u}"
     , ppHidden = wrap " " " "
     , ppWsSep = ""
     , ppSep = ": "
     , ppTitle = \s -> ""
    }

main = do
    num <- countScreens
    --xmprocs <- mapM (\i -> spawnPipe $ "xmobar /home/thomas/.xmobar/xmobarrc-" ++ show i ++ " -x " ++ show i) [0..num-1]
    mapM (\m -> spawn $ "MONITOR=" ++ m ++ " polybar top") monitors
    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    xmonad $ ewmh $ docks $ withUrgencyHook NoUrgencyHook $ defaults dbus

defaults dbus = defaultConfig {
      modMask = myModMask
    , terminal = "urxvt"
    , focusedBorderColor = "#FF6600"
    , layoutHook = 
        avoidStruts $
            lessBorders Screen (
                spacingRaw True (Border 0 0 0 0) False (Border 8 8 8 8) True $ layoutHook def
            ) 
    , startupHook = myStartupHook
    , logHook = dynamicLogWithPP $ polybarLogHook dbus
    , manageHook = isFullscreen --> doFullFloat
    , handleEventHook = fullscreenEventHook
} `additionalKeys` myKeys

