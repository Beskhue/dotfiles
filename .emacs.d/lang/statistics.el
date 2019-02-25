;;; ess --- Statistics languages (such as R).
;;; Code:
(use-package ess
  :config
  (mode-leader-def
    :states '(normal motion)
    :keymaps 'ess-mode-map
    "s b" 'ess-eval-buffer
    "s B" 'ess-eval-buffer-and-go
    "s l" 'ess-eval-line
    "s L" 'ess-eval-line-and-go
    "s r" 'ess-eval-region
    "s R" 'ess-eval-region-and-go
    "s f" 'ess-eval-function
    "s F" 'ess-eval-function-and-go)
  (general-define-key
    :states '(normal motion insert)
    :keymaps 'ess-mode-map
    "C-RET" 'ess-eval-line))

(use-package ess-R-data-view
  :hook ess-mode
  :config
  (mode-leader-def
    :states '(normal motion)
    :keymaps 'ess-mode-map
    "h d" 'ess-R-dv-pprint
    "h t" 'ess-R-dv-ctable))
