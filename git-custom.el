(global-git-gutter+-mode)

(defhydra hydra-git-gutter (:body-pre (git-gutter+-mode 1)
                            :color
                            :hint nil)
  "
Git (gutter and other stuff):
  _j_: next hunk        _s_tage hunk     _q_uit
  _k_: previous hunk    _r_evert hunk    _Q_uit and deactivate git-gutter+
  _h_: first hunk       _l_: last hunk   _S_tage whole buffer
  _p_opup hunk          ^ ^
  set start _R_evision
"
  ("j" git-gutter+-next-hunk)
  ("k" git-gutter+-previous-hunk)
  ("h" (progn (goto-char (point-min))
              (git-gutter+-next-hunk 1)))
  ("l" (progn (goto-char (point-min))
              (git-gutter+-previous-hunk 1)))

  ("s" git-gutter+-stage-hunks)
  ("S" git-gutter+-stage-whole-buffer :color blue)
  ("r" git-gutter+-revert-hunks)
  ("p" git-gutter+-popup-hunk)

  ("SPC" git-gutter+-show-hunk-inline-at-point)
  ("R" git-gutter+-set-start-revision)
  ("q" nil :color blue)
  ("Q" (progn (git-gutter+-mode -1)
              ;; git-gutter+-fringe doesn't seem to
              ;; clear the markup right away
              (sit-for 0.1)
              (git-gutter+-clear))
       :color blue))
