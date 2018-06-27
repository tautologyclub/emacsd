(require 'hideshow)
(require 'vimish-fold)
(require 'some-defuns)

(defhydra hydra-git-gutter (:body-pre (git-gutter+-mode 1)
                            :color
                            :hint nil)
  "
Git (gutter and other stuff):
  _j_: next hunk        _s_tage hunk     _f_ind-file     _q_uit
  _k_: previous hunk    _r_evert hunk    _b_lame
  _h_: first hunk       _e_: ediff       _S_tage buffer  _t_ime-machine
  _l_: last hunk        _p_opup hunk    _cg_rep   _cl_og
  ^^                    _H_: region-history
"
  ("f" magit-find-file :color blue)
  ("b" magit-blame :color blue)
  ("cg" counsel-git-grep :color blue)
  ("cl" counsel-git-log :color blue)
  ("j" git-gutter+-next-hunk)
  ("k" git-gutter+-previous-hunk)
  ("h" (progn (goto-char (point-min))
              (git-gutter+-next-hunk 1)))
  ("l" (progn (goto-char (point-min))
              (git-gutter+-previous-hunk 1)))

  ("t" git-timemachine :color blue)
  ("e" vc-ediff :color blue)
  ("d" magit-diff)
  ("s" git-gutter+-stage-hunks)
  ("S" git-gutter+-stage-whole-buffer :color blue)
  ("H" vc-region-history :color blue)
  ("r" git-gutter+-revert-hunks)
  ("p" git-gutter+-popup-hunk)
  ("SPC" git-gutter+-show-hunk-inline-at-point)
  ("q" nil :color blue))

(defhydra hydra-ediff (:color blue :columns 2)
  "-- ediff ------------------------------------------------------------------------"
  ("e"  ediff-current-file      "unsaved")
  ("f"  ediff-files             "files")
  ("b"  ediff-buffers           "buffers A and B")
  ("c"  ediff-current-buffer    "this and buffer B")
  ("mf" ediff-merge-files       "merge files")
  ("mb" ediff-merge-buffers     "merge buffers")

  ("q"  nil                     "quit")
  ("RET" nil                    "quit"))

(defhydra hydra-eval (:color blue :columns 2)
  "-- eval -
------------------------------------------------------------------------"
  ("b" eval-buffer              "buffer")
  ("r" eval-region              "region")
  ("d" eval-defun               "defun")
  ("e" eval-expression          "expression")
  ("w" crux-eval-and-replace    "eval+replace")

  ("RET" nil                    "quit")
  ("q" nil                      "quit"))

(defhydra helm-like-unite (:hint nil
                           :color pink)
  "
Nav ^^^^^^^^^        Mark ^^          Other ^^       Quit
^^^^^^^^^^------------^^----------------^^----------------------
_K_ ^  ^ _k_ ^ ^     _m_ark           _v_iew         _i_: cancel
^↕^ _h_ ^✜^ _l_ ^ ^   _t_oggle mark    _H_elp         _o_: quit
_J_ ^  ^ _j_ ^ ^     _U_nmark all     _d_elete       _s_: swoop-edit (broken)
^^^^^^^^^^                           _f_ollow: %(helm-attr 'follow)
"
  ;; arrows
  ("h" helm-beginning-of-buffer)
  ("j" helm-next-line)
  ("k" helm-previous-line)
  ("l" helm-end-of-buffer)

  ;; beginning/end
  ("g" helm-beginning-of-buffer)
  ("G" helm-end-of-buffer)

  ;; scroll
  ("K" helm-scroll-other-window-down)
  ("J" helm-scroll-other-window)

  ;; mark
  ("SPC" helm-toggle-visible-mark)
  ("m" helm-toggle-visible-mark)
  ("t" helm-toggle-all-marks)
  ("U" helm-unmark-all)

  ;; exit
  ("<escape>" keyboard-escape-quit "" :exit t)
  ("o" keyboard-escape-quit :exit t)
  ("i" nil)

  ;; sources
  ("}" helm-next-source)
  ("{" helm-previous-source)

  ;; rest
  ("H" helm-help)
  ("v" helm-execute-persistent-action)
  ("d" benjamin/helm-buffer-run-kill-persistent)

  ("f" helm-follow-mode)
  ("<f9>" nil)
  ("s" (progn
         (hydra-keyboard-quit)
         (helm-swoop-edit))
   :exit t))

(defhydra hydra-flycheck
  (:pre (progn (setq hydra-lv t) (flycheck-list-errors)
               (setq truncate-lines -1)
               (when (flycheck-pos-tip-mode)
                 (call-interactively 'flycheck-pos-tip-mode)))
        :post (progn (setq hydra-lv nil)
                     (quit-windows-on "*Flycheck errors*")
                     (flycheck-pos-tip-mode t))
   :hint nil)
  "Errors"
  ("f"  flycheck-error-list-set-filter                            "Filter")
  ("j"  flycheck-next-error                                       "Next")
  ("k"  flycheck-previous-error                                   "Previous")
  ("h" flycheck-first-error                                      "First")
  ("l"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("<down>"  flycheck-next-error)
  ("<up>"  flycheck-previous-error)
  ("RET" nil)
  ("q"  nil                                                       "Quit"))

;;;###autoload
(defun benjamin/flycheck-list-errors ()
  "List errors in a separate window, decrease the size."
  (interactive)
  (flycheck-list-errors)
  (hydra-flycheck/body))

(defhydra hydra-vimish-fold (:color blue
                             :columns 3)
  "folder"
  ("h" hs-hide-all "hs-hide all")
  ("s" hs-show-all "hs-show all")
  ("a" vimish-fold-avy "avy")
  ("d" vimish-fold-delete "del")
  ("D" vimish-fold-delete-all "del-all")
  ("u" vimish-fold-unfold "unfold")
  ("U" vimish-fold-unfold-all "unfold-all")
  ("f" vimish-fold "fold")
  ("r" vimish-fold-refold "refold")
  ("R" vimish-fold-refold-all "refold-all")
  ("t" vimish-fold-toggle "toggle" :exit nil)
  ("T" vimish-fold-toggle-all "toggle-all" :exit nil)
  ("j" vimish-fold-next-fold "down" :exit nil)
  ("k" vimish-fold-previous-fold "up" :exit nil)
  ("q" nil "quit"))

(defhydra hydra-errgo (:hint nil)
  ("q" nil              "quit")
  ("h" first-error      "first")
  ("j" next-error       "next")
  ("k" previous-error   "prev")
  ("l" last-error       "last")
  ("n" next-error       "next")
  ("p" previous-error   "prev")
  ("l" last-error       "last"))

(defvar prev-max-mini-window-height max-mini-window-height)
(defhydra hydra-toggle (:color red
                        :hint nil
                        :pre  (progn
                                (setq prev-max-mini-window-height max-mini-window-height)
                                (setq max-mini-window-height 30))
                        :post (progn
                                (setq max-mini-window-height prev-max-mini-window-height)))
  "
  _a_ abbrev:           %`abbrev-mode
  _s_ semantic:         %`semantic-mode
  _S_ flyspell:         %`flyspell-mode
  _T_    stickyfunc:    %`semantic-stickyfunc-mode
  _e_ feebleline:       %`feebleline-mode
  _f_ auto-fill:        %`auto-fill-function
  _h_ hl-line:          %`hl-line-mode
  _d_ debug-on-error:   %`debug-on-error
  _D_ diff-mode:        %`diff-auto-refine-mode
  _t_ truncate-lines:   %`truncate-lines
  _y_ flycheck:         %`flycheck-mode
  _w_ whitespace:       %`whitespace-mode
  _l_ linum:            %`display-line-numbers
  _i_ fci:              %`fci-mode
  _o_ overwrite:        %`overwrite-mode
  _r_ rec-minibuf       %`enable-recursive-minibuffers
  _R_ read-only         %`buffer-read-only
"
  ("a" abbrev-mode)
  ("s" semantic-mode)
  ("S" flyspell-mode)
  ("T" semantic-stickyfunc-mode)
  ("d" toggle-debug-on-error)
  ("D" diff-mode)
  ("f" auto-fill-mode)
  ("h" (setq highlight-nonselected-windows (not highlight-nonselected-windows)))
  ("e" feebleline-mode)
  ("t" toggle-truncate-lines)
  ("y" flycheck-mode)
  ("h" hl-line-mode)
  ("L" global-hl-line-mode)
  ("H" helm-gtags-mode)
  ("w" whitespace-mode)
  ("l" benjamin/toggle-linum)
  ("i" fci-mode)
  ("o" overwrite-mode)
  ("r" (setq enable-recursive-minibuffers (not enable-recursive-minibuffers)))
  ("R" read-only-mode)
  ("RET" nil "quit")
  ("q" nil "quit"))

(defun benjamin/toggle-linum ()
  (interactive)
  ;; (set (make-local-variable 'display-line-numbers) (not display-line-numbers)))
  (setq display-line-numbers (not display-line-numbers)))



(defhydra hydra-timestamp (:color blue :columns 2)
  " timestamp
--------------------------------------------------------------------------------
"
  ("tf" (paste-shell-stdout "date +'%d/%m/%y -- %H:%M:%S'")
   "DD/MM/YY -- HH:MM:SS")
  ("tt" (paste-shell-stdout "date +'%H:%M:%S '")
   "HH:MM:SS")
  ("td" (paste-shell-stdout "date +'%d/%m/%y '")
   "DD/MM/YY")
  ("td" (paste-shell-stdout "date +'%d/%m/%y '")
   "DD/MM/YY")
  ("RET" nil "quit")
  ("q" nil "quit"))

(provide 'some-hydras)
;;; some-hydras.el ends here
