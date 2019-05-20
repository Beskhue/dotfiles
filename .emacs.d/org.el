(use-package org-super-agenda
  :config
  (org-super-agenda-mode)
  (setq org-super-agenda-groups
        '(
          (:name "Events"
                 :scheduled today)
          (:name "Due"
                 :deadline today)
          (:name "University"
                 :tag "uni")
          (:name "Important"
                 :priority "A")
          )
        )
  )
(setq org-agenda-files (list "~/Seafile/org-agenda"))
