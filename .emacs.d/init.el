;; Explicitly initialize packages. But don't activate them (we utilize
;; use-package for that).
;; See: https://github.com/jwiegley/use-package/issues/275
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize t)
(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Don't use tabs in region indents.
(setq-default indent-tabs-mode nil)
(use-package evil
  :config (evil-mode 1))
(use-package general
  :config
  (general-swap-key nil 'motion
    ";" ":")
  (general-create-definer global-leader-def
    :prefix "SPC")
  (general-create-definer mode-leader-def
    :prefix "SPC m"))
(use-package which-key
  :config
  (setq which-key-idle-delay 0.01)
  (which-key-mode)
  (which-key-add-key-based-replacements
    "SPC f" "file"
    "SPC g" "git"
    "SPC m" "major mode"
    "SPC p" "projectile"))

;; Buffer motion.
(general-define-key
  :states '(normal motion)
  "C-j" 'next-buffer
  "C-k" 'previous-buffer
  "C-S-h" 'evil-window-left
  "C-S-j" 'evil-window-down
  "C-S-k" 'evil-window-up
  "C-S-l" 'evil-window-right)

(use-package drag-stuff
  :general
  ("M-h" 'drag-stuff-left)
  ("M-j" 'drag-stuff-down)
  ("M-k" 'drag-stuff-up)
  ("M-l" 'drag-stuff-right))

(use-package projectile
  :config
  (projectile-mode +1)
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "p" 'projectile-command-map))

(load "~/.emacs.d/git.el")
(load "~/.emacs.d/style.el")
(load "~/.emacs.d/files.el")

;; Highlight text after 80th column.
(use-package column-enforce-mode)
(add-hook 'prog-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 80)
                             (column-enforce-mode 1)))
(setq-default show-trailing-whitespace t)
(add-hook 'prog-mode-hook 'show-paren-mode)

(use-package company
  :config
  (general-define-key
   :keymaps 'override
   "M-TAB" 'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0))
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "b" 'ivy-switch-buffer))

(use-package eglot
  :hook (eglot . company-mode)
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "m d" 'xref-find-definitions
    "m x" 'xref-find-references
    "m t" 'eglot-find-typeDefinition
    "m a" 'eglot-code-actions
    "m r" 'eglot-rename))
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))
(use-package flymake
  :config
  (general-define-key
   :states '(insert normal motion)
   :keymap 'override
   "C-j" 'flymake-goto-next-error
   "C-k" 'flymake-goto-prev-error))

(use-package swiper
  :general
  ("C-s" 'swiper)
  :config
  (setq swiper-completion-method 'ivy))
(use-package counsel
  :general
  ("M-x" 'counsel-M-x))
(use-package avy
  :general
  (general-define-key
   :states '(insert normal motion)
   :keymap 'override
   "C-d" 'avy-goto-char-timer)
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "j b" 'evil-jump-backward
    "j l" 'avy-goto-line
    "j w" 'avy-goto-word-1
    "j j" 'avy-goto-char)
  :config
  (setq avy-all-windows nil)
  (setq avy-timeout-seconds 0.25))

(load "~/.emacs.d/lang/yaml.el")
(load "~/.emacs.d/lang/markdown.el")
(load "~/.emacs.d/lang/org.el")
(load "~/.emacs.d/lang/nix.el")
(load "~/.emacs.d/lang/rust.el")
(load "~/.emacs.d/lang/haskell.el")
(load "~/.emacs.d/lang/javascript.el")
(load "~/.emacs.d/lang/python.el")
(load "~/.emacs.d/lang/statistics.el")
(load "~/.emacs.d/lang/magma.el")
(load "~/.emacs.d/org.el")
