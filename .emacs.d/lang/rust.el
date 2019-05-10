;;; rust --- Rust.
;;; Code:
(use-package rust-mode
  :mode "\\.rs\\'")
(use-package cargo
  :hook (rust-mode . cargo-minor-mode)
  :general
  (mode-leader-def
    :states 'normal
    :keymaps 'rust-mode-map
    "b" 'cargo-process-build
    "r" 'cargo-process-run
    "c" 'cargo-process-check
    "C" 'cargo-process-clippy))
(use-package racer
  :hook (rust-mode . racer-mode))
(use-package flycheck-rust
  :hook cargo-minor-mode
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(use-package eldoc-mode
  :hook racer-mode)
(use-package company-mode
  :hook racer-mode)

(add-hook 'rust-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 100)
                             (column-enforce-mode 1)))

