;; *** Todo:
;;              smart way of getting C-x to the terminal
;;              separate key maps for linemode/charmode!
;;              repeat-command on next line
;;              dired?
;;              ivy-restrict-to-matches

;; *** Todo bindings:
;;              C-u
;;              C-z
;;              C-m
;;              C-m
;;              M-q
;;              M-h
;;              M-z
;;              M-v
;;              M-s ...
;;              C-x ...
;;              C-c ...
;;              C-t ...

(require 'helm)
(require 'ivy)
(require 'undo-tree)
(require 'projectile)
(require 'git-gutter+)
(require 'guide-key)

;; unbind
(global-unset-key (kbd "M-r")) ;; useless
(global-unset-key (kbd "M-c")) ;; useless
(global-unset-key (kbd "M-s")) ;; useless
(global-unset-key (kbd "M-k")) ;; useless
(global-unset-key (kbd "M-p"))
(global-unset-key (kbd "C-x C-x"))
(global-unset-key (kbd "C-x m"))  ;; e-mail is annoying
(global-unset-key (kbd "C-x <backspace>"))
(global-unset-key (kbd "C-x DEL"))  ;; easy to accidentally call
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
(global-unset-key (kbd "C-<f10>"))

;; C-q is nicer than C-c. Quoted insert moved somewhere else
(keyboard-translate ?\C-q ?\C-c)



(eval-after-load "undo-tree-mode"
  (define-key undo-tree-map (kbd "C-x r") nil))
(eval-after-load "undo-tree-mode"
  (define-key undo-tree-map (kbd "C-_") nil))


;; beautiful xcape hacks
(global-set-key (kbd "<f8>") (lambda () (interactive) (insert ";")))  ;; todo
(global-set-key (kbd "<S-f8>") (lambda () (interactive) (insert ":")))  ;; todo
(global-set-key (kbd "<f9>") 'hydra-nav/body)
(global-set-key (kbd "<f10>") 'er/expand-region)
(global-set-key (kbd "<f11>") 'counsel-projectile)
(global-set-key (kbd "<f12>") 'benjamin/helm-buffers-list)
;; (global-set-key (kbd "<f12>") 'set-mark-command)

(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f11>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)

(global-set-key (kbd "(") 'ora-parens)
(global-set-key (kbd "θ") 'ora-parens)
;; (global-set-key (kbd "[") 'ora-brackets)
;; (global-set-key (kbd "Ρ") 'ora-braces)
(global-set-key (kbd "ψ") 'universal-argument)                      ;; Mode_shift + u


;; C
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-e") 'xah-end-of-line-or-block)
    (global-set-key (kbd "C-S-e") (lambda () (interactive)
                                    (benjamin/set-mark-command)
                                    (xah-end-of-line-or-block)))
(global-set-key (kbd "C-r") 'backward-delete-char)
    (global-set-key (kbd "C-S-r") 'hungry-delete-backward)
(global-set-key (kbd "C-t") nil)
    (global-set-key (kbd "C-t t") 'multi-term)
    (global-set-key (kbd "C-t g") 'get-term)
    (global-set-key (kbd "C-t d") 'terminal-with-focus-below)
    (global-set-key (kbd "C-t p") 'projectile-get-term)
    (global-set-key (kbd "C-t e") 'eshell)
(global-set-key (kbd "C-y") 'yank)
;; (global-set-key (kbd "C-u") 'duplicate-current-line-or-region)          ;; todo
;; (global-set-key (kbd "C-i) nil)
    (global-set-key (kbd "C-S-i") 'tab-to-tab-stop)
(global-set-key (kbd "C-o") 'smart-open-line-above)
(global-set-key (kbd "C-p") 'hippie-expand)                            ;; toeval

(global-set-key (kbd "C-a") 'xah-beginning-of-line-or-block)
    (global-set-key (kbd "C-S-a") (lambda () (interactive)
                                    (benjamin/set-mark-command)
                                    (xah-beginning-of-line-or-block)))
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-d") 'delete-char)
(global-set-key (kbd "C-S-d") 'hungry-delete-forward)
(global-set-key (kbd "C-f") 'benjamin/jump-char-fwd)
(global-set-key (kbd "C-g") 'keyboard-quit)
    (global-set-key (kbd "C-S-g") 'goto-line-with-feedback)
(global-set-key (kbd "C-h") 'backward-char)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'forward-char)

(global-set-key (kbd "C-z") 'bury-buffer)
;; (global-set-key (kbd "C-x") nil)
;; (global-set-key (kbd "C-c") nil)
(global-set-key (kbd "C-v") 'hydra-vimish-fold/body)
(global-set-key (kbd "C-S-v") 'vimish-fold)
(global-set-key (kbd "C-b") 'benjamin/jump-char-bwd)
(global-set-key (kbd "C-n") 'lispy-forward)                         ;; todo
;; (global-set-key (kbd "C-m") nil)                                 ;; todo

(global-set-key (kbd "C-,") 'set-mark-and-deactive)
(global-set-key (kbd "C-.") 'exchange-point-and-mark-and-deactive)
(global-set-key (kbd "C-/") nil)


;; M
;; (global-set-key (kbd "M-q") nil)                                     ;; todo
(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key (kbd "M-e") 'forward-char)
(global-set-key (kbd "M-r") 'benjamin/backward-kill-word)
(global-set-key (kbd "M-t") 'lispy-kill-at-point)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-u") 'hydra-undo-tree/undo-tree-undo)
(global-set-key (kbd "M-i") 'ivy-resume)                                ;; todo
(global-set-key (kbd "M-o") 'other-window-or-frame)
(global-set-key (kbd "M-p") 'exchange-point-and-mark-and-deactive)      ;; todo

(global-set-key (kbd "M-a") 'backward-char)
(global-set-key (kbd "M-s") nil)
    (global-set-key (kbd "M-s e") nil)
        (global-set-key (kbd "M-s eb") 'eval-buffer)
        (global-set-key (kbd "M-s er") 'eval-region)
    (global-set-key (kbd "M-s M-s") 'save-buffer)
    (global-set-key (kbd "M-s M-f") 'counsel-find-file)
    (global-set-key (kbd "M-s M-k") nil)                                ;; todo
    (global-set-key (kbd "M-s M-d") 'delete-window)
    (global-set-key (kbd "M-s M-p") 'counsel-projectile)
    (global-set-key (kbd "M-s M-g") 'get-term)
    (global-set-key (kbd "M-s M-t") 'multi-term)
    (global-set-key (kbd "M-s M-e") 'eshell)
    (global-set-key (kbd "M-s M-b") 'bury-buffer)
    (global-set-key (kbd "M-s o") 'find-file-other-window)
    (global-set-key (kbd "M-s M-u M-d M-o") 'sudo-edit-current)
(global-set-key (kbd "M-d") 'benjamin/kill-word)
(global-set-key (kbd "M-f") 'forward-to-word)
(global-set-key (kbd "M-g") 'hydra-jumper/body)
(global-set-key (kbd "M-h") 'hippie-expand)                    ;; todo
(global-set-key (kbd "M-j") 'avy-goto-char)
(global-set-key (kbd "M-k") 'kill-line)
(global-set-key (kbd "M-K") 'kill-line-save)

(global-set-key (kbd "M-z") 'zap-up-to-char)                        ;; todo
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-v") 'scroll-down-half)      ;; todo
(global-set-key (kbd "M-b") 'left-word)
(global-set-key (kbd "M-n") 'hydra-errgo/next-error)
(global-set-key (kbd "M-m") 'counsel-mark-ring)

(global-set-key (kbd "M--") 'zoom-frm-out)
(global-set-key (kbd "M-=") 'zoom-frm-in)
(global-set-key (kbd "C-SPC") 'forward-to-char-after-ws)
(global-set-key (kbd "M-SPC") 'backward-to-char-before-ws)
(global-set-key (kbd "M-<tab>") 'mc/mark-next-like-this)

;; C-S-...
(global-set-key (kbd "C-S-w") 'my-i3-make-frame)
(global-set-key (kbd "C-S-o") 'previous-buffer)
(global-set-key (kbd "C-S-p") 'next-buffer)

(global-set-key (kbd "C-S-h") 'highlight-region)
    (global-set-key (kbd "C-x C-S-h") 'highlight-clear)
(global-set-key (kbd "C-S-l") 'recenter-top-bottom)

(global-set-key (kbd "C-S-c") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "C->") 'hs-toggle-hiding)  ;; C-S-.


(global-set-key (kbd "C-M-e") 'elpy-nav-indent-shift-right)
(global-set-key (kbd "C-M-a") 'elpy-nav-indent-shift-left)
(global-set-key (kbd "C-M-j") 'elpy-nav-move-line-or-region-down)
(global-set-key (kbd "C-M-k") 'elpy-nav-move-line-or-region-up)


;; C-x
(global-set-key (kbd "C-x q") 'query-replace)
    (global-set-key (kbd "C-x S-q") 'query-replace-regexp)
(global-set-key (kbd "C-x w") 'my-i3-make-frame)                ;; todo
(global-set-key (kbd "C-x e") 'simplified-end-of-buffer)
(global-set-key (kbd "C-x r") 'counsel-rg)
(global-set-key (kbd "C-x C-r") (lambda () (interactive)
                                  (revert-buffer nil t)))
(global-set-key (kbd "C-x t") 'transpose-chars)
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "C-x i") 'iedit-mode)                      ;; todo
(global-set-key (kbd "C-x o") 'occur-dwim)
(global-set-key (kbd "C-x p") 'proced)

(global-set-key (kbd "C-x a") 'simplified-beginning-of-buffer)
(global-set-key (kbd "C-x s") 'save-buffer)                     ;; todo
(global-set-key (kbd "C-x d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-x f") 'hydra-errgo/next-error)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x h") help-map)
    (global-set-key (kbd "C-x h u") 'counsel-unicode-char)
(global-set-key (kbd "C-x k") 'volatile-kill-buffer)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-x h b") 'counsel-descbinds)

(global-set-key (kbd "C-x b") 'browse-url)

(global-set-key (kbd "C-x C-x e") 'eval-buffer)
(global-set-key (kbd "C-x C-x r") 'eval-region)


;; C-c
;; (global-set-key (kbd "C-c e") 'hydra-errgo/next-error)
(global-set-key (kbd "C-c q") 'quoted-insert)

(global-set-key (kbd "C-c E") nil)
    (global-set-key (kbd "C-c E f") 'ediff-files)
    (global-set-key (kbd "C-c E b") 'ediff-buffers)
    (global-set-key (kbd "C-c E d") 'ediff-directories)
    (global-set-key (kbd "C-c E m f") 'ediff-merge-files)
    (global-set-key (kbd "C-c E m b") 'ediff-merge-buffers)
(global-set-key (kbd "C-c C-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-c C-c") 'compile)

(global-set-key (kbd "C-c k") nil)
    (global-set-key (kbd "C-c ks") 'set-kblayout-swedish)
    (global-set-key (kbd "C-c kb") 'set-kblayout-benjamin)
(global-set-key (kbd "C-c f") 'benjamin/flycheck-list-errors)
(global-set-key (kbd "C-c C-f") 'find-file-at-point)


;; super
(global-set-key (kbd "s-r") 'counsel-projectile-rg) ;; so greedy
(global-set-key (kbd "s-b") 'counsel-bookmark)
(global-set-key (kbd "s-s") 'kmacro-start-macro)
(global-set-key (kbd "s-S") 'kmacro-end-macro)  ;; todo rebind s-s in macro mode
(global-set-key (kbd "s-c") 'kmacro-call-macro)

(global-set-key (kbd "s-j") nil)  ;; reserved
(global-set-key (kbd "s-i") nil)  ;; reserved
(global-set-key (kbd "s-k") nil)  ;; reserved
(global-set-key (kbd "s-l") nil)  ;; reserved
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(global-set-key (kbd "s-D") (lambda () (interactive)
                              (dired-jump)
                              (hydra-dired/body)))

(define-key git-gutter+-mode-map (kbd "s-g") 'hydra-git-gutter/body)

(global-set-key (kbd "s-h g") 'helm-google)
(global-set-key (kbd "s-h w") 'helm-man-woman)


;; guide-key for almost-hydras!
(guide-key-mode 1)
(setq guide-key/guide-key-sequence '("s-p" "M-c" "s-g" "C-t" "C-c" "C-x" "M-s"))
(setq guide-key/idle-delay 0.66)
(setq guide-key/recursive-key-sequence-flag t)

;;      http://pragmaticemacs.com/emacs/add-the-system-clipboard-to-the-emacs-kill-ring/
