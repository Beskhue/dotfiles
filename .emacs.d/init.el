(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq inhibit-startup-screen t)
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

(global-leader-def
  :states '(normal motion)
  :keymaps 'override
  "b" 'switch-to-buffer)
(general-define-key
  :states '(normal motion)
  "C-j" 'next-buffer
  "C-k" 'previous-buffer
  "C-S-h" 'evil-window-left
  "C-S-j" 'evil-window-down
  "C-S-k" 'evil-window-up
  "C-S-l" 'evil-window-right)

(use-package magit)

(load "~/.emacs.d/style.el")
(load "~/.emacs.d/files.el")

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-display-errors-delay 0)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(general-define-key
  :states 'normal
  :keymaps 'flycheck-error-list-mode-map
  "j" 'flycheck-error-list-next-error
  "k" 'flycheck-error-list-previous-error)
(use-package company-mode
  :defer
  :config
  (general-define-key
   :keymaps 'override
   "TAB" 'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (general-define-key
    "C-s" 'swiper))
(load "~/.emacs.d/lang/markdown.el")
(load "~/.emacs.d/lang/nix.el")
(load "~/.emacs.d/lang/rust.el")
(load "~/.emacs.d/lang/statistics.el")