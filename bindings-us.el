;; *** Todo:
;;              f11 (super) for whaaaat
;;              hydra-semicolon
;;              hydra-multi-term
;;              hydra-read-only
;;              hydra-dired?
;;              ivy-occur
;;              ivy-find-file-at-point if region active
;; *** Bind:
;;              ivy-occur-mode: read-only-mode
;;              dired-jump

;; unbind
(global-unset-key (kbd "M-r")) ;; useless
(global-unset-key (kbd "M-s")) ;; useless
(global-unset-key (kbd "M-p"))
(global-unset-key (kbd "M-t"))
(global-unset-key (kbd "C-x C-x"))
(global-unset-key (kbd "C-x m"))            ;; e-mail is annoying
(global-unset-key (kbd "C-x <backspace>"))
(global-unset-key (kbd "C-x DEL"))          ;; easy to accidentally call
(global-unset-key (kbd "C-S-q"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-c"))          ;; too easy
(global-unset-key (kbd "C-S-<return>"))
(global-set-key (kbd "C-x r") nil)
(define-key undo-tree-map (kbd "C-x r") nil)

(require 'ivy)
(require 'helm)

;; beautiful xcape hacks
(global-set-key (kbd "<f8>") 'hydra-weird-chars/body)
(global-set-key (kbd "<f10>") 'er/expand-region)
;; (global-set-key (kbd "<f11>") 'ivy-switch-buffer)
(global-unset-key (kbd "<f11>"))
(global-set-key (kbd "<f12>") 'ivy-switch-buffer)
(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
(global-set-key (kbd "<f9>") 'hydra-nav/body)
(define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)

;; random betterments
;; (global-set-key "\"" 'self-insert-command)
(global-set-key (kbd "θ") 'simple-paren-parentize)

;; C
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-f") 'forward-char)
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-j") 'avy-goto-word-1)
(global-set-key (kbd "C-|") 'toggle-mode-line)
(global-set-key (kbd "C-,") 'set-mark-and-deactive)
(global-set-key (kbd "C-.") 'exchange-point-and-mark-and-deactive)


;; M
(global-set-key (kbd "M-a") 'xah-beginning-of-line-or-block)
(global-set-key (kbd "M-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-T") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "M-u") 'hydra-undo-tree/undo-tree-undo)
(global-set-key (kbd "M-e") 'left-word)
(global-set-key (kbd "M-f") 'right-word)
(global-set-key (kbd "M-o") 'backward-delete-char-untabify)
(global-set-key (kbd "M-p") 'other-window-or-frame)
(global-set-key (kbd "M-i") 'iedit-mode)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-l") 'xah-end-of-line-or-block)
(global-set-key (kbd "M-m") 'counsel-mark-ring)
(global-set-key (kbd "M--") 'zoom-frm-out)
(global-set-key (kbd "M-=") 'zoom-frm-in)
(global-set-key (kbd "M-I") 'iedit-mode)

(global-set-key (kbd "C-M-f") 'kill-word)
(global-set-key (kbd "C-M-d") 'kill-word)
(global-set-key (kbd "C-M-e") 'backward-kill-word)
(global-set-key (kbd "C-M-o") 'backward-kill-word)
;; better at C-x p:
;; (global-set-key (kbd "C-M-p") 'hydra-counsel-projectile/body)

(global-set-key (kbd "M-s M-s") 'save-buffer)
(global-set-key (kbd "M-s M-f") 'counsel-find-file)
(global-set-key (kbd "M-s M-k") 'volatile-kill-buffer)
(global-set-key (kbd "M-s M-e") 'eval-buffer)
(global-set-key (kbd "M-s M-g") 'goto-line)
(global-set-key (kbd "M-s M-p") 'counsel-projectile)
(global-set-key (kbd "M-s M-t") 'multi-term)

(global-set-key (kbd "M-<up>") 'elpy-nav-move-line-or-region-up)
(global-set-key (kbd "M-<down>") 'elpy-nav-move-line-or-region-down)
(global-set-key (kbd "M-<right>") 'elpy-nav-indent-shift-right)
(global-set-key (kbd "M-<left>") 'elpy-nav-indent-shift-left)


;; C-S
(global-set-key (kbd "C-S-o") 'previous-buffer)
(global-set-key (kbd "C-S-p") 'next-buffer)
(global-set-key (kbd "C-S-s") 'swiper-all)
(global-set-key (kbd "C-S-r") 'projectile-commander)
(global-set-key (kbd "C-S-f") 'counsel-find-file)
(global-set-key (kbd "C-S-t") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-S-l") 'helm-buffers-list)
(global-set-key (kbd "C-S-g") 'helm-global-mark-ring)
(global-set-key (kbd "C-S-m") 'helm-mark-ring)
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
(global-set-key (kbd "C-S-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-S-v") 'counsel-yank-pop)
(global-set-key (kbd "C-S-k") 'kill-line-save)  ;; sssslightly redundant given advice on M-w but nice
(global-set-key (kbd "C->") 'hs-toggle-hiding)  ;; C-S-.
(global-set-key (kbd "C-S-q C-S-q") 'delete-window)
(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "C-S-h") 'highlight-region)
(global-set-key (kbd "C-x C-S-h") 'highlight-clear)

(global-set-key (kbd "C-h b") 'counsel-descbinds)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h f") 'counsel-describe-function)


;; C-x
(global-set-key (kbd "C-x h") nil) ;; mark whole buffer
(global-set-key (kbd "C-x a") 'simplified-beginning-of-buffer)
(global-set-key (kbd "C-x e") 'simplified-end-of-buffer)
(global-set-key (kbd "C-x p") 'hydra-counsel-projectile/body)
(global-set-key (kbd "C-x f") 'hydra-flycheck/body)
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "C-x t") 'multi-term)
(global-set-key (kbd "C-x w") 'my-i3-make-frame)
(global-set-key (kbd "C-x s") 'save-buffer)
(eval-after-load 'term-mode
  (define-key term-mode-map (kbd "C-x t") 'jnm/term-toggle-mode))


(define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)

(global-set-key (kbd "C-x k") 'volatile-kill-buffer)
(global-set-key (kbd "C-x r") 'counsel-rg)
(global-set-key (kbd "C-x q") 'query-replace)
(global-set-key (kbd "C-x S-q") 'query-replace-regexp)
(global-set-key (kbd "C-x l") 'counsel-locate)


;; C-x C-x
;;;; todo: hydra
(global-set-key (kbd "C-x C-x g") 'magit-status)
(global-set-key (kbd "C-x C-x C-x man") 'helm-man-woman)
(global-set-key (kbd "C-x C-x C-x eb") 'eval-buffer)
(global-set-key (kbd "C-x C-x C-x rev") 'modi/revert-all-file-buffers)
(global-set-key (kbd "C-x C-x C-x lm") 'linum-mode)
(global-set-key (kbd "C-x C-x C-x ef") 'elfeed)
(global-set-key (kbd "C-x C-x C-x cp") 'check-parens)
(global-set-key (kbd "C-x C-x C-x todo")
                (lambda () (interactive)
                  (find-file "~/.org/scratch.org")))



;;      http://pragmaticemacs.com/emacs/add-the-system-clipboard-to-the-emacs-kill-ring/
