(setq c-default-style "linux" c-basic-offset 4)
;; (setq c-default-style "python")
(require 'semantic)
(require 'company)
(require 'cc-mode)
(require 'helm-gtags)
(require 'gud)

;; Note -- don't forget ~/.gdbinit add-to-save-path stuff

(defun c-occur-overview ()
  "Display an occur buffer with declarations/definitions/etc.

Also, resize somewhat. Really hacky :D"
  (interactive)
  (let ((list-matching-lines-face nil))
    (occur "^[a-z].*("))
  (enlarge-window 25)
  (hydra-errgo/body)
  )


(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(require 'semantic/bovine/c)
(add-to-list 'semantic-lex-c-preprocessor-symbol-file
             "/usr/lib/clang/5.0.0/include/stddef.h")

(defhydra hydra-gdb (:color amaranth :columns 5 :hint nil)
  "gdb"
  ("g"      gdb blue"gdb")

  ("h"      backward-char )
  ("j"      next-line )
  ("k"      previous-line )
  ("l"      forward-char )

  ("t"      gud-tbreak )
  ("SPC"    gud-break   "break")
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
  ("bl"     gud-remove  "clear")

  ("C-a"    xah-beginning-of-line-or-block)
  ("C-e"    xah-end-of-line-or-block)

  ("M-c"    compile "compile")
  ("M-r"    recompile "recompile")

  ("C-p"    previous-buffer "prev-buffer")
  ("C-k"    windmove-up)
  ("C-j"    windmove-down)
  ("C-h"    windmove-left)
  ("C-l"    windmove-right)

  ("X"      (lambda () (interactive)
              (gud-basic-call "quit")
              (delete-window)) :color blue
              "exit")
  ("q"      nil "quit hydra"))


(defun benjamin/flycheck-list-errors ()
  "List errors in a separate window, decrease the size."
  (interactive)
  (flycheck-list-errors)
  (enlarge-window 25)
  (hydra-errgo/body))

(define-key c-mode-base-map (kbd "M-e") nil)
(define-key c-mode-base-map (kbd "M-a") nil)
(define-key c-mode-base-map (kbd "M-j") nil)
(define-key c-mode-base-map (kbd "C-M-a") nil)
(define-key c-mode-base-map (kbd "C-M-e") nil)
(define-key c-mode-base-map (kbd "C-M-j") nil)
(define-key c-mode-base-map (kbd "C-M-k") nil)
(define-key c-mode-base-map (kbd "M-.") 'helm-gtags-dwim)
(define-key c-mode-base-map (kbd "C-c o") 'c-occur-overview)
(define-key c-mode-base-map (kbd "C-c C-c") 'compile)
(define-key c-mode-base-map (kbd "C-c C-w") 'senator-kill-tag)
(define-key c-mode-map (kbd "C-c f") 'benjamin/flycheck-list-errors)

(define-key c-mode-base-map (kbd "M-c") 'hydra-gdb/body)
(define-key gud-mode-map (kbd "M-c") 'hydra-gdb/body)

(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(defun benjamin/c-hook ()
  "You know.  My hook and stuff."
  (subword-mode)
  ;; (semantic-stickyfunc-mode)
  (auto-fill-mode)
  (flycheck-mode)
  (helm-gtags-mode)
  (irony-mode)
  (company-mode)
  )
(add-hook 'c-mode-hook 'benjamin/c-hook)
(add-hook 'c++-mode-hook 'flycheck-mode)

(setenv "GTAGSLIBPATH" "/home/benjamin/.gtags/")
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (setenv "GTAGSLIBPATH" "$GTAGSLIBPATH:~/workspace/reac/inc/")
              (helm-gtags-mode 1))))

(require 'company)
(setq company-backends
                 '((
                    company-irony
                    ;; company-semantic
                    company-files
                    company-cmake
                    ;; company-keywords
                    ;; company-gtags
                    company-capf
                    )))
;; fixme make company mode-local










    ;; (setq gdb-many-windows nil)

    ;; (defun set-gdb-layout(&optional c-buffer)
    ;;   (if (not c-buffer)
    ;;       (setq c-buffer (window-buffer (selected-window)))) ;; save current buffer

    ;;   ;; from http://stackoverflow.com/q/39762833/846686
    ;;   (set-window-dedicated-p (selected-window) nil) ;; unset dedicate state if needed
    ;;   (switch-to-buffer gud-comint-buffer)
    ;;   (delete-other-windows) ;; clean all

    ;;   (let* (
    ;;          (w-source (selected-window)) ;; left top
    ;;          (w-gdb (split-window w-source nil 'right)) ;; right bottom
    ;;          (w-locals (split-window w-gdb nil 'above)) ;; right middle bottom
    ;;          (w-stack (split-window w-locals nil 'above)) ;; right middle top
    ;;          (w-breakpoints (split-window w-stack nil 'above)) ;; right top
    ;;          (w-io (split-window w-source (floor(* 0.9 (window-body-height)))
    ;;                              'below)) ;; left bottom
    ;;          )
    ;;     (set-window-buffer w-io (gdb-get-buffer-create 'gdb-inferior-io))
    ;;     (set-window-dedicated-p w-io t)
    ;;     (set-window-buffer w-breakpoints (gdb-get-buffer-create 'gdb-breakpoints-buffer))
    ;;     (set-window-dedicated-p w-breakpoints t)
    ;;     (set-window-buffer w-locals (gdb-get-buffer-create 'gdb-locals-buffer))
    ;;     (set-window-dedicated-p w-locals t)
    ;;     (set-window-buffer w-stack (gdb-get-buffer-create 'gdb-stack-buffer))
    ;;     (set-window-dedicated-p w-stack t)

    ;;     (set-window-buffer w-gdb gud-comint-buffer)

    ;;     (select-window w-source)
    ;;     (set-window-buffer w-source c-buffer)
    ;;     ))
    ;; (defadvice gdb (around args activate)
    ;;   "Change the way to gdb works."
    ;;   (let (
    ;;         (c-buffer (window-buffer (selected-window))) ;; save current buffer
    ;;         )
    ;;     ad-do-it
    ;;     (set-gdb-layout c-buffer))
    ;;   )

;; ;; useless
;; (defun switch-to-gud-cmd () (interactive)
;;        (dolist (buffer (buffer-list))
;;          (let ((name (buffer-name buffer)))
;;            (when (and name (not (string-equal name ""))
;;                       (string-match "^\\*gud" name))
;;              (switch-to-buffer buffer)))))

;; (defun gud-focus-cmd-buffer ()
;;   (interactive)
;;   (while )
;;   (dolist (buffer (buffer-list))
;;     (let ((name (buffer-name buffer)))
;;       (when (and name (not (string-equal name ""))
;;                  (string-match "^\\*gud" name))
;;         (switch-to-buffer buffer)))))

;; (setq irony-additional-clang-options
;;       (quote
;;        ("-I/home/benjamin/workspace/reac/inc"
;;         "-std=c90"
;;         "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init="
;;         "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__"
;;         "-D __ARL78__" "-D __CORE__=__RL78_1__")))
