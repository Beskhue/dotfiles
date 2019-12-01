;;; javascript --- Javascript.
;;; Code:
(use-package js-mode
  :mode ("\\.js\\'" "\\.ts\\'" "\\.jsx\\'" "\\.tsx\\'")
  :hook (js-mode . eglot)
  :init
  (setq js-indent-level 2))

(use-package prettier-js
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "m f" 'prettier-js))
