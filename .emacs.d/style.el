(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (setq line-number-mode t)
  (setq column-number-mode t))
(use-package minions
  :config (minions-mode 1))

(use-package zenburn-theme)
;; (use-package fill-column-indicator
;;  :config
;;  (add-hook 'prog-mode-hook 'fci-mode))

(global-display-line-numbers-mode 1)
