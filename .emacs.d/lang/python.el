;;; python --- Python.
;;; Code:

(add-hook 'python-mode-hook 'lsp)
(add-hook 'python-mode-hook 'flycheck-mode)

(use-package blacken
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'python-mode
    "m f" 'blacken-buffer))

(add-hook 'python-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 79)
                             (column-enforce-mode 1)))
