
(defhydra hydra-text (:color pink :columns 5 :hint nil)
  "gdb"
  ("g"      gdb blue"gdb")
  ("r"      gdb-restore-windows "restore")

  ("h"      backward-char )
  ("j"      next-line )
  ("k"      previous-line )
  ("l"      forward-char )

  ("t"      gud-tbreak )
  ("SPC"    gud-break   "break")
  ("l"      gud-remove  "clear")
  ("p"      gud-print   "print ")
  ("m"      gud-until   "move")
  ("n"      gud-next    "next")
  ("N"      gud-nexti   "next instr")
  ("c"      gud-cont    "continue")
  ("o"      gud-finish  "out")
  ("r"      gud-run     "run")
  ("s"      gud-step    "step")
  ("u"      gud-up      "up")
  ("d"      gud-down    "down")
  ("w"      gud-watch   "watch")    ;; todo completing read

  ("iv"     (gud-basic-call "info variables")               "info vars")
  ("ir"     (gud-basic-call "info registers")               "info regs")
  ("bm"     (gud-basic-call "b main")                       "break main")
  ("bs"     (gud-basic-call "save breakpoints .gdb_breaks")  "save breaks")
  ("bl"     (gud-basic-call "source .gdb_breaks")            "load breaks")

  ("C-a"    xah-beginning-of-line-or-block)
  ("C-e"    xah-end-of-line-or-block)

  ("M-c"    compile "compile")
  ("M-r"    recompile "recompile")

  ("C-k"    windmove-up)
  ("C-j"    windmove-down)
  ("C-h"    windmove-left)
  ("C-l"    windmove-right)

  ("X"      (lambda () (interactive)
              (gud-basic-call "quit")
              (delete-window)) :color blue
              "exit")
  ("q"      nil "quit hydra"))

;; I heart abo-abo
(require 'hideshow)
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

;; This is garbage
(defhydra hydra-undo-tree (:color red
                                  :hint nil
                                  )
  "
  _C-u_/_j_: undo  _C-n_/_k_: redo _s_: save _l_: load   "
  ("j"   undo-tree-undo)
  ("C-u"   undo-tree-undo)
  ("C-n"   undo-tree-redo)
  ("k"   undo-tree-redo)
  ("s"   undo-tree-save-history)
  ("l"   undo-tree-load-history)
  ("v"   undo-tree-visualize "visualize" :color blue)
  ("q"   nil "quit" :color blue))

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

;; lol
(defhydra hydra-weird-chars (:hint nil)
  "
"
  ;; ("q"   (lambda () (interactive) (insert "[]")(backward-char)) :color blue)
  ("<f8>"   (lambda () (interactive) (insert "ö")) :color blue)
  ("<f9>"   (lambda () (interactive) (insert "å")) :color blue)
  ("'"   (lambda () (interactive) (insert "ä")) :color blue)
  ("ESC" nil "quit" :color blue)
  )

(defhydra hydra-errgo (:hint nil)
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


(defhydra hydra-toggle (:color pink :hint nil)
  "
_a_ abbrev-mode:       %`abbrev-mode
_d_ debug-on-error:    %`debug-on-error
_f_ auto-fill-mode:    %`auto-fill-function
_h_ highlight          %`highlight-nonselected-windows
_t_ truncate-lines:    %`truncate-lines
_y_ flycheck-mode      %`flycheck-mode
_w_ whitespace-mode:   %`whitespace-mode
_l_ linum-mode:        %`linum-mode
_i_ fci:               %`fci-mode
_o_ overwrite-mode     %`overwrite-mode
_r_ read-only-mode
"
  ("a" abbrev-mode)
  ("d" toggle-debug-on-error)
  ("f" auto-fill-mode)
  ("h" (setq highlight-nonselected-windows (not highlight-nonselected-windows)))
  ("t" toggle-truncate-lines)
  ("y" flycheck-mode)
  ("w" whitespace-mode)
  ("l" linum-mode)
  ("i" fci-mode)
  ("o" overwrite-mode)
  ("r" read-only-mode)
  ("q" nil "quit"))
