;;; files --- File managing.
;;; Code:
(use-package neotree
  :config
  (setq neo-autorefresh nil)
  (general-define-key
   :states 'normal
   :keymaps 'neotree-mode-map
   "q" 'neotree-hide
   "RET" 'neotree-enter
   "g" 'neotree-refresh
   "TAB" 'neotree-stretch-toggle
   "H" 'neotree-hidden-file-toggle)
  (global-leader-def
    :states '(normal motion)
    :keymaps 'override
    "f t" 'neotree-toggle
    "f r" 'neotree-change-root)
  ;(add-hook 'after-init-hook #'neotree-toggle)
  (add-hook 'neo-after-create-hook
	    (lambda (&rest _) (display-line-numbers-mode -1))))
