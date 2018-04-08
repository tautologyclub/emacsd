(defhydra hydra-jumper (:color blue
                               :hint nil
                               :columns 4
                             )
  "
--- jumper hydra ---------------------------------------------------------------
"
  ("rg"   counsel-rg                    "rg")
  ("o"   occur-dwim                     "occur")
  ("cd"   dired-jump                    "dired")

  ("gg"   counsel-git-grep              "git grep")
  ("gr"   counsel-git-grep-query-replace
                                        "git replace")
  ("gs"   magit-status)
  ("gh"   vc-region-history             "vc history")

  ("fo"   ff-find-other-file            "other file")
  ;; ("?"   mark-defun)

  ("sd"   ggtags-show-definition        "hg show def")
  ("ts"   helm-gtags-select             "hg select")
  ("RET"   helm-gtags-dwim              "hg dwim")
  ("tr"   helm-gtags-find-rtag          "find rtag")
  ("tt"   helm-gtags-show-stack         "hg stack")
  ("."   helm-gtags-pop-stack           "hg pop")
  ("tu"   helm-gtags-update-tags        "hg update")
  ("tp"   helm-gtags-previous-history   "hg prev")
  ("tn"   helm-gtags-next-history       "hg next")

  ("l"   goto-line-with-feedback)

  ("t DEL"   helm-gtags-clear-stack     "hg clear")

  ("q"   nil "cancel" :color blue))

(message "HI I AM DEPRECATED")
