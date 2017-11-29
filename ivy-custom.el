;;; -*- lexical-binding: t -*-

(require 'ivy)
(ivy-mode t)

(defun reloading (cmd)
  (lambda (x)
    (funcall cmd x)
    (ivy--reset-state ivy-last)))

(defun given-file (cmd prompt) ; needs lexical-binding
  (lambda (source)
    (let ((target
           (let ((enable-recursive-minibuffers t))
             (read-file-name
              (format "%s %s to:" prompt source)))))
      (funcall cmd source target 1))))

(defun confirm-delete-file (x)
  (dired-delete-file x 'confirm-each-subdirectory))

(setq ivy-display-style 'fancy)
  (ivy-add-actions
   'counsel-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")))
  (ivy-add-actions
   'counsel-projectile-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")
     ("b" counsel-find-file-cd-bookmark-action "cd bookmark")))


;; ivy-occur-grep-mode-map

(define-key ivy-minibuffer-map      (kbd "C-j") 'ivy-next-line)
(define-key ivy-switch-buffer-map   (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map      (kbd "C-k") 'ivy-previous-line)
(define-key ivy-switch-buffer-map   (kbd "C-k") 'ivy-previous-line)
(define-key ivy-minibuffer-map      (kbd "C-S-j") 'ivy-next-line-and-call)
(define-key ivy-switch-buffer-map   (kbd "C-S-j") 'ivy-next-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-S-k") 'ivy-previous-line-and-call)
(define-key ivy-switch-buffer-map   (kbd "C-S-k") 'ivy-previous-line-and-call)

(define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-restrict-to-matches)
(define-key ivy-minibuffer-map (kbd "C-s") 'ivy-next-history-element)

(define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)
(define-key ivy-minibuffer-map (kbd "C-<up>") 'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map (kbd "C-<down>") 'ivy-next-line-and-call)

(define-key ivy-occur-grep-mode-map (kbd "C-c w") 'ivy-wgrep-change-to-wgrep-mode)

(require 'projectile)
(add-hook 'wgrep-setup-hook 'projectile-save-project-buffers)
(define-key ivy-occur-grep-mode-map (kbd "C-M-w")
  (lambda () (interactive)
    (projectile-save-project-buffers)
    (ivy-wgrep-change-to-wgrep-mode)))

(define-key ivy-switch-buffer-map (kbd "M-k")
  (lambda () (interactive)
    (ivy-set-action 'kill-buffer)
    (ivy-done)))
(define-key ivy-switch-buffer-map (kbd "M-o")
  (lambda () (interactive)
    (ivy-set-action 'ivy--switch-buffer-other-window-action)
    (ivy-call)))

;; todo - delete action on find-file etc

(defun no-leading-stars () (insert "!\*"))
(defun ivy-switch-buffer-no-leading-stars ()
  (interactive)
  (minibuffer-with-setup-hook
      'no-leading-stars
    (call-interactively #'ivy-switch-buffer))
)

(setq ivy-ignore-buffers '("\\` " "\\`\\*"))
