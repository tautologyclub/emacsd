
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

  ;; locals
  (windmove-right)
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

(defadvice gud-find-file (before what-the-fuck activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (setq split-height-threshold 0)
   (setq split-width-threshold 0)))

;----- Sweet gdb-hydra below ---------------------------------------------------

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

(require 'gud)
(defhydra hydra-gdb (:color amaranth
                     :hint nil
                     ;; :pre (setq hydra-is-helpful nil)
                     ;; :post (setq hydra-is-helpful t)
                     )
  "gdb"
  ;; ("?"      (lambda () (interactive)
  ;;             (if 'hydra-is-helpful
  ;;                 (setq hydra-is-helpful nil)
  ;;               (setq hydra-is-helpful t))))
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

  ("m"      (select-gdb-source-then-do 'gud-jump)   "jump")
  ("n"      (select-gdb-comint-then-do 'gud-next)   "next")
  ("c"      (select-gdb-comint-then-do 'gud-cont)   "continue")
  ("o"      (select-gdb-comint-then-do 'gud-finish) "out")
  ("r"      (select-gdb-comint-then-do 'gud-run)    "run")
  ("s"      (select-gdb-comint-then-do 'gud-step)   "step")
  ("i"      (select-gdb-comint-then-do 'gud-stepi)  "stepi")
  ("U"      (select-gdb-source-then-do 'gud-until)  "until")
  ("u"      (select-gdb-comint-then-do 'gud-up)     "up")
  ("d"      (select-gdb-comint-then-do 'gud-down)   "down")

  ("C"      compile "compile")
  ("N"      (select-gdb-comint-then-do 'gud-nexti)  "next instr")
  ("X"      (lambda () (interactive)
              (gud-basic-call "quit")
              (select-window gdb-comint-window)
              (delete-window)
              (delete-other-windows)) :color blue
              "exit")

  ("D"     (gdb-display-in-transient 'gdb-disassembly-buffer) "disassembly")
  ("L"     (gdb-display-in-transient 'gdb-locals-buffer) "locals")
  ("R"     (gdb-display-in-transient 'gdb-registers-buffer) "regs")
  ("M"     (gdb-display-in-transient 'gdb-memory-buffer) "memory")
  ("B"     (gdb-display-in-transient 'gdb-breakpoints-buffer) "breaks")
  ("I"     (gdb-display-in-transient 'gdb-inferior-io) "io")
  ("S"     (gdb-display-in-transient 'gdb-stack-buffer) "stack")
  ("TT"    (gdb-display-in-transient 'gdb-threads-buffer) "threads")
  ("TL"    (gdb-display-in-transient 'gdb-locals-for-threads-buffer))
  ("TS"    (gdb-display-in-transient 'gdb-stack-for-thread-buffer))
  ("TR"    (gdb-display-in-transient 'gdb-registers-for-thread-buffer))
  ("TD"    (gdb-display-in-transient 'gdb-disassembly-for-thread-buffer))

  ("P"      (select-gdb-source-then-do 'previous-buffer) "prev src")
  ("F"      (select-gdb-source-then-do 'next-buffer) "next src")
  ("bm"     (gud-basic-call "b main")                       "b. main")
  ("bs"     (gud-basic-call "save breakpoints .gdb_breaks")  "save") ;; todo
  ("bl"     (gud-basic-call "source .gdb_breaks")            "load") ;; todo
  ("DEL"    gud-remove  "clear")

  ("<up>"       windmove-up)
  ("<down>"     windmove-down)
  ("<left>"     windmove-left)
  ("<right>"    windmove-right)

  ("q"      nil))

(defun gdb-display-in-transient (gdb-buffer-arg)
  "Ladidiaada GDB-BUFFER-ARG."
  (set-window-dedicated-p gdb-transient-window nil)
  (set-window-buffer gdb-transient-window (gdb-get-buffer-create gdb-buffer-arg))
  (select-window gdb-comint-window)
  )
