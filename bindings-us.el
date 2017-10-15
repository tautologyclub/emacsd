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
(global-unset-key (kbd "M-s")) ;; useless
(global-unset-key (kbd "M-p"))
(global-unset-key (kbd "C-x C-x"))
(global-unset-key (kbd "C-x m"))  ;; e-mail is annoying
(global-unset-key (kbd "C-x <backspace>"))
(global-unset-key (kbd "C-x DEL"))  ;; easy to accidentally call
(global-unset-key (kbd "C-S-q"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-f"))  ;; forward-char? lol
(global-unset-key (kbd "C-S-<return>"))

;; org mode
(eval-after-load "org-mode"
  (define-key org-mode-map (kbd "C-S-<return>") nil))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "M-d") 'duplicate-current-line-or-region)


;; Convenience functions
(defun my-i3-make-frame ()
  "i3 integration, create new emacs frames tiled the way we want with i3-msg"
  (interactive)
  (shell-command "/bin/bash ~/.config/split_optimal.sh")
  (make-frame-command))

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(defun modi/revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))

(defun set-mark-and-deactive ()
  (interactive
  (push-mark)
  (deactive-mark) ;; huh?
  ))

(defun exchange-point-and-mark-and-deactive ()
  (interactive)
  (exchange-point-and-mark)
  (keyboard-quit))

(defun volatile-kill-buffer ()
   "Kill current buffer unconditionally."
   (interactive)
   (let ((buffer-modified-p nil))
     (kill-buffer (current-buffer))))


