(require 'hideshow)
(require 'vimish-fold)

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

;; Perfect hydra-material but we will see
(defun fake-C-c ()
  "Fakes the user typing Ctrl-c."
  (interactive)
  (setq unread-command-events (nconc (listify-key-sequence (kbd "C-c"))
                                     unread-command-events)))
(defun fake-C-x ()
  "Fakes the user typing Ctrl-x."
  (interactive)
  (setq unread-command-events (nconc (listify-key-sequence (kbd "C-x"))
                                     unread-command-events)))

(defhydra hydra-errgo (:hint nil)
  ("q" nil              "quit")
  ("h" first-error      "first")
  ("j" next-error       "next")
  ("k" previous-error   "prev")
  ("l" last-error       "last")
  )

(require 'dired)
(defhydra hydra-dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))
(define-key dired-mode-map "." 'hydra-dired/body)

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
  _T_    stickyfunc:    %`semantic-stickyfunc-mode
  _e_ feebleline:       %`feebleline-mode
  _f_ auto-fill:        %`auto-fill-function
  _h_ hl-line:          %`hl-line-mode
  _d_ debug-on-error:   %`debug-on-error
  _t_ truncate-lines:   %`truncate-lines
  _y_ flycheck:         %`flycheck-mode
  _w_ whitespace:       %`whitespace-mode
  _l_ linum:            %`linum-mode
  _i_ fci:              %`fci-mode
  _o_ overwrite:        %`overwrite-mode
  _r_ rec-minibuf       %`enable-recursive-minibuffers
  _R_ read-only         %`buffer-read-only
"
  ("a" abbrev-mode)
  ("s" semantic-mode)
  ("T" semantic-stickyfunc-mode)
  ("d" toggle-debug-on-error)
  ("f" auto-fill-mode)
  ("h" (setq highlight-nonselected-windows (not highlight-nonselected-windows)))
  ("e" feebleline-mode)
  ("t" toggle-truncate-lines)
  ("y" flycheck-mode)
  ("h" hl-line-mode)
  ("H" helm-gtags-mode)
  ("w" whitespace-mode)
  ("l" linum-mode)
  ("i" fci-mode)
  ("o" overwrite-mode)
  ("r" (setq enable-recursive-minibuffers (not enable-recursive-minibuffers)))
  ("R" read-only-mode)
  ("RET" nil "quit")
  ("q" nil "quit"))

(require 'helm-gtags)
(defhydra hydra-gtags (:color yellow :columns 5)
  "gtags"

  ("q" nil                          "quit" :color blue)
  ("j" helm-gtags-previous-history  "back")
  ("k" helm-gtags-next-history      "fwd")
  ("t" helm-gtags-find-tag          "find tag")
  ("r" helm-gtags-find-rtag         "find ref")
  ("s" helm-gtags-show-stack        "show stack")
  ("y" helm-gtags-find-symbol       "find sym")
  ("d" helm-gtags-dwim              "dwim")
  ("f" helm-gtags-find-files        "find file")
  ("e" helm-gtags-resume            "resume")
  ("g" helm-gtags-find-pattern      "grep")
  ("p" helm-gtags-pop-stack         "pop")
  ("c" helm-gtags-create-tags       "create")

  ("R" helm-gtags-find-rtag-other-window)
  ("T" helm-gtags-find-tag-other-window)
  ("U" helm-gtags-update-tags       "update")
  ("A" fa-show                      "fa-show")
  ("S" helm-gtags-select            "select")
  ("F" helm-gtags--parsed-file      "parse")
  ("C" helm-gtags-clear-all-cache   "clear cache")
  )

(define-key helm-gtags-mode-map (kbd "C-t") nil)

(provide 'some-hydras)
;;; some-hydras.el ends here
