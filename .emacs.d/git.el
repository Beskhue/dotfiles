;;; git --- Magit configuration.
;;; Code:
(use-package magit
  :config
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "g b" 'magit-blame
    "g h" 'magit-log-buffer-file
    "g s" 'magit-status
    "g S" 'magit-stage-file
    "g U" 'magit-unstage-file
    "g c" 'magit-commit))