;; beautiful Shift_L hack.
(global-set-key (kbd "<f10>") 'er/expand-region)

;; on trial
(global-set-key (kbd "C-M-.") 'hs-hide-all)
(global-set-key (kbd "C-<tab>") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "M-p") 'simple-paren-parentize)
;; (global-set-key [(super ?{)] 'simple-paren-brace)
;; (global-set-key [(super ?\[)] 'simple-paren-bracket)
;; (global-set-key [(super ?')] 'simple-paren-singlequote)
;; (global-set-key [(super ?\")] 'simple-paren-doublequote)
;; (global-set-key [(super ?<)] 'simple-paren-lesser-then)
;; (global-set-key [(super ?>)] 'simple-paren-greater-then)

(global-set-key (kbd "<f11>") 'my-ivy-buffers-no-stars)
(define-key helm-map (kbd "<f11>") 'helm-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f11>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "<f12>") 'minibuffer-keyboard-quit)
;; (global-set-key (kbd "<f11>") 'helm-buffers-list)

(global-set-key (kbd "<f12>") 'helm-buffers-list)
(define-key helm-map (kbd "<f12>") 'helm-keyboard-quit)
(global-set-key (kbd "C-|") 'toggle-mode-line)
(global-set-key (kbd "C-x h") 'helm-multi-swoop-projectile)


;; C
(global-set-key (kbd "C-j") 'avy-goto-line)
(global-set-key (kbd "C-d") 'backward-delete-char-untabify)
(global-set-key (kbd "C-f") 'delete-char)
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-o") 'other-window)

;; fixme:
(global-set-key (kbd "C-S-a")
                (lambda () (interactive)
                  (activate-mark)
                  (back-to-indentation-or-beginning)
                  (deactivate-mark)
                  ))
(global-set-key (kbd "C-,") 'set-mark-and-deactive)
;; (global-set-key (kbd "C-.") 'exchange-point-and-mark-and-deactive)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C--") 'undo)
(global-set-key (kbd "C-=") 'undo-tree-redo)

;; better as some kind of modal mappings
;(global-set-key (kbd "C-p") 'scroll-up-line)
;(global-set-key (kbd "C-o") 'scroll-down-line)
;;

(global-set-key (kbd "C-S-s") 'helm-swoop)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-v") 'yank)  ;; on trial, I think it's ergonomic


(defun open-next-line (arg)
      "Move to the next line and then opens a line.
    See also `newline-and-indent'."
      (interactive "p")
      (end-of-line)
      (open-line arg)
      (next-line 1)
      (when newline-and-indent
        (indent-according-to-mode)))
(global-set-key (kbd "C-<return>") 'open-next-line)


;; M
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-q") 'zap-to-char)
(global-set-key (kbd "M-r") 'repeat)
(global-set-key (kbd "M-t") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "M-f") 'kill-word)
(global-set-key (kbd "M-<up>") 'elpy-nav-move-line-or-region-up)
(global-set-key (kbd "M-<down>") 'elpy-nav-move-line-or-region-down)
(global-set-key (kbd "M-<right>") 'elpy-nav-indent-shift-right)
(global-set-key (kbd "M-<left>") 'elpy-nav-indent-shift-left)
(global-set-key (kbd "M--") 'zoom-frm-out)
(global-set-key (kbd "M-=") 'zoom-frm-in)

(global-set-key (kbd "C-S-o") 'previous-buffer)
(global-set-key (kbd "C-S-p") 'next-buffer)


;; M-s ...
(global-set-key (kbd "M-s M-p") 'counsel-projectile)


;; C-S
(global-set-key (kbd "C-S-r") 'projectile-commander)
(global-set-key (kbd "C-S-b") 'volatile-kill-buffer)
(global-set-key (kbd "C-S-<return> C-S-<return>") 'multi-term)
(global-set-key (kbd "C-S-<return> g") 'get-term)

;; cool highlight function (that also sets mark!)
(global-set-key (kbd "C-S-h") 'highlight-region)
(global-set-key (kbd "C-x C-S-h") 'highlight-clear)


(global-set-key (kbd "C-S-f") 'helm-find-files)
(global-set-key (kbd "C-S-l") 'helm-buffers-list)
(global-set-key (kbd "C-S-g") 'helm-global-mark-ring)
(global-set-key (kbd "C-S-m") 'helm-mark-ring)
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
(global-set-key (kbd "C-S-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-S-v") 'counsel-yank-pop)
(global-set-key (kbd "C-S-k") 'kill-line-save)  ;; sssslightly redundant given advice on M-w but nice
(global-set-key (kbd "C-S-w") 'my-i3-make-frame)
(global-set-key (kbd "C-S-q C-S-q") 'delete-window)
(global-set-key (kbd "C-S-<backspace>") 'delete-other-windows)
(global-set-key (kbd "C->") 'hs-toggle-hiding)  ;; C-S-.


;; C-x
(global-set-key (kbd "C-x a") 'simplified-beginning-of-buffer)
(global-set-key (kbd "C-x e") 'simplified-end-of-buffer)
(global-set-key (kbd "C-x f") 'sudo-find-file)
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "C-x w") 'write-file)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x t") 'jnm/term-toggle-mode)  ;; FIXME: make term hook!!  FIXME
(global-set-key (kbd "C-x k") 'volatile-kill-buffer)
(global-set-key (kbd "C-x q") 'query-replace)
(global-set-key (kbd "C-x S-q") 'query-replace-regexp)


;; C-x C-x
(global-set-key (kbd "C-x C-x g") 'magit-status)
(global-set-key (kbd "C-x C-x man") 'helm-man-woman)
(global-set-key (kbd "C-x C-x eval") 'eval-buffer)


;; C-x C-S ...
(global-set-key (kbd "C-x C-S-<return>") 'multi-term)
(global-set-key (kbd "C-x C-S-f") 'helm-projectile)


;; C-x C-x C-x : Essentially mneumonics
(global-set-key (kbd "C-x C-x C-x t l") 'linum-mode)
(global-set-key (kbd "C-x C-x C-x e l f e e d") 'elfeed)
(global-set-key (kbd "C-x C-x C-x p a r e n") 'check-parens)
(global-set-key (kbd "C-x C-x C-x r e v") 'modi/revert-all-file-buffers)
;; (global-set-key (kbd "C-x C-x C-x l i n e") 'lambda etc)  ;; fixme


;; crucial: code navigation

;;todo: bookmarks
;;      deft
;;      http://pragmaticemacs.com/emacs/add-the-system-clipboard-to-the-emacs-kill-ring/
;;      gdb!!


; C-m-<arrows> : forward/backward sexp
;; C-M-a runs beginning-of-defun
;; C-M-e runs end-of-defun

;; -------------------------------------------------------------------------------
;; todo
;; -------------------------------------------------------------------------------
;; C-t     transpose-char-backward
;; C-y   transpose-forward-char
;; C-M-<u> beginning-of-defun
;; C-d     hungry-delete-backward
;; C-f     hungry-delete-forward
;; C-S-d   delete-sexp-backward
;; C-S-f   delete-sexp-forward
;; M-RET   insert new line under current line

;; -------------------------------------------------------------------------------
;; Called for
;; -------------------------------------------------------------------------------
;; M-q     USELESS         fill-paragraph
;; M-w                     copy region, nice but replace with C-S-w and let M-w
;;                         be "new window"
;; M-e                     forward sentence
;; M-r     USELESS         search through history
;; M-t     USELESS         transpose word
;; M-i                     insert four spaces, kinda neat
;; M-p                     select previous search string
;; M-s     USELESS         search through history
;; M-g                     neat prefix used for un-neat things
;; M-h                     mark paragraph
;; M-x                     duh
;; M-l     USELESS         lowercase region
;; M-k     USELESS         forward kill sentence
;; M-d     USELESS         delete foward word, use C-S-f
;; M-f     USELESS         move forward word

;; -------------------------------------------------------------------------------
;; High prio
;; -------------------------------------------------------------------------------
;; M-a     USELESS         backwards-sentence
;; M-o     USELESS         set face
;; C-j     USELESS         electric-newline-and-maybe-indent
;; C-n     USELESS         next-line
;; C-S-q   ---
;; C-S-r   ---
;; C-S-t

;; -------------------------------------------------------------------------------
;; Mid prio
;; -------------------------------------------------------------------------------
;; M-[     ---
;; M-]     ---
;; M-c     USELESS         capitalize-word
;; M-b     USELESS         backward-word
;; M-v     USELESS         page-down
;; C-v     USELESS         scroll-up-command
;; C-;     ---
;; C-'     ---

;; -------------------------------------------------------------------------------
;; Low prio
;; -------------------------------------------------------------------------------
;; M-y     USELESS         yank-pop, deprecated by counsel-yank-pop @ C-S-y
;; M-u     USELESS         uppercase region
;; M-j     USELESS         indent-new-comment-line, wtf...
;; M-;     USELESS         indent-for-comment
;; M-'     ---
;; M-\     USELESS         delete-horizontal-space: useless w/hungry-delete
;; M-z                     zap-to-char, FANTASTIC and should be rebound
;; M-n                     next isearch string
;; M-,                     xref-pop-marker-stack
;; M-.                     find tag or definition
;; M-/                     dabbrev-expand: probably awesome, but yasnippets...?
