(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (setq line-number-mode t)
  (setq column-number-mode t))
(use-package minions
  :config
  (setq minions-direct '(flycheck-mode))
  (minions-mode 1))

(use-package solarized-theme
  :config
(load-theme 'solarized-light t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

(use-package all-the-icons)

(setq neo-theme (if (display-graphic-p) 'classic 'arrow))

(add-to-list 'default-frame-alist
             '(font . "Iosevka-10"))

(global-display-line-numbers-mode 1)
