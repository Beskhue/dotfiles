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
(require 'use-package)
(use-package evil
  :config (evil-mode 1))

(use-package magit)
(use-package smart-mode-line
  :config             
  (setq sml/theme 'dark)
  (sml/setup))
(use-package monokai-theme)

(use-package neotree
  :bind (([f8] . neotree-toggle))
  :config 
  (neotree-mode 'normal)
  (setq neo-autorefresh nil))
(use-package beacon
  :config
  (beacon-mode 1))
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
(use-package rust-mode)
(use-package nix-mode)
(use-package cargo-minor-mode
 :hook rust-mode)
