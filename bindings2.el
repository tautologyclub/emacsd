;; *** todo:
;;              wdired
;;              ace-window
;;              hippie-expand
;;              flyspell
;;
;;; multi-term: (eshell looks better though)
;;              smart way of getting C-x to the terminal
;;              separate key maps for linemode/charmode


(defun BIND-ME ())

(require 'helm)
(require 'ivy)
(require 'undo-tree)
(require 'projectile)
(require 'git-gutter+)
(require 'guide-key)

;; Unbind EVERYTHING. Almost.
(global-unset-key (kbd "M-r"))
(global-unset-key (kbd "M-c"))
(global-unset-key (kbd "M-s"))
(global-unset-key (kbd "M-k"))
(global-unset-key (kbd "M-p"))
(global-unset-key (kbd "C-x C-x"))
(global-unset-key (kbd "C-x m"))
(global-unset-key (kbd "C-x <backspace>"))
(global-unset-key (kbd "C-x DEL"))
(global-unset-key (kbd "C-S-q"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-S-<return>"))
(global-unset-key (kbd "C-x r"))
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "s-g"))
(global-unset-key (kbd "C-x C-v"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-x C-d"))
(global-unset-key (kbd "C-x +"))
(global-unset-key (kbd "C-x C-n"))
(global-unset-key (kbd "C-x C-o"))
(global-unset-key (kbd "C-x C-p"))
(global-unset-key (kbd "C-x #"))
(global-unset-key (kbd "C-x ("))
(global-unset-key (kbd "C-x )"))
(global-unset-key (kbd "C-x $"))
(global-unset-key (kbd "C-x 4"))
(global-unset-key (kbd "C-x 5"))
(global-unset-key (kbd "C-x 6"))
(global-unset-key (kbd "C-x 8"))
(global-unset-key (kbd "C-x C-e"))
(global-unset-key (kbd "C-x C-t"))
(global-unset-key (kbd "C-x ["))
(global-unset-key (kbd "C-x ]"))
(global-unset-key (kbd "C-x ="))
(global-unset-key (kbd "C-x {"))
(global-unset-key (kbd "C-x }"))
(global-unset-key (kbd "C-x ;"))
(global-unset-key (kbd "C-x ESC"))
(global-unset-key (kbd "C-<f10>"))
(global-unset-key (kbd "C-_"))


(eval-after-load "undo-tree-mode"
  (define-key undo-tree-map (kbd "C-x r") nil))
(eval-after-load "undo-tree-mode"
  (define-key undo-tree-map (kbd "C-_") nil))
(define-key prog-mode-map (kbd "TAB") 'indent-or-complete)


;; beautiful xcape hacks
(define-key key-translation-map (kbd "<f11>") (kbd "C-c"))               ;; todo
(global-set-key                 (kbd "<f10>") 'er/expand-region)
(global-set-key                 (kbd "<f9>") 'benjamin/jump-char-fwd)
(global-set-key                 (kbd "<S-f9>") 'benjamin/jump-char-bwd)
(global-set-key                 (kbd "C-<f9>") 'benjamin/set-mark-command)

;; (global-set-key      (kbd "<f12>") 'ivy-switch-buffer)
;; (global-set-key      (kbd "<f12>") nil)
;; (define-key helm-map            (kbd "<f11>") 'helm-keyboard-quit)
;; (define-key ivy-minibuffer-map  (kbd "<f11>") 'minibuffer-keyboard-quit)
;; (define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
;; (define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)

(global-set-key        (kbd "(")    'ora-parens)
(global-set-key        (kbd "[")    'blq/brackets)


;; --- 1-2-3 go ----------------------------------------------------------------
(global-set-key (kbd "M-s M-1")     (lambi (eshell 1)))
(global-set-key (kbd "M-s M-2")     (lambi (eshell 2)))
(global-set-key     (kbd "H-0")     'delete-other-windows)

(global-set-key      (kbd "C-q")    'left-word)
(global-set-key      (kbd "s-q")    'BIND-ME)                            ;; todo
(global-set-key      (kbd "M-q")    'benjamin/jump-char-bwd)
(global-set-key    (kbd "C-S-q")    'fill-paragraph)
(global-set-key    (kbd "C-x q")    'query-replace)
(global-set-key  (kbd "C-x S-q")    'query-replace-regexp)
(global-set-key  (kbd "M-s M-q")    (lambi (volatile-kill-buffer) (delete-window)))

(global-set-key     (kbd "C-w")     'kill-region)
(global-set-key     (kbd "s-w")     'BIND-ME)                            ;; todo
(global-set-key     (kbd "M-w")     'kill-ring-save)
(global-set-key     (kbd "H-w")     'find-file-other-window)
(global-set-key (kbd "M-s M-w")     (lambi (shell-command "~/.config/./split_optimal.sh") (call-interactively 'find-file-other-frame)))
(global-set-key   (kbd "C-S-w")     'my-i3-make-frame)

(global-set-key     (kbd "s-e")      nil)                            ;; reserved
(global-set-key     (kbd "C-e")     'xah-end-of-line-or-block)
(global-set-key     (kbd "M-e")     'forward-whitespace)
(global-set-key     (kbd "H-e")     'switch-to-buffer)
(global-set-key     (kbd "H-E")     'switch-to-buffer-other-window)
(global-set-key   (kbd "C-S-e")     'end-of-defun)                       ;; todo
(global-set-key   (kbd "C-M-e")     'elpy-nav-indent-shift-right)
(global-set-key   (kbd "C-x e")     'simplified-end-of-buffer)
(global-set-key (kbd "M-s M-e")     'eshell)
(global-set-key   (kbd "M-s e")      nil)
(global-set-key   (kbd "M-s eb")    'eval-buffer)
(global-set-key   (kbd "M-s er")    'eval-region)
(global-set-key   (kbd "M-s ed")    'eval-defun)
(global-set-key   (kbd "M-s ee")    'eval-expression)
(global-set-key   (kbd "C-c e")      nil)
(global-set-key   (kbd "C-c ef")    'ediff-files)
(global-set-key   (kbd "C-c eb")    'ediff-buffers)
(global-set-key   (kbd "C-c ed")    'ediff-directories)
(global-set-key   (kbd "C-c emf")   'ediff-merge-files)
(global-set-key   (kbd "C-c emb")   'ediff-merge-buffers)

(global-set-key       (kbd "s-r")    nil)                            ;; reserved
(global-set-key       (kbd "C-r")   'backward-delete-char)
(global-set-key       (kbd "M-r")   'benjamin/backward-kill-word)
(global-set-key       (kbd "H-r")   'backward-delete-char)
(global-set-key       (kbd "H-R")   'counsel-rg)
(global-set-key     (kbd "H-M-r")   'rgrep)
(global-set-key     (kbd "C-H-r")   'counsel-projectile-rg)
(global-set-key     (kbd "C-S-r")   'counsel-projectile-rg)
(global-set-key     (kbd "M-s r")   'counsel-git-grep)
(global-set-key     (kbd "C-x r")   'counsel-rg)
(global-set-key   (kbd "C-x C-r")   (lambi (revert-buffer nil t)))
(global-set-key (kbd "C-x C-S-r")   'rename-current-buffer-file)
(global-set-key   (kbd "C-x M-r")   'rename-buffer)

(global-set-key     (kbd "s-t")    nil)                              ;; reserved
(global-set-key     (kbd "C-t")   'transpose-chars)                      ;; todo
(global-set-key     (kbd "M-t")   'transpose-words)                      ;; todo
(global-set-key     (kbd "H-t")   'dropdown-multiterm)
(global-set-key     (kbd "H-T")   'multi-term)
(global-set-key   (kbd "C-S-t")   'hydra-toggle/body)
(global-set-key   (kbd "C-c t")   'transpose-params)
(global-set-key (kbd "M-s M-t")   'multi-term)

(global-set-key     (kbd "C-y")   'yank)
(global-set-key     (kbd "M-y")   'counsel-yank-pop)
(global-set-key     (kbd "H-y")   'BIND-ME)                              ;; todo
(global-set-key     (kbd "s-y")   'BIND-ME)                              ;; todo
(global-set-key   (kbd "C-S-y")   (lambi (yank) (exchange-point-and-mark)))
(global-set-key   (kbd "M-s y")   'bury-buffer)
(global-set-key       (kbd "υ")   'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-u")   'hydra-undo-tree/undo-tree-undo)
(global-set-key     (kbd "M-u")   'universal-argument)                   ;; todo
(global-set-key     (kbd "H-u")   'unfill-paragraph)
(global-set-key     (kbd "s-u")   'BIND-ME)                              ;; todo
(global-set-key   (kbd "C-S-u")   'upcase-word-toggle)
(global-set-key   (kbd "C-x u")   'undo-tree-visualize)
(global-set-key   (kbd "C-c u")   'unfill-paragraph)
(global-set-key (kbd "M-s M-u")   'sudo-edit-current)
(global-set-key       (kbd "ψ")   'universal-argument)

(global-set-key     (kbd "C-i")   'indent-or-complete)
(global-set-key     (kbd "M-i")   'counsel-imenu)
(global-set-key     (kbd "H-i")   'completion-at-point)
(global-set-key     (kbd "s-i")    nil)                              ;; reserved
(global-set-key   (kbd "C-S-i")   'tab-to-tab-stop)
(global-set-key   (kbd "H-M-i")   'my-increment-number-decimal)
(global-set-key   (kbd "C-x i")   'iedit-mode)
(global-set-key (kbd "M-s M-i")   'ivy-resume)
(global-set-key   (kbd "M-s i")   'my-increment-number-decimal)
(global-set-key       (kbd "ϊ")   'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-o")   'smart-open-line-above)
(global-set-key     (kbd "M-o")   'other-window-or-frame)                ;; todo
(global-set-key     (kbd "H-o")   'switch-to-buffer-other-window)        ;; todo
(global-set-key     (kbd "s-o")   'other-window-or-frame)
(global-set-key   (kbd "C-S-o")   'open-next-line)
(global-set-key (kbd "M-s M-o")   'projectile-find-other-file)
(global-set-key   (kbd "C-x o")   'occur-dwim)

(define-key projectile-mode-map (kbd "C-c p") nil)
(global-set-key     (kbd "C-p")   'projectile-command-map)
(global-set-key     (kbd "M-p")   'benjamin/pop-to-mark-command)
(global-set-key     (kbd "H-p")   (lambi (avy-push-mark)))
(global-set-key  (kbd "H-<f9>")   (lambi (avy-pop-mark)))
(global-set-key     (kbd "s-p")   'counsel-yank-pop)
(global-set-key   (kbd "H-M-p")   'BIND-ME)
(global-set-key   (kbd "C-S-p")   'async-shell-command)
(global-set-key   (kbd "C-c p")   'er/mark-paragraph)
(global-set-key   (kbd "C-c Ps")  'profiler-start)
(global-set-key   (kbd "C-c Pr")  'profiler-report)
(global-set-key   (kbd "C-c Pt")  'profiler-stop)
(global-set-key   (kbd "C-c Pe")  'profiler-reset)
(global-set-key   (kbd "C-x p")   'BIND-ME)

(global-set-key     (kbd "C-a")   'xah-beginning-of-line-or-block)
(global-set-key     (kbd "M-a")   (lambi (forward-whitespace -1)))
(global-set-key     (kbd "H-a")   'ace-window)
(global-set-key     (kbd "s-a")   'BIND-ME)                              ;; todo
(global-set-key   (kbd "C-S-a")   'beginning-of-defun)
(global-set-key   (kbd "C-x a")   'simplified-beginning-of-buffer)
(global-set-key   (kbd "C-c a")   'org-agenda)
(global-set-key      (kbd "ρ")    (lambi (insert "/")))
(global-set-key      (kbd "α")    (lambi (insert "*")))

(global-set-key     (kbd "C-s")   'counsel-grep-or-swiper)
(global-set-key     (kbd "H-s")   'BIND-ME)                              ;; todo
(global-set-key     (kbd "s-s")   'counsel-git-grep)
(global-set-key   (kbd "C-x s")   'save-buffer)
(global-set-key   (kbd "C-S-s")   'swiper-all)
(global-set-key   (kbd "C-S-s")   'helm-swoop)
(global-set-key   (kbd "C-M-s")   'save-buffer)
(global-set-key (kbd "M-s M-s")   'save-buffer)
(global-set-key       (kbd "β")   (lambi (insert "_")))

(global-set-key     (kbd "C-d")   'delete-char)
(global-set-key     (kbd "H-d")   'dropdown-multiterm)                   ;; TODO
(global-set-key     (kbd "H-d")   'delete-char)
(global-set-key     (kbd "M-d")   'benjamin/kill-word)
(global-set-key   (kbd "C-S-d")   'dropdown-multiterm)
(global-set-key (kbd "M-s M-d")   'delete-window)
(global-set-key   (kbd "M-s d")   'my-decrement-number-decimal)
(global-set-key   (kbd "C-x d")   'duplicate-current-line-or-region)
(global-set-key   (kbd "C-c dl")  'benjamin/laptop-mode)
(global-set-key   (kbd "C-c dd")  'benjamin/desktop-mode)
(global-set-key       (kbd "ε")   (lambi (insert ":")))
(global-set-key       (kbd "ζ")   (lambi (insert "&")))

(global-set-key     (kbd "C-f")   'right-word)
(global-set-key     (kbd "M-f")   'benjamin/jump-char-fwd)               ;; todo
(global-set-key     (kbd "s-f")   'find-file)                            ;; todo
(global-set-key     (kbd "H-f")   'find-file)
(global-set-key     (kbd "H-F")   'find-file-other-window)
(global-set-key   (kbd "C-S-f")   'find-file)                            ;; todo
(global-set-key (kbd "M-s M-f")   'find-file)                            ;; todo
(global-set-key (kbd "M-s C-f")   'benjamin/find-file-other-frame)
(global-set-key (kbd "C-c C-f")   'find-file-at-point)

(global-set-key   (kbd "C-S-g")   'goto-line-with-feedback)              ;; todo
(global-set-key     (kbd "M-g")   'avy-goto-char)
(global-set-key     (kbd "H-g")   'hydra-git-gutter/body)
(global-set-key     (kbd "s-g")   'hydra-git-gutter/body)                ;; todo
(global-set-key (kbd "M-s M-g")   'get-term)
(global-set-key   (kbd "C-x g")   'magit-status)
(global-set-key   (kbd "C-c g")   'helm-google)
(global-set-key   (kbd "M-s g")   'hydra-git-gutter/body)
(global-set-key       (kbd "γ")   (lambi (insert "?")))

(global-set-key     (kbd "C-h")   'backward-char)
(global-set-key     (kbd "M-h")   'er/mark-defun)                        ;; todo
(global-set-key     (kbd "H-h")   'backward-char)
(global-set-key   (kbd "C-S-h")   'er/mark-paragraph)
(global-set-key   (kbd "C-x h")    help-map)
(global-set-key   (kbd "C-c h")   'highlight-region)
(global-set-key   (kbd "C-c H")   'highlight-clear)
(global-set-key (kbd "M-s M-h")   'shell-command)
(global-set-key   (kbd "C-x hu")  'counsel-unicode-char)
(global-set-key   (kbd "C-x hb")  'counsel-descbinds)
(global-set-key       (kbd "η")   'ora-braces)

(global-set-key     (kbd "C-j")   'next-line)
(global-set-key     (kbd "H-j")   'newline-and-indent)
(global-set-key     (kbd "M-j")   'avy-goto-word-or-subword-0)
(global-set-key     (kbd "s-j")    nil)                              ;; reserved
(global-set-key   (kbd "C-S-j")   'avy-goto-word-or-subword-1)           ;; todo
(global-set-key   (kbd "C-x j")   (lambi (dired-jump) (hydra-dired/body)))
(global-set-key       (kbd "ι")   'move-text-down)

(global-set-key     (kbd "C-k")   'previous-line)
(global-set-key     (kbd "H-k")   'previous-line)
(global-set-key     (kbd "M-k")   'kill-line)
(global-set-key     (kbd "s-k")    nil)                              ;; reserved
(global-set-key   (kbd "C-S-k")   'kill-line-save)
(global-set-key   (kbd "H-M-k")   'volatile-kill-buffer)
(global-set-key   (kbd "C-x k")   'volatile-kill-buffer)
(global-set-key   (kbd "C-c k")    nil)
(global-set-key   (kbd "C-c ks")  'set-kblayout-swedish)
(global-set-key   (kbd "C-c kb")  'set-kblayout-benjamin)
(global-set-key       (kbd "κ")   'move-text-up)

(global-set-key     (kbd "C-l")   'forward-char)
(global-set-key     (kbd "M-l")   'goto-last-change)
(global-set-key     (kbd "H-l")   'forward-char)                         ;; todo
(global-set-key   (kbd "C-S-l")   'recenter-top-bottom)
(global-set-key   (kbd "C-x l")   'counsel-locate)
(global-set-key     (kbd "s-l")    nil)                              ;; reserved
(global-set-key       (kbd "ξ")   (lambi (insert "+")))

(global-set-key     (kbd "C-z")   'capitalize-word-toggle)
(global-set-key     (kbd "M-z")   'kill-line-save)
(global-set-key       (kbd "Ϗ")   'kill-line-save)

(global-set-key     (kbd "M-x")   'counsel-M-x)
(global-set-key       (kbd "χ")   'BIND-ME)                              ;; todo

(global-set-key   (kbd "C-S-c")   'compile)
(global-set-key (kbd "M-s M-c")   'compile)
(global-set-key     (kbd "H-c")   'compile)
(global-set-key     (kbd "s-c")   'kmacro-call-macro)
(global-set-key       (kbd "σ")   'comment-or-uncomment-region-or-line)

(global-set-key     (kbd "M-v")   'hydra-vimish-fold/body)
(global-set-key     (kbd "H-v")   'yank)                                 ;; todo
(global-set-key     (kbd "s-v")   'counsel-yank-pop)
(global-set-key     (kbd "C-v")   (lambi (forward-line 30)))
(global-set-key   (kbd "C-S-v")   (lambi (forward-line -30)))

(global-set-key     (kbd "C-b")   'switch-to-buffer)                     ;; todo
(global-set-key     (kbd "M-b")   'hydra-errgo/previous-error)
(global-set-key     (kbd "H-b")   'switch-to-buffer-other-window)
(global-set-key   (kbd "C-S-b")   'benjamin/jump-char-bwd)               ;; todo
(global-set-key   (kbd "C-x b")   'browse-url)
(global-set-key   (kbd "M-s b")   'counsel-bookmark)
(global-set-key (kbd "M-s M-b")   'counsel-bookmark)
(global-set-key       (kbd "」")  'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-n")   'lispy-forward)                        ;; TODO
(global-set-key     (kbd "M-n")   'hydra-errgo/next-error)
(global-set-key     (kbd "H-n")   'mc/mark-next-like-this)
(global-set-key   (kbd "C-S-n")   'lispy-forward)                        ;; todo
(global-set-key   (kbd "M-s n")   'hydra-nav/body)
(global-set-key       (kbd "ν")   'hydra-nav/body)

(define-key input-decode-map [?\C-m] [C-m])
(global-set-key    (kbd "<C-m>")  (lambi (call-interactively 'er/expand-region)
                                    (call-interactively 'er/expand-region)))
(global-set-key     (kbd "M-m")   'counsel-mark-ring)
(global-set-key     (kbd "s-m")   'helm-man-woman)
(global-set-key     (kbd "H-m")   'hydra-toggle/body)
(global-set-key   (kbd "C-S-m")   'er/contract-region)
(global-set-key   (kbd "C-c m")   'er/mark-defun)
(global-set-key   (kbd "M-s m")   'kmacro-start-macro)
(global-set-key (kbd "M-s M-m")   'kmacro-end-macro)
(global-set-key       (kbd "μ")   'BIND-ME)                              ;; todo

(global-set-key (kbd "C-,")     'set-mark-and-deactive)
(global-set-key (kbd "C-.")     'exchange-point-and-mark)
(global-set-key (kbd "C->")     'hs-toggle-hiding)

(global-set-key (kbd "C--")     'previous-buffer)
(global-set-key (kbd "C-=")     'next-buffer)
(global-set-key (kbd "H--")     'previous-buffer)
(global-set-key (kbd "H-=")     'next-buffer)
(global-set-key (kbd "M--")     'zoom-frm-out)
(global-set-key (kbd "M-=")     'zoom-frm-in)
(global-set-key (kbd "C-H--")   'my-decrement-number-decimal)
(global-set-key (kbd "C-H-=")   'my-increment-number-decimal)
(global-set-key (kbd "C-_")     (lambi (shrink-window 5)))
(global-set-key (kbd "C-+")     (lambi (enlarge-window 5)))

(global-set-key (kbd "M-<tab>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-s SPC") 'shell-command)
(global-set-key (kbd "C-<f8>")  'benjamin/set-mark-command)

(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "<H-return>")      'get-term)
(global-set-key (kbd "<H-backspace>")   (lambi (volatile-kill-buffer)
                                               (delete-window)))

;; guide-key
(guide-key-mode 1)
(setq guide-key/guide-key-sequence '("s-p" "M-c" "s-g" "C-t" "C-c" "C-x"
                                     "M-s" "μ" "C-p"))
(setq guide-key/idle-delay 0.66)
(setq guide-key/recursive-key-sequence-flag t)
