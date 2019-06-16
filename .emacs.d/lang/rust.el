;;; rust --- Rust.
;;; Code:
(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp)
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "m f" 'rust-format-buffer))
(add-hook 'rust-mode-hook 'flycheck-mode)
(add-hook 'rust-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 100)
                             (column-enforce-mode 1)))

