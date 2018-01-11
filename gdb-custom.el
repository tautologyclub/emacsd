
(require 'gud)
(require 'gdb-mi)

;; notes
;; gdb-stop-subjob
;; switch-to-buffer setq switch-to-buffer-in-dedicated-window
;; display-buffer-reuse-window


;;; Code:
(setq gdb-display-io-nopopup t)

(defvar gdb-comint-window nil)
(defun benjamin/gdb-setup-windows1 ()
  "Layout the window pattern for option `gdb-many-windows'."
  (set-frame-parameter nil 'fullscreen 'fullboth)   ;; set fullscreen

  (gdb-get-buffer-create 'gdb-locals-buffer)
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)

  ;; window splits
  (let ((win0 (selected-window))                                ;; source
        (win1 (split-window nil ( / (* (window-height) 9) 10) )) ;; callstack
        (win2 (split-window nil ( / (* (window-height) 6) 7)))  ;; comint
        )                            ;; right col

    ;; source windows
    ;; (select-window win2)
    (set-window-buffer
     win0
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (set-window-dedicated-p (selected-window) t)

    ;; callstack
    (select-window win1)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (let ((win5 (split-window-right ( / (* (window-width) 1) 3) )))
      (gdb-set-window-buffer
       (if gdb-show-threads-by-default
           (gdb-threads-buffer-name)
         (gdb-locals-buffer-name))
       nil win5)
      (select-window win5)
    )
    (let ((win6 (split-window-right)))
      (gdb-set-window-buffer (if gdb-show-threads-by-default
                                 (gdb-threads-buffer-name)
                               (gdb-breakpoints-buffer-name))
                               ;; (gdb-locals-buffer-name))
                             nil win6))

    (select-window win2)
    (set-window-dedicated-p (selected-window) t)

    (setq gdb-comint-window (selected-window))
    (let ((win4 (split-window-right)))
      (gdb-set-window-buffer
       (gdb-get-buffer-create 'gdb-inferior-io) nil win4)))

  )

(defvar gdb-transient-window)
(defvar gdb-callstack-window)
(defvar gdb-breakpoints-window)
(defvar gdb-locals-window)
(defun benjamin/gdb-setup-windows2 ()
  "Layout the window pattern for option `gdb-many-windows'."
  (set-frame-parameter nil 'fullscreen 'fullboth)   ;; set fullscreen

  (gdb-get-buffer-create 'gdb-locals-buffer)
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (gdb-get-buffer-create 'gdb-inferior-io)

  (delete-other-windows)

  ;; source
  (setq gdb-source-window (selected-window))
  (split-window nil ( / (* (window-height) 5) 7) )
  (set-window-buffer
     gdb-source-window
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
  (set-window-dedicated-p (selected-window) nil)

  ;; comint
  (windmove-down)
  (switch-to-buffer gud-comint-buffer)
  (setq gdb-comint-window (selected-window))
  (set-window-dedicated-p (selected-window) t)

  ;; transient window (io by def)
  (select-window gdb-source-window)
  (split-window-right)
  (windmove-right)
  (setq gdb-transient-window (selected-window))
  (gdb-set-window-buffer (gdb-inferior-io-name) nil (selected-window))
  (set-window-dedicated-p (selected-window) nil)

  ;; callstack
  (select-window gdb-comint-window)
  (split-window-right ( / (* (window-width) 1) 3))
  (windmove-right)
  (gdb-set-window-buffer (gdb-stack-buffer-name) nil (selected-window))
  (setq gdb-callstack-window (selected-window))
  (split-window-right)

  ;; bpts
  (windmove-right)
  (gdb-set-window-buffer (gdb-breakpoints-buffer-name) nil (selected-window))
  (setq gdb-breakpoints-window (selected-window))
  (split-window-below)

  ;; locals
  (windmove-down)
  (gdb-set-window-buffer (gdb-locals-buffer-name) nil (selected-window))
  (setq gdb-locals-window (selected-window))

  (select-window gdb-comint-window)
  )

(defun gdb-setup-windows ()
  "Overwrite the original gdb-setup-windows."
  ;; (benjamin/gdb-setup-windows1))
  (benjamin/gdb-setup-windows2))


(defun benjamin/gud-hook ()
  "Debugger customizations."
  (gud-tooltip-mode)
  )
(add-hook 'gud-mode-hook 'benjamin/gud-hook)
(define-key gud-mode-map (kbd "M-o") 'ace-window)

;----- Sweet gdb-hydra below ---------------------------------------------------
(defun benjamin/gdb-toggle-disassembly ()
  (interactive)

  )

(defun select-gdb-comint-then-do (arg)
  (interactive)
  (select-window gdb-comint-window)
  (call-interactively arg)
  )

(defun select-gdb-source-then-do (arg)
  (interactive)
  (select-window gdb-source-window)
  (call-interactively arg)
  )

(defhydra hydra-gdb (:color pink
                            :hint nil
                            ;; :pre (setq hydra-is-helpful nil)
                            ;; :post (setq hydra-is-helpful t)
                            )
  "gdb"
  ("g"      gdb "gdb")

  ("h"      (select-gdb-source-then-do 'left-word) )
  ("j"      (select-gdb-source-then-do 'next-line) )
  ("k"      (select-gdb-source-then-do 'previous-line) )
  ("l"      (select-gdb-source-then-do 'right-word) )
  ("a"      (select-gdb-source-then-do 'xah-beginning-of-line-or-block))
  ("e"      (select-gdb-source-then-do 'xah-end-of-line-or-block))

  ("t"      (select-gdb-source-then-do 'gud-tbreak) )
  ("SPC"    (select-gdb-source-then-do 'gud-break)   "brk")
  ("p"      (select-gdb-source-then-do 'gud-print)   "p")
  ("w"      (select-gdb-source-then-do 'gud-watch)   "watch")

  ("m"      (select-gdb-comint-then-do 'gud-jump)   "jump")
  ("n"      (select-gdb-comint-then-do 'gud-next)   "next")
  ("c"      (select-gdb-comint-then-do 'gud-cont)   "continue")
  ("o"      (select-gdb-comint-then-do 'gud-finish) "out")
  ("r"      (select-gdb-comint-then-do 'gud-run)    "run")
  ("s"      (select-gdb-comint-then-do 'gud-step)   "step")
  ("u"      (select-gdb-comint-then-do 'gud-up)      "up")
  ("d"      (select-gdb-comint-then-do 'gud-down)    "down")

  ("C"      compile "compile")
  ("U"      (select-gdb-comint-then-do 'gud-until)  "until")
  ("N"      (select-gdb-comint-then-do 'gud-nexti)  "next instr")
  ("R"     recompile "recompile")
  ("X"      (lambda () (interactive)
              (gud-basic-call "quit")
              (select-window gdb-comint-window)
              (delete-window)
              (delete-other-windows)) :color blue
              "exit")

  ("yd"     (select-gdb-comint-then-do 'gdb-display-disassembly-buffer) "disass.")
  ("yr"     (select-gdb-comint-then-do 'gdb-display-registers-buffer) "regs")
  ("ym"     (select-gdb-comint-then-do 'gdb-display-memory-buffer) "mem")
  ("yt"     (select-gdb-comint-then-do 'gdb-display-threads-buffer) "threads")
  ("yl"     (select-gdb-comint-then-do 'gdb-display-locals-for-thread-buffer) "thr locs")
  ("yb"     (select-gdb-comint-then-do 'gdb-display-breakpoints-buffer) "bpts")
  ("yi"     (select-gdb-comint-then-do 'gdb-display-io-buffer) "io")
  ("ys"     (select-gdb-comint-then-do 'gdb-display-stack-buffer) "stack")
  ("yk"     (select-gdb-comint-then-do 'gdb-display-stack-for-thread-buffer) "thr stack")
  ("yg"     (select-gdb-comint-then-do 'gdb-display-registers-for-thread-buffer) "thr regs")
  ("yy"     (select-gdb-comint-then-do 'gdb-display-disassembly-for-thread-buffer) "thr dis")

  ("P"      previous-buffer "prev-buffer")
  ("iv"     (gud-basic-call "info variables"))
  ("ir"     (gud-basic-call "info registers"))
  ("bm"     (gud-basic-call "b main")                       "b. main")
  ("bs"     (gud-basic-call "save breakpoints .gdb_breaks")  "save")
  ("bl"     (gud-basic-call "source .gdb_breaks")            "load")
  ("DEL"     gud-remove  "clear")

  ("<up>"    windmove-up)
  ("<down>"    windmove-down)
  ("<left>"    windmove-left)
  ("<right>"    windmove-right)

  ("q"      nil))
