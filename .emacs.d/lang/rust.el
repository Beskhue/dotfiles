;;; rust --- Rust.
;;; Code:
(use-package rust-mode)
(use-package cargo-minor-mode
  :hook rust-mode)
(use-package racer-mode
  :hook rust-mode)
(use-package eldoc-mode
  :hook racer-mode)
(use-package company-mode
  :hook racer-mode)

(add-hook 'rust-mode-hook '(lambda()
                             (column-enforce-mode 0)
                             (setq-local column-enforce-column 100)
                             (column-enforce-mode 1)))

(mode-leader-def
  :states 'normal
  :keymaps 'rust-mode-map
  "b" 'cargo-process-build
  "r" 'cargo-process-run
  "c" 'cargo-process-check
  "C" 'cargo-process-clippy)
