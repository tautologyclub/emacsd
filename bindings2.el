;;; package --- Summary: lolo
;;; Commentary:
;;; lolol
;;; Code:
;;; lolol
;;; ------------------------
;;; narrow-to-*
;;; crux-kill-line-backwards
;;; crux-indent-defun
;;; crux-duplicate-and-comment-current-line-or-region
;;; crux-eval-and-replace
;;; crux-insert-date
;;; crux-with-region-or-line
;;; visual-regex
;;; (set (make-local-variable 'comment-auto-fill-only-comments) t)


(require 'helm)
(require 'projectile)
(global-set-key (kbd "TAB") 'indent-or-complete)

;; beautiful xcape hacks
(global-set-key       (kbd "<f9>") 'backward-delete-char-untabify)
(global-set-key     (kbd "<S-f9>") 'delete-char)
(global-set-key     (kbd "C-<f9>") 'benjamin/set-mark-command)
(global-set-key     (kbd "H-<f9>") 'switch-to-buffer)
(global-set-key      (kbd "<f10>") 'er/expand-region)

;; todo
(global-set-key      (kbd "<f11>") 'dabbrev-expand)
(global-set-key      (kbd "<f11>") 'universal-argument)
(global-set-key      (kbd "<f11>") 'delete-char)
(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(global-set-key    (kbd "C-<f11>") 'switch-to-buffer)

(global-set-key (kbd "M-<f12>") 'delete-char)
(global-set-key (kbd "M-SPC")   'find-file)
(global-set-key (kbd "M-RET")   'delete-char)
(global-set-key (kbd "H-SPC")   'find-file)
(global-set-key (kbd "M-<tab>") 'mc/mark-next-like-this)

(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "<H-return>")      'dropdown-multiterm)
(global-set-key (kbd "<H-M-return>")    'dropdown-multiterm-right)
(global-set-key (kbd "<H-backspace>")   'murder-buffer-with-window)
(global-set-key (kbd "C-<return>")      'open-line-below)

(global-set-key      (kbd "C-;")  'switch-to-buffer)
(global-set-key      (kbd "C-'")  'find-file)
(global-set-key      (kbd "C-:")  'find-file)

;; these all are garb
(global-set-key      (kbd "M-'")  'BIND-ME)
(global-set-key      (kbd "H-;")  'benjamin/helm-buffers-list)                 ;
(global-set-key      (kbd "H-'")  'BIND-ME)
(global-set-key       (kbd "䑄")  'switch-to-buffer)                         ;-'

;; In case I accidentally left swedish keyboard layout on
(global-set-key (kbd "C-å")      (lambi (benjamin/notify "Switching keyboard layout...")
                                        (call-process "xcape-restart" nil 0 nil)
                                        (benjamin/set-mark-command)))
(global-set-key (kbd "H-å")      (lambi (benjamin/notify "Switching keyboard layout...")
                                        (call-process "xcape-restart" nil 0 nil)
                                        (call-interactively 'switch-to-buffer)))

(global-set-key        (kbd "(")    'ora-parens)
(global-set-key        (kbd "[")   'ora-brackets)

(global-set-key     (kbd "H-0")     'delete-other-windows)
(global-set-key     (kbd "H-3")     'BIND-ME)

(define-key key-translation-map (kbd "C-q") (kbd "C-c"))
(global-set-key      (kbd "s-q")    'quoted-insert)
(global-set-key      (kbd "M-q")    'left-word)
(global-set-key    (kbd "C-S-q")    'fill-paragraph)
(global-set-key    (kbd "C-x q")    'query-replace)
(global-set-key        (kbd "Ŀ")    'BIND-ME)

(global-set-key     (kbd "s-w")      nil)
(global-set-key     (kbd "C-w")     'kill-region-or-line)
(global-set-key     (kbd "H-w")     'kill-region)
(global-set-key     (kbd "s-w")     'BIND-ME)                                  ;
(global-set-key     (kbd "M-w")     'kill-ring-save)
(global-set-key   (kbd "H-M-w")     'find-file-other-window)                   ;
(global-set-key   (kbd "C-S-w")     'my-i3-make-frame)                         ;
(global-set-key (kbd "C-x M-w")     'copy-current-file-path)
(global-set-key (kbd "M-s M-w")     'rotate-windows)

(global-set-key     (kbd "C-e")     'end-of-line-or-block)
(global-set-key     (kbd "s-e")      nil)
(global-set-key     (kbd "M-e")     'forward-whitespace)
(global-set-key     (kbd "H-e")     "qe")
(global-set-key   (kbd "C-S-e")     'end-of-defun)
(global-set-key   (kbd "H-M-e")     'replace-last-sexp)
(global-set-key   (kbd "C-M-e")     'elpy-nav-indent-shift-right)
(global-set-key   (kbd "C-x e")     'simplified-end-of-buffer)
(global-set-key   (kbd "M-s e")      nil)
(global-set-key   (kbd "M-s eb")    'eval-buffer)
(global-set-key   (kbd "M-s er")    'eval-region)
(global-set-key   (kbd "M-s ed")    'eval-defun)
(global-set-key   (kbd "M-s ee")    'eval-expression)
(global-set-key   (kbd "C-c e")      nil)
(global-set-key   (kbd "C-c ef")    'ediff-files)
(global-set-key   (kbd "C-c eb")    'ediff-buffers)
(global-set-key   (kbd "C-c ec")    'ediff-current-buffer)
(global-set-key   (kbd "C-c ed")    'ediff-directories)
(global-set-key   (kbd "C-c emf")   'ediff-merge-files)
(global-set-key   (kbd "C-c emb")   'ediff-merge-buffers)

(global-set-key       (kbd "s-r")    nil)
(global-set-key       (kbd "M-r")   'backward-kill-word)
(global-set-key       (kbd "C-r")   'kill-symbol-at-point)
(global-set-key       (kbd "H-r")   'kill-word-at-point)
(global-set-key       (kbd "H-R")   'counsel-rg)
(global-set-key     (kbd "H-M-r")   'kill-sexp-at-point)                       ;
(global-set-key     (kbd "C-H-r")   'counsel-projectile-rg)
(global-set-key     (kbd "C-S-r")   'hungry-delete-backward)
(global-set-key     (kbd "M-s r")   'replace-last-sexp)                        ;
(global-set-key     (kbd "C-x r")   'counsel-rg)
(global-set-key   (kbd "C-x C-r")   (lambi (revert-buffer nil t)))
(global-set-key (kbd "C-x C-S-r")   'rename-current-buffer-file)
(global-set-key   (kbd "C-x M-r")   'rename-buffer)
(global-set-key     (kbd "C-c ra")  'clear-text-properties-from-buffer)
(define-key isearch-mode-map (kbd "H-r") 'isearch-repeat-backward)

(global-set-key     (kbd "C-t")    ctl-x-map)
(global-set-key     (kbd "s-t")    nil)
(global-set-key     (kbd "H-t")   'multi-term)
(global-set-key     (kbd "M-t")   (lambi (forward-char 2)(transpose-words -1)))
(global-set-key     (kbd "M-T")   (lambi (forward-char 1)(transpose-words 1))) ;
(global-set-key   (kbd "C-S-t")   'multi-term)                                 ;
(global-set-key   (kbd "C-c t")   'transpose-params)
(global-set-key   (kbd "H-M-t")   'counsel-term-switch)
(global-set-key (kbd "C-x C-t")   'multi-term)

(global-set-key     (kbd "C-y")   (lambi (benjamin/notify "Use H-i dude")))    ;
(global-set-key     (kbd "M-y")   'counsel-yank-pop)
(global-set-key     (kbd "H-y")   'bury-buffer)                                ;
(global-set-key     (kbd "s-y")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-S-y")   (lambi (yank) (exchange-point-and-mark)))    ;
(global-set-key   (kbd "H-M-y")   'bury-buffer)
(global-set-key       (kbd "υ")   'BIND-ME)

(global-set-key     (kbd "M-u")   'universal-argument)
(global-set-key     (kbd "C-u")   'kill-to-beginning-of-indentation-or-line)
(global-set-key     (kbd "H-u")   "qu")
(global-set-key     (kbd "s-u")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-S-u")   'upcase-word-toggle)
(global-set-key   (kbd "C-x u")   'undo-tree-visualize)
(global-set-key   (kbd "C-c u")   'unfill-paragraph)
(global-set-key   (kbd "M-s u")   'sudo-edit-current)
(global-set-key (kbd "M-s M-u")   'sudo-find-file)
(global-set-key       (kbd "ψ")   'universal-argument)

(global-set-key     (kbd "C-i")   'indent-or-complete)
(global-set-key     (kbd "H-i")   'yank)
(global-set-key     (kbd "H-I")   'counsel-yank-pop)
(global-set-key     (kbd "M-i")   'counsel-imenu)
(global-set-key     (kbd "s-i")    nil)
(global-set-key   (kbd "C-S-i")   'tab-to-tab-stop)
(global-set-key   (kbd "H-M-i")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-x i")   'iedit-mode)
(global-set-key   (kbd "C-c i")   'ivy-resume)
;-i == *

(global-set-key     (kbd "C-o")   'smart-open-line-above)
(global-set-key     (kbd "M-o")   'other-window)
(global-set-key     (kbd "H-o")   'undo-tree-undo)
(global-set-key   (kbd "C-S-o")   'comment-or-uncomment-region-or-line)
;; (global-set-key   (kbd "C-M-o")   'new-line-in-between)
(global-set-key   (kbd "H-M-o")   'projectile-find-other-file)                 ;
(global-set-key (kbd "M-s M-o")   'projectile-find-other-file-other-window)
(global-set-key   (kbd "C-x o")   'occur-dwim)
(global-set-key (kbd "C-x C-o")   'occur-dwim)
;-o == <backspace>                                                             ;

(define-key projectile-mode-map (kbd "C-c p") nil)
(global-set-key     (kbd "C-p")   'projectile-command-map)
(global-set-key     (kbd "M-p")   'benjamin/pop-to-mark-command)
(global-set-key     (kbd "H-p")   'undo-tree-redo)
(global-set-key     (kbd "s-p")   'counsel-yank-pop)                           ;
(global-set-key   (kbd "C-S-p")   'async-shell-command)                        ;
(global-set-key   (kbd "H-M-p")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-c p")   'er/mark-paragraph)
(global-set-key   (kbd "C-c Ps")  'profiler-start)
(global-set-key   (kbd "C-c Pr")  'profiler-report)
(global-set-key   (kbd "C-c Pt")  'profiler-stop)
(global-set-key   (kbd "C-c Pe")  'profiler-reset)
(global-set-key   (kbd "C-x p")   'BIND-ME)

(global-set-key     (kbd "C-a")   'beginning-of-line-or-block)
(global-set-key     (kbd "M-a")   (lambi (forward-whitespace -1)))
(global-set-key     (kbd "H-a")   'ace-window)                                 ;
(global-set-key     (kbd "s-a")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-S-a")   'beginning-of-defun)
(global-set-key   (kbd "C-M-a")   'elpy-nav-indent-shift-left)
(global-set-key   (kbd "C-x a")   'simplified-beginning-of-buffer)
(global-set-key   (kbd "C-c a")   'org-agenda)
;-a == /

(global-set-key     (kbd "s-s")    nil)
(global-set-key     (kbd "C-s")   'counsel-grep-or-swiper)
(global-set-key   (kbd "C-x s")   'save-buffer)
(global-set-key     (kbd "H-s")   'isearch-forward)                            ;
(global-set-key   (kbd "C-S-s")   'swiper-all)
(global-set-key   (kbd "M-s s")   'org-store-link)
(global-set-key   (kbd "C-c sd")  (lambi (let ((helm-full-frame t))
                                           (helm-systemd))))
(global-set-key   (kbd "H-M-s")   (lambi (benjamin/notify "Use C-c C-s")))
(global-set-key (kbd "M-s M-s")   'save-buffer)
(define-key isearch-mode-map (kbd "H-s") 'isearch-repeat-forward)
;-s == _

(global-set-key     (kbd "C-d")   'delete-char)
(global-set-key     (kbd "H-d")   'duplicate-current-line-or-region)           ;
(global-set-key     (kbd "M-d")   'kill-word)
(global-set-key   (kbd "H-M-d")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-S-d")   'hungry-delete-forward)
(global-set-key   (kbd "M-s d")   'duplicate-current-line-or-region)
(global-set-key (kbd "M-s M-d")   'duplicate-current-line-or-region)
(global-set-key   (kbd "C-x d")   'duplicate-current-line-or-region)           ;
;-d == :

(global-set-key     (kbd "H-f")   'avy-goto-word-or-subword-1)
(global-set-key     (kbd "M-f")   'right-word)
(global-set-key     (kbd "s-f")   'find-file)
(global-set-key     (kbd "C-f")   'avy-goto-char-in-line)
(global-set-key   (kbd "C-x f")   'hydra-flycheck/body)
(global-set-key   (kbd "C-M-f")   'forward-sexp)
(global-set-key   (kbd "C-s-f")   'find-file)
(global-set-key   (kbd "H-M-f")   'find-file-at-point)
(global-set-key (kbd "M-s M-f")   'find-file)
(global-set-key (kbd "C-(")      (lambi (fastnav-search-char-forward 1 ?( )))  ;; cool
(global-set-key (kbd "C-)")      (lambi (fastnav-search-char-forward 1 ?) )))  ;; cool
(global-set-key (kbd "M-s C-f")   'benjamin/find-file-other-frame)
;-f == (

(global-set-key     (kbd "H-g")   'benjamin/get-term)                          ;
(global-set-key     (kbd "s-g")   'hydra-git-gutter/body)
(global-set-key     (kbd "M-g")   'goto-line-with-feedback)
(global-set-key   (kbd "H-M-g")   'avy-goto-line)
(global-set-key   (kbd "C-M-g")   'avy-goto-line)                              ;
(global-set-key   (kbd "C-S-g")   'hydra-git-gutter/body)
(global-set-key (kbd "M-s M-g")   'magit-status)
(global-set-key   (kbd "M-s g")   'magit-status)
(global-set-key   (kbd "C-x g")   'magit-status)                               ;
(global-set-key   (kbd "C-c g")   'helm-google)
(global-set-key   (kbd "M-s g")   'magit-status)
;-g == ?

(global-set-key     (kbd "H-h")    help-map)
(global-set-key     (kbd "C-h")   'backward-char)
(global-set-key     (kbd "M-h")   'hs-toggle-hiding)
(global-set-key   (kbd "H-M-h")   'hs-hide-all)
(global-set-key   (kbd "H-M-H")   'hs-show-all)
(global-set-key   (kbd "C-S-h")   'er/mark-paragraph)
(global-set-key   (kbd "C-x h")    help-map)
(global-set-key   (kbd "C-c h")   (lambi (hlt-highlight) (deactivate-mark)))
(global-set-key   (kbd "C-c H")   'hlt-unhighlight-region)
(global-set-key   (kbd "H-h u")   'counsel-unicode-char)
(global-set-key   (kbd "H-h b")   'counsel-descbinds)
;-h == {

(global-set-key     (kbd "s-j")    nil)
(global-set-key     (kbd "C-j")   'next-line)
(global-set-key     (kbd "H-j")   'backward-char)                              ;
(global-set-key     (kbd "M-j")   'hippie-expand)
(global-set-key   (kbd "C-S-j")   'move-text-down)
(global-set-key   (kbd "H-M-j")   'BIND-ME)                                    ;
(global-set-key   (kbd "C-x j")   (lambi (dired-jump) (hydra-dired/body)))
;-j == "

(global-set-key     (kbd "s-k")    nil)
(global-set-key     (kbd "C-k")   'previous-line)
(global-set-key     (kbd "H-k")   'kill-inner)
(global-set-key     (kbd "M-k")   'kill-line-save)
(global-set-key   (kbd "C-S-k")   'move-text-up)
(global-set-key   (kbd "H-M-k")   'volatile-kill-buffer)
(global-set-key   (kbd "C-x k")   'volatile-kill-buffer)
;-k == '

(global-set-key     (kbd "s-l")    nil)
(global-set-key     (kbd "C-l")   'forward-char)
(global-set-key     (kbd "H-l")   'recenter-top-bottom)
(global-set-key     (kbd "M-l")   'goto-last-change)
(global-set-key   (kbd "H-M-l")   'goto-last-change-reverse)
(global-set-key   (kbd "C-S-l")   'elpy-nav-indent-shift-right)                ;
(global-set-key   (kbd "C-x l")   'counsel-locate)
(global-set-key   (kbd "M-s l")   'counsel-locate)
(global-set-key (kbd "M-s M-l")   'org-store-link)
;-l == +

(global-set-key     (kbd "C-z")   'capitalize-word-toggle)
(global-set-key     (kbd "M-z")   'kill-line-save)                             ;
(global-set-key       (kbd "Ϗ")   'kill-line-save)                           ;-z

(global-set-key     (kbd "M-x")   'counsel-M-x)
(global-set-key       (kbd "χ")   'BIND-ME)                                    ;

(global-set-key     (kbd "H-c")   'compile)                                    ;
(global-set-key     (kbd "s-c")   'kmacro-call-macro)
(global-set-key   (kbd "C-S-c")   'comment-or-uncomment-region-or-line)
(global-set-key   (kbd "H-M-c")   'BIND-ME)                                    ;
(global-set-key (kbd "M-s M-c")   'compile)
(global-set-key       (kbd "σ")   (lambi (benjamin/notify "Use C-S-c")))     ;-c

(global-set-key     (kbd "M-v")   'hydra-vimish-fold/body)                     ;
(global-set-key     (kbd "H-v")   (lambi (forward-line -30)))                  ;
(global-set-key     (kbd "s-v")   'counsel-yank-pop)                           ;
(global-set-key     (kbd "C-v")   (lambi (forward-line 30)))                   ;
(global-set-key   (kbd "C-S-v")   (lambi (forward-line -30)))                  ;

(global-set-key     (kbd "M-b")   'hydra-errgo/previous-error)
(global-set-key     (kbd "H-b")   'switch-to-buffer-other-window)              ;
(global-set-key     (kbd "C-b")   'counsel-bookmark)
(global-set-key   (kbd "H-M-b")   'switch-to-buffer-other-window)              ;
(global-set-key   (kbd "C-S-b")   'counsel-bookmark-current-buffer-file)
(global-set-key   (kbd "C-c b")   'create-scratch-buffer)
(global-set-key   (kbd "C-x b")   'browse-url)
(global-set-key   (kbd "M-s b")   'helm-chrome-bookmarks)
(global-set-key       (kbd "」")  'BIND-ME)

(global-set-key     (kbd "C-n")   'benjamin/helm-buffers-list)
(global-set-key     (kbd "M-n")   'hydra-errgo/next-error)                     ;
(global-set-key     (kbd "H-n")   'goto-next-line-with-same-indentation)       ;
(global-set-key   (kbd "H-M-n")   'hydra-errgo/next-error)                     ;
(global-set-key       (kbd "ν")   (lambi (insert "&")))
(global-set-key   (kbd "C-S-n")   'lispy-forward)                        ;; todo
(global-set-key       (kbd "ν")   "&")

(global-set-key     (kbd "M-m")   'counsel-mark-ring)
(global-set-key     (kbd "s-m")   'helm-man-woman)
(global-set-key     (kbd "H-m")   'hydra-toggle/body)
(global-set-key   (kbd "C-S-m")   'mark-line)
(global-set-key   (kbd "C-c m")   'er/mark-defun)
(global-set-key   (kbd "M-s m")   'kmacro-start-macro)
(global-set-key (kbd "M-s M-m")   'kmacro-end-macro)
(global-set-key   (kbd "H-M-m")   'kmacro-call-macro)
(global-set-key       (kbd "μ")   "$")

(global-set-key (kbd "H-,")     'goto-prev-line-with-same-indentation)
(global-set-key (kbd "H-.")     'goto-next-line-with-same-indentation)
(global-set-key (kbd "C-,")     'set-mark-and-deactive)
(global-set-key (kbd "C-.")     'exchange-point-and-mark)
(global-set-key (kbd "C->")     (lambi (forward-line 40)))
(global-set-key (kbd "C-<")     (lambi (forward-line -40)))

(global-set-key (kbd "C--")     'benjamin/previous-buffer)
(global-set-key (kbd "C-=")     'benjamin/next-buffer)
(global-set-key (kbd "M--")     'zoom-frm-out)
(global-set-key (kbd "M-=")     'zoom-frm-in)
(global-set-key (kbd "C-H--")   'my-decrement-number-decimal)
(global-set-key (kbd "C-H-=")   'my-increment-number-decimal)
(global-set-key (kbd "C-_")     (lambi (shrink-window 5)))
(global-set-key (kbd "C-+")     (lambi (enlarge-window 5)))
;; (global-set-key (kbd "H--")     'undo-tree-undo)
;; (global-set-key (kbd "H-=")     'undo-tree-redo)


;; misc mode mappings
(define-key help-mode-map (kbd "q")   'murder-buffer-with-window)


;
