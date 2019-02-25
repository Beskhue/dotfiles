(use-package smart-mode-line
  :config             
  (setq sml/theme 'dark)
  (sml/setup))
(use-package zenburn-theme)
;; (use-package fill-column-indicator
;;  :config
;;  (add-hook 'prog-mode-hook 'fci-mode))

(use-package beacon
  :config
  (beacon-mode 1))

(global-display-line-numbers-mode 1)
