;;; rust --- Rust.
;;; Code:
(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . eglot-ensure)
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "m f" 'rust-format-buffer))
;;(add-hook 'rust-mode-hook 'flycheck-mode)
(add-hook 'rust-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 100)
                             (column-enforce-mode 1)))

;; Fix autocompletion slowness when using company-lsp + Rust,
;; as per https://github.com/tigersoldier/company-lsp/issues/61#issuecomment-475993376
;;(add-hook 'rust-mode-hook (lambda ()
;;                             (setq company-backends
;;                             (delete 'company-capf company-backends))))

