;; *** Todo:
;;              customize projectile, helm-projectile
;;              smart way of getting C-x to the terminal
;;              separate key maps for linemode/charmode?!?
;;              C-S-a; set mark, do C-a
;;              repeat-command on next line
;;              dired?
;;              ivy-restrict-to-matches
;;              ivy-occur


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

(require 'helm)
(require 'ivy)
(require 'undo-tree)
(require 'projectile)
(require 'git-gutter+)
(require 'guide-key)

(eval-after-load "undo-tree-mode"
  (define-key undo-tree-map (kbd "C-x r") nil))


;; beautiful xcape hacks
(global-set-key (kbd "<f8>") (lambda () (interactive) (insert ";")))  ;; todo
(global-set-key (kbd "<S-f8>") (lambda () (interactive) (insert ":")))  ;; todo
(global-set-key (kbd "<f9>") 'hydra-nav/body)
(global-set-key (kbd "<f10>") 'er/expand-region)
(global-set-key (kbd "<f12>") 'benjamin/helm-buffers-list)
;; (global-set-key (kbd "<f12>") 'set-mark-command)

(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f11>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)

(global-set-key (kbd "(") 'ora-parens)
;; (global-set-key (kbd "[") 'ora-brackets)
;; (global-set-key (kbd "Ρ") 'ora-braces)


;; C
;; (global-set-key (kbd "C-q") nil)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-e") 'forward-char)
(global-set-key (kbd "C-r") 'backward-delete-char-untabify)
(global-set-key (kbd "C-t") nil)
(global-set-key (kbd "C-t C-t") 'multi-term)
(global-set-key (kbd "C-t C-g") 'get-term)
(global-set-key (kbd "C-t C-d") 'terminal-with-focus-below)
;; (global-set-key (kbd "C-y") nil)
;; (global-set-key (kbd "C-u) nil)
;; (global-set-key (kbd "C-i) nil)
(global-set-key (kbd "C-o") 'smart-open-line-above)
;; (global-set-key (kbd "C-p") nil)  ;; todo

(global-set-key (kbd "C-a") 'backward-char)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-d") 'delete-char)
(global-set-key (kbd "C-f") 'benjamin/jump-char-fwd)
;; (global-set-key (kbd "C-g") nil)
;; (global-set-key (kbd "C-h") nil) ;; todo
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'kill-line)

;; (global-set-key (kbd "C-z") nil)
;; (global-set-key (kbd "C-x") nil)
;; (global-set-key (kbd "C-c") nil)
;; (global-set-key (kbd "C-v") nil)  ;; todo
(global-set-key (kbd "C-b") 'benjamin/jump-char-bwd)
;; (global-set-key (kbd "C-n") nil)  ;; todo
;; (global-set-key (kbd "C-m") nil)

(global-set-key (kbd "C-,") 'set-mark-and-deactive)
(global-set-key (kbd "C-.") 'exchange-point-and-mark-and-deactive)
;; (global-set-key (kbd "C-/") nil)


;; M
;; (global-set-key (kbd "M-q") nil) ;; todo
;; (global-set-key (kbd "M-w") nil)
(global-set-key (kbd "M-e") 'xah-end-of-line-or-block)
(global-set-key (kbd "M-r") 'benjamin/backward-kill-word)
;; (global-set-key (kbd "M-t") nil)  ;; todo
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-u") 'hydra-undo-tree/undo-tree-undo)
;; (global-set-key (kbd "M-i") nil)  ;; tabbing is quite nice tbh
(global-set-key (kbd "M-o") 'other-window-or-frame)
;; (global-set-key (kbd "M-p") nil)  ;; todo
;; ace-window is overkill for my workflow

(global-set-key (kbd "M-a") 'xah-beginning-of-line-or-block)
(global-set-key (kbd "M-s M-s") 'save-buffer)
(global-set-key (kbd "M-s M-f") 'counsel-find-file)
(global-set-key (kbd "M-s M-k") 'volatile-kill-buffer)
(global-set-key (kbd "M-s M-e") 'eval-buffer)
(global-set-key (kbd "M-s M-d") 'delete-window)
(global-set-key (kbd "M-s M-p") 'counsel-projectile)
(global-set-key (kbd "M-s M-g") 'get-term)
(global-set-key (kbd "M-s M-b") 'bury-buffer)

(global-set-key (kbd "M-s o") 'find-file-other-window)
(global-set-key (kbd "M-d") 'benjamin/kill-word)
(global-set-key (kbd "M-f") 'avy-goto-word-0-below)
(global-set-key (kbd "M-g") 'hydra-jumper/body)
(global-set-key (kbd "M-h") nil)  ;; todo
(global-set-key (kbd "M-j") 'left-word)
;; (global-set-key (kbd "M-k") 'forward-to-word)
(global-set-key (kbd "M-k") 'forward-word-or-eol)
(global-set-key (kbd "M-l") 'kill-line-save)

;; (global-set-key (kbd "M-z") nil)  ;; zapping is pretty dope
(global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "M-v") nil)
(global-set-key (kbd "M-b") 'avy-goto-word-0-above)
;; (global-set-key (kbd "M-n") nil)  ;; todo
(global-set-key (kbd "M-m") 'counsel-mark-ring)

(global-set-key (kbd "M--") 'zoom-frm-out)
(global-set-key (kbd "M-=") 'zoom-frm-in)

(global-set-key (kbd "M-<up>") 'elpy-nav-move-line-or-region-up)
(global-set-key (kbd "M-<down>") 'elpy-nav-move-line-or-region-down)
(global-set-key (kbd "M-<right>") 'elpy-nav-indent-shift-right)
(global-set-key (kbd "M-<left>") 'elpy-nav-indent-shift-left)


;; C-S-...
(global-set-key (kbd "C-S-w") 'my-i3-make-frame)
(global-set-key (kbd "C-S-o") 'previous-buffer)
(global-set-key (kbd "C-S-p") 'next-buffer)

(global-set-key (kbd "C-S-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-S-h") 'highlight-region)
(global-set-key (kbd "C-x C-S-h") 'highlight-clear)
(global-set-key (kbd "C-S-l") 'recenter-top-bottom)

(global-set-key (kbd "C-S-c") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-S-q C-S-q") 'delete-window)
(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "C->") 'hs-toggle-hiding)  ;; C-S-.


;; M-C-...
(global-set-key (kbd "M-C-j") 'elpy-nav-move-line-or-region-down)
(global-set-key (kbd "M-C-k") 'elpy-nav-move-line-or-region-up)


;; C-x
(global-set-key (kbd "C-x q") 'query-replace)
(global-set-key (kbd "C-x S-q") 'query-replace-regexp)
(global-set-key (kbd "C-x w") 'my-i3-make-frame)
(global-set-key (kbd "C-x e") 'simplified-end-of-buffer)
(global-set-key (kbd "C-x r") 'counsel-rg)
(global-set-key (kbd "C-x C-r") (lambda () (interactive) (revert-buffer nil t)))
(global-set-key (kbd "C-x t") 'jnm/term-toggle-mode)  ;; FIXME: make term hook!!  FIXME
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "C-x i") 'iedit-mode)
(global-set-key (kbd "C-x p") 'hydra-counsel-projectile/body)

(global-set-key (kbd "C-x a") 'simplified-beginning-of-buffer)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x f") 'hydra-flycheck/body)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x h") help-map)
(global-set-key (kbd "C-x k") 'volatile-kill-buffer)
(global-set-key (kbd "C-x l") 'counsel-locate)

(global-set-key (kbd "C-x b") 'browse-url)


;; super
(global-set-key (kbd "s-r") 'counsel-projectile-rg)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(global-set-key (kbd "s-D") (lambda () (interactive)
                              (dired-jump)
                              (hydra-dired/body)))

(define-key git-gutter+-mode-map (kbd "s-g") 'hydra-git-gutter/body)
;; (define-key git-gutter+-mode-map (kbd "s-g n") 'git-gutter+-next-hunk)
;; (define-key git-gutter+-mode-map (kbd "s-g j") 'hydra-git-gutter/git-gutter+-next-hunk)
;; (define-key git-gutter+-mode-map (kbd "s-g p") 'git-gutter+-previous-hunk)
;; (define-key git-gutter+-mode-map (kbd "s-g k") 'hydra-git-gutter/git-gutter+-previous-hunk)
;; (define-key git-gutter+-mode-map (kbd "s-g S") 'git-gutter+-show-hunk)
;; (define-key git-gutter+-mode-map (kbd "s-g r") 'git-gutter+-revert-hunks)
;; (define-key git-gutter+-mode-map (kbd "s-g t") 'git-gutter+-stage-hunks)
;; (define-key git-gutter+-mode-map (kbd "s-g c") 'git-gutter+-commit)
;; (define-key git-gutter+-mode-map (kbd "s-g C") 'git-gutter+-stage-and-commit)
;; (define-key git-gutter+-mode-map (kbd "s-g C-y") 'git-gutter+-stage-and-commit-whole-buffer)
;; (define-key git-gutter+-mode-map (kbd "s-g U") 'git-gutter+-unstage-whole-buffer)
;; (define-key git-gutter+-mode-map (kbd "s-g g") 'hydra-git-gutter/body)


(global-set-key (kbd "s-h g") 'helm-google)


(define-key projectile-command-map (kbd "SPC") #'counsel-projectile)
(define-key projectile-command-map (kbd "t") #'projectile-get-term)
(define-key projectile-command-map (kbd "r") #'counsel-projectile-rg)
(define-key projectile-command-map (kbd "o") #'projectile-find-other-file)
(define-key projectile-command-map (kbd "a") #'counsel-projectile-ag)
(define-key projectile-command-map (kbd "s") #'counsel-projectile-switch-project)
(define-key projectile-command-map (kbd "d") #'counsel-projectile-find-dir)
(define-key projectile-command-map (kbd "g") #'counsel-projectile-git-grep)
(define-key projectile-command-map (kbd "w") #'projectile-find-file-other-optimal-frame)


;; guide-key for almost-hydras!
(guide-key-mode 1)
(setq guide-key/guide-key-sequence '("s-p" "M-c" "s-g"))
(setq guide-key/idle-delay 0)
(setq guide-key/recursive-key-sequence-flag t)

;;      http://pragmaticemacs.com/emacs/add-the-system-clipboard-to-the-emacs-kill-ring/
