;; *** Todo:
;;              smart way of getting C-x to the terminal
;;              separate key maps for linemode/charmode
;;              wdired

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
(define-key prog-mode-map (kbd "TAB") 'indent-or-company-complete) ;; meeehh


;; beautiful xcape hacks
(global-set-key (kbd "<f8>")    (lambda () (interactive) (insert ";")))
(global-set-key (kbd "<S-f8>")  (lambda () (interactive) (insert ":")))
(global-set-key (kbd "<f9>")    'benjamin/jump-char-fwd)
(global-set-key (kbd "<S-f9>")  'benjamin/jump-char-bwd)
(global-set-key (kbd "<f10>")   'er/expand-region)
(global-set-key (kbd "<f11>")   'counsel-projectile)
(global-set-key (kbd "<f12>")   'ivy-switch-buffer)

(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f11>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)

(global-set-key (kbd "(")       'ora-parens)


;; (keyboard-translate ?\C-q ?\C-c) ;; meh
(global-set-key      (kbd "C-q")    'left-word)
(global-set-key    (kbd "C-S-q")    'shell-command) ;; ...
(global-set-key      (kbd "M-q")    'benjamin/jump-char-bwd)
(global-set-key    (kbd "C-x q")    'query-replace)
(global-set-key  (kbd "C-x S-q")    'query-replace-regexp)
(global-set-key  (kbd "M-s M-q")     (lambda () (interactive)
                                       (volatile-kill-buffer)
                                       (delete-window)))

(global-set-key     (kbd "C-w")     'kill-region)
(global-set-key   (kbd "C-S-w")     'my-i3-make-frame)
(global-set-key     (kbd "M-w")     'kill-ring-save)

(global-set-key     (kbd "C-e")     'xah-end-of-line-or-block)
(global-set-key     (kbd "M-e")     'forward-whitespace)
(global-set-key   (kbd "C-S-e")     'end-of-defun)
(global-set-key   (kbd "C-M-e")     'elpy-nav-indent-shift-right)
(global-set-key   (kbd "C-x e")     'simplified-end-of-buffer)
(global-set-key       (kbd "϶")     (lambda () (interactive) (insert "|")))
(global-set-key       (kbd "|")     (lambda () (interactive)
                                      (message "Use ;-e instead!")
                                      (insert "|")))
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

(global-set-key       (kbd "C-r")   'backward-delete-char)
(global-set-key     (kbd "C-S-r")   'benjamin/backward-kill-word)        ;; todo
(global-set-key       (kbd "M-r")   'benjamin/backward-kill-word)
(global-set-key       (kbd "s-r")   'counsel-projectile-rg)
(global-set-key     (kbd "M-s r")   'counsel-git-grep)
(global-set-key     (kbd "C-x r")   'counsel-rg)
(global-set-key   (kbd "C-x C-r")   (lambda () (interactive)
                                      (revert-buffer nil t)))
(global-set-key (kbd "C-x C-S-r")   'rename-current-buffer-file)
(global-set-key   (kbd "C-x M-r")   'rename-buffer)

(global-set-key     (kbd "C-t")   'transpose-chars)
(global-set-key   (kbd "C-S-t")   (lambda () (interactive)
                                  (transpose-chars -1)))
(global-set-key     (kbd "M-t")   'transpose-words)
(global-set-key   (kbd "C-c t")   'transpose-params)
(global-set-key   (kbd "M-s t")   'hydra-toggle/body)
(global-set-key (kbd "M-s M-t")   'multi-term)

(global-set-key     (kbd "C-y")   'yank)
(global-set-key   (kbd "C-S-y")   (lambda () (interactive)
                                    (yank)
                                    (exchange-point-and-mark)))
(global-set-key     (kbd "M-y")   'counsel-yank-pop)
(global-set-key   (kbd "M-s y")   'bury-buffer)
(global-set-key       (kbd "υ")   'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-u")   'hydra-undo-tree/undo-tree-undo)
(global-set-key   (kbd "C-S-u")   'upcase-word-toggle)
(global-set-key     (kbd "M-u")   'universal-argument)                   ;; todo
(global-set-key   (kbd "C-x u")   'undo-tree-visualize)
(global-set-key   (kbd "C-c u")   'unfill-paragraph)
(global-set-key (kbd "M-s M-u")   'sudo-edit-current)
(global-set-key       (kbd "ψ")   'universal-argument)

(global-set-key   (kbd "C-S-i")   'tab-to-tab-stop)
(global-set-key     (kbd "M-i")   'counsel-imenu)
(global-set-key   (kbd "C-x i")   'iedit-mode)
(global-set-key (kbd "M-s M-i")   'ivy-resume)
(global-set-key   (kbd "M-s i")   'my-increment-number-decimal)
(global-set-key     (kbd "s-i")    nil)                              ;; reserved
(global-set-key       (kbd "ϊ")   'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-o")   'smart-open-line-above)
(global-set-key   (kbd "C-S-o")   'open-next-line)
(global-set-key     (kbd "M-o")   'other-window-or-frame)
(global-set-key (kbd "M-s M-o")   'projectile-find-other-file)
(global-set-key   (kbd "C-x o")   'occur-dwim)

(global-set-key     (kbd "C-p")   'newline-and-indent)                     ;; ??
(global-set-key   (kbd "C-S-p")   'shell-command)
(global-set-key     (kbd "M-p")   'benjamin/pop-to-mark-command)
(global-set-key     (kbd "s-p")   'projectile-command-map)
(global-set-key   (kbd "C-c ps")  'profiler-start)
(global-set-key   (kbd "C-c pt")  'profiler-stop)
(global-set-key   (kbd "C-x p")   'mark-paragraph)

(global-set-key     (kbd "C-a")   'xah-beginning-of-line-or-block)
(global-set-key   (kbd "C-S-a")   'beginning-of-defun)
(global-set-key     (kbd "M-a")   (lambda () (interactive)
                                    (forward-whitespace -1)))
(global-set-key   (kbd "C-x a")   'simplified-beginning-of-buffer)
(global-set-key   (kbd "C-c a")   'org-agenda)
(global-set-key      (kbd "ρ")   (lambda () (interactive) (insert "/")))
(global-set-key      (kbd "/")   (lambda () (interactive)
                                   (message "Use ;-a instead!")
                                   (insert "/")))

(global-set-key     (kbd "C-s")   'swiper)
(global-set-key   (kbd "C-S-s")   'swiper-all)
(global-set-key     (kbd "s-s")   'kmacro-start-macro)
(global-set-key     (kbd "s-S")   'kmacro-end-macro)
(global-set-key (kbd "M-s M-s")   'save-buffer)
(global-set-key       (kbd "β")   (lambda () (interactive) (insert "_")))
(global-set-key       (kbd "_")   (lambda () (interactive)
                                    (message "Use ;-s instead!")
                                    (insert "_")))

(global-set-key     (kbd "C-d")   'delete-char)
(global-set-key   (kbd "C-S-d")   'benjamin/kill-word)                   ;; todo
(global-set-key     (kbd "M-d")   'benjamin/kill-word)
(global-set-key (kbd "M-s M-d")   'delete-window)
(global-set-key   (kbd "C-x d")   'duplicate-current-line-or-region)
(global-set-key   (kbd "M-s d")   'my-decrement-number-decimal)
(global-set-key       (kbd "ε")   'ora-quotes)

(global-set-key     (kbd "C-f")   'right-word)
(global-set-key   (kbd "C-S-f")   'benjamin/jump-char-fwd)
(global-set-key     (kbd "M-f")   'benjamin/jump-char-fwd)
(global-set-key (kbd "M-s M-f")   'counsel-find-file)
(global-set-key (kbd "C-c C-f")   'find-file-at-point)
(global-set-key       (kbd "ώ")   (lambda () (interactive) (insert ":")))

(global-set-key   (kbd "C-S-g")   'goto-line-with-feedback)
(global-set-key     (kbd "M-g")   'avy-goto-char)
(global-set-key (kbd "M-s M-g")   'get-term)
(global-set-key   (kbd "C-x g")   'magit-status)
(global-set-key   (kbd "C-c g")   'helm-google)
(global-set-key     (kbd "s-g")   'hydra-git-gutter/body)
(global-set-key   (kbd "M-s g")   'hydra-git-gutter/body)
(global-set-key       (kbd "γ")   (lambda () (interactive) (insert "?")))
(global-set-key       (kbd "?")   (lambda () (interactive)
                                    (message "Use ;-g instead!")
                                    (self-insert-command 1)))

(global-set-key     (kbd "C-h")   'backward-char)
(global-set-key   (kbd "C-S-h")   'er/mark-paragraph)
(global-set-key     (kbd "M-h")   'er/mark-defun)
(global-set-key   (kbd "C-c h")   'highlight-region)
(global-set-key   (kbd "C-c H")   'highlight-clear)
(global-set-key (kbd "M-s M-h")   'shell-command)
(global-set-key   (kbd "C-x h")    help-map)
(global-set-key   (kbd "C-x h u") 'counsel-unicode-char)
(global-set-key   (kbd "C-x h b") 'counsel-descbinds)
(global-set-key       (kbd "η")   'ora-braces)

(global-set-key     (kbd "C-j")   'next-line)
(global-set-key   (kbd "C-S-j")   'avy-goto-word-1)                      ;; todo
(global-set-key     (kbd "M-j")   'avy-goto-word-1)
(global-set-key   (kbd "C-x j")   (lambda () (interactive)
                                    (dired-jump)
                                    (hydra-dired/body)))
(global-set-key     (kbd "s-j")    nil)                              ;; reserved
(global-set-key       (kbd "ι")   'elpy-nav-move-line-or-region-down)

(global-set-key     (kbd "C-k")   'previous-line)
;; (global-set-key   (kbd "C-S-k")   'kill-line)                         ;; TODO
(global-set-key     (kbd "M-k")   'kill-line)
(global-set-key   (kbd "C-x k")   'volatile-kill-buffer)
(global-set-key   (kbd "C-c k")    nil)
(global-set-key   (kbd "C-c ks")  'set-kblayout-swedish)
(global-set-key   (kbd "C-c kb")  'set-kblayout-benjamin)
(global-set-key     (kbd "s-k")    nil)                              ;; reserved
(global-set-key       (kbd "κ")   'elpy-nav-move-line-or-region-up)

(global-set-key     (kbd "C-l")   'forward-char)
(global-set-key   (kbd "C-S-l")   'recenter-top-bottom)
(global-set-key     (kbd "M-l")   'goto-last-change)
(global-set-key   (kbd "C-x l")   'counsel-locate)
(global-set-key     (kbd "s-l")    nil)                              ;; reserved
(global-set-key       (kbd "ξ")   (lambda () (interactive) (insert "+")))
(global-set-key       (kbd "+")   (lambda () (interactive)
                                    (message "use ;-l instead!")
                                    (insert "+")))

(global-set-key     (kbd "C-z")   'capitalize-word-toggle)
(global-set-key     (kbd "M-z")   'kill-line-save)
(global-set-key       (kbd "Ϗ")   'kill-line-save)


(global-set-key     (kbd "M-x")   'counsel-M-x)
(global-set-key       (kbd "χ")   'BIND-ME)                              ;; todo

(global-set-key   (kbd "C-S-c")   'comment-or-uncomment-region-or-line)  ;; todo
(global-set-key (kbd "M-s M-c")   'compile)
(global-set-key     (kbd "s-c")   'kmacro-call-macro)
(global-set-key       (kbd "σ")   'comment-or-uncomment-region-or-line)

(global-set-key     (kbd "C-v")   (lambda () (interactive)
                                    (forward-line 25)))
(global-set-key   (kbd "C-S-v")   (lambda () (interactive)
                                    (forward-line -25)))
(global-set-key     (kbd "M-v")   'hydra-vimish-fold/body)

(global-set-key     (kbd "C-b")   'left-word)                            ;; todo
(global-set-key   (kbd "C-S-b")   'benjamin/jump-char-bwd)               ;; todo
(global-set-key     (kbd "M-b")   'hydra-errgo/previous-error)           ;; todo
(global-set-key   (kbd "C-x b")   'browse-url)
(global-set-key   (kbd "M-s b")   'counsel-bookmark)
(global-set-key       (kbd "」")  'BIND-ME)                              ;; todo

(global-set-key     (kbd "C-n")   'lispy-forward)                        ;; TODO
(global-set-key   (kbd "C-S-n")   'lispy-forward)                        ;; TODO
(global-set-key     (kbd "M-n")   'hydra-errgo/next-error)
(global-set-key       (kbd "ν")   'BIND-ME)                              ;; todo

(define-key input-decode-map [?\C-m] [C-m])
(global-set-key    (kbd "<C-m>")  (lambda () (interactive)
                                    (call-interactively 'er/expand-region)
                                    (call-interactively 'er/expand-region)))
(global-set-key   (kbd "C-S-m")   'er/contract-region)
(global-set-key     (kbd "M-m")   'counsel-mark-ring)
(global-set-key   (kbd "C-c m")   'mark-defun)
(global-set-key     (kbd "s-m")   'helm-man-woman)
(global-set-key       (kbd "μ")   'projectile-command-map)
(global-set-key   (kbd "M-s m")   'kmacro-start-macro)
(global-set-key (kbd "M-s M-m")   'kmacro-end-macro)


;; misc.
(global-set-key (kbd "M-<tab>") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,")     'set-mark-and-deactive)
(global-set-key (kbd "C-.")     'exchange-point-and-mark)
(global-set-key (kbd "C-<f9>")  'benjamin/set-mark-command)
(global-set-key (kbd "C--")     'previous-buffer)
(global-set-key (kbd "C-=")     'next-buffer)
(global-set-key (kbd "C->")     'hs-toggle-hiding)
(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "M--")     'zoom-frm-out)
(global-set-key (kbd "M-=")     'zoom-frm-in)
;; pretty good, but rebind:
(global-set-key (kbd "C-M-_")   (lambda () (interactive)           ;; [C-M-S-\-]
                                  (shrink-window 5)))
(global-set-key (kbd "C-M-+")   (lambda () (interactive)           ;; [C-M-S-\=]
                                  (enlarge-window 5)))


;; guide-key
(guide-key-mode 1)
(setq guide-key/guide-key-sequence '("s-p" "M-c" "s-g" "C-t" "C-c" "C-x"
                                     "M-s" "μ"))
(setq guide-key/idle-delay 0.66)
(setq guide-key/recursive-key-sequence-flag t)
