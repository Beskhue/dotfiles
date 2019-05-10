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
(setq backup-directory-alist
  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))
;; Don't use tabs in region indents.
(setq-default indent-tabs-mode nil)
(require 'use-package)
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
  (which-key-mode)
  (setq which-key-idle-delay 0.01)
  (which-key-add-key-based-replacements
    "SPC f" "file"
    "SPC g" "git"
    "SPC m" "major mode"))
(general-define-key
  :states '(normal motion)
  "C-j" 'next-buffer
  "C-k" 'previous-buffer
  "C-S-h" 'evil-window-left
  "C-S-j" 'evil-window-down
  "C-S-k" 'evil-window-up
  "C-S-l" 'evil-window-right)

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

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-display-errors-delay 0)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(global-leader-def
  :states '(normal motion)
  :keymaps 'override
  "e l" 'flycheck-list-errors)
(general-define-key
  :states 'normal
  :keymaps 'flycheck-error-list-mode-map
  "j" 'flycheck-error-list-next-error
  "k" 'flycheck-error-list-previous-error)
(use-package company
  :config
  (general-define-key
   :keymaps 'override
   "TAB" 'company-indent-or-complete-common)
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
(use-package swiper
  :config
  (setq swiper-completion-method 'ivy)
  (general-define-key
   "C-s" 'swiper))
(use-package counsel
  :config
  (general-define-key
   "M-x" 'counsel-M-x))
(use-package avy
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "s l" 'avy-goto-line
    "s c" 'avy-goto-char))

(load "~/.emacs.d/lang/markdown.el")
(load "~/.emacs.d/lang/org.el")
(load "~/.emacs.d/lang/nix.el")
(load "~/.emacs.d/lang/rust.el")
(load "~/.emacs.d/lang/statistics.el")
(load "~/.emacs.d/lang/magma.el")
