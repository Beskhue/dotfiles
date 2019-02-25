;;; magma --- Magma algebra system.
;;; Code:
(use-package magma-mode
  :config
  (setq auto-mode-alist
    (append '(("\\.m$" . magma-mode))
      auto-mode-alist)))
