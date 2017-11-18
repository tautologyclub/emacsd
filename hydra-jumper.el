(defhydra hydra-jumper (:color blue
                             :hint nil
                             )
  "
     FIXME
"
  ("rg"   counsel-rg)
  ("o"   occur-dwim) ;; fixme
  ("cd"   dired-jump)

  ("gg"   counsel-git-grep)
  ("gr"   counsel-git-grep-query-replace)
  ("gs"   magit-status)
  ("gh"   vc-region-history)

  ("fo"   ff-find-other-file)
  ;; ("?"   mark-defun)

  ("sd"   ggtags-show-definition)
  ("tg"   ggtags-grep)
  ("ts"   helm-gtags-select)
  ("<return>"   helm-gtags-dwim)
  ("tr"   helm-gtags-find-rtag)
  ("tt"   helm-gtags-show-stack)
  ("tu"   helm-gtags-update-tags)
  ("tp"   helm-gtags-previous-history)
  ("tn"   helm-gtags-next-history)

  ("l"   goto-line-with-feedback)

  ("."   helm-gtags-pop-stack)
  ("t DEL"   helm-gtags-clear-stack)

  ("q"   nil "cancel" :color blue))
