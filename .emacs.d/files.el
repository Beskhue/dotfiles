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

(use-package dired-subtree
  :config
  (setq dired-subtree-use-backgrounds nil)
  (setq dired-subtree-line-prefix " │")
  (general-define-key
    :states '(normal motion)
    :keymaps 'dired-mode-map
    "i" 'dired-subtree-insert
    "I" 'dired-subtree-remove))

(use-package dired-rainbow
  :config
  (progn
    (dired-rainbow-define all (:inherit default) ".*")
    (dired-rainbow-define-chmod directory (:inherit font-lock-constant-face) "d.*")
    (dired-rainbow-define data (:inherit font-lock-string-face) ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata" "toml" "csv"))
    (dired-rainbow-define shell (:inherit font-lock-function-name-face) ("sh" "bash" "bat"))
    (dired-rainbow-define dotfile (:inherit font-lock-comment-face :italic t) "\\..+")))
