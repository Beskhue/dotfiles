;;; javascript --- Javascript.
;;; Code:
(use-package rjsx-mode
  :mode ("\\.js\\'" "\\.ts\\'" "\\.jsx\\'" "\\.tsx\\'")
  :hook (rjsx-mode . lsp)
  :config
    (setq js2-basic-offset 2)
    (setq js2-mode-show-parse-errors nil)
    (setq js2-mode-show-strict-warnings nil))
(add-hook 'rjsx-mode-hook 'flycheck-mode)

(use-package prettier-js
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "m f" 'prettier-js))
