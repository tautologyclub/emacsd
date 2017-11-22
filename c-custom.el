(require 'semantic)
(require 'company)
(require 'cc-mode)
(require 'helm-gtags)
(require 'gud)

(defun c-occur-overview ()
  "Display an occur buffer with declarations/definitions/etc.

Also, switch to that buffer."
  (interactive)
  (let ((list-matching-lines-face nil))
    (occur "^[a-z].*("))
  (let ((window (get-buffer-window "*Occur*")))
    (if window
        (select-window window)
      (switch-to-buffer "*Occur*"))))


;; (semantic-add-system-include "/home/benjamin/workspace/" 'c-mode)
(setq-default c-basic-offset 4)

(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

(defhydra hydra-gud (:color amaranth)
  "
"
  ("g" gdb :color blue)
  ;; vi
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)
  ("l" forward-char)
  ;; gud
  ("t" gud-tbreak )
  ("b" gud-break "break")
  ("l" gud-remove "clear")
  ("p" gud-print)
  ("m" gud-until "move")
  ("n" gud-next "next")
  ("N" gud-nexti "nexti")
  ("c" gud-cont "cont")
  ("M-c" compile "compile")
  ("M-r" recompile "recompile")
  ("o" gud-finish "out")
  ("r" gud-run "run")
  ("s" gud-step "step")
  ("u" gud-up "up")
  ("d" gud-down "down")
  ("w" gud-watch "watch")
  ("z" switch-to-gud-cmd "cmd")
  ("X" (lambda () (interactive)
         (gud-basic-call "quit")
         (delete-window)) :color blue
          "exit")
  ("iv"  (gud-basic-call "info variables") "info")

  ("<up>" windmove-up)
  ("<down>" windmove-down)
  ("<left>" windmove-left)
  ("<left>" windmove-right)
  ("q" nil "quit"))

;; note: gud-basic-cmd

(define-key c-mode-base-map (kbd "M-e") nil)
(define-key c-mode-base-map (kbd "M-a") nil)
(define-key c-mode-base-map (kbd "M-j") nil)
(define-key c-mode-base-map (kbd "C-M-j") nil)
(define-key c-mode-base-map (kbd "C-M-k") nil)
(define-key c-mode-base-map (kbd "M-.") 'helm-gtags-dwim)
(define-key c-mode-base-map (kbd "C-c f") 'helm-flycheck)
(define-key c-mode-base-map (kbd "C-c o") 'c-occur-overview)
(define-key c-mode-base-map (kbd "C-c C-c") 'compile)
(define-key c-mode-base-map (kbd "C-c C-w") 'senator-kill-tag)

(define-key c-mode-base-map (kbd "M-c") 'hydra-gud/body)
(define-key gud-mode-map (kbd "M-c") 'hydra-gud/body)

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
