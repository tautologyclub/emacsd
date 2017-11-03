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

(define-key ivy-minibuffer-map (kbd "C-<down>") 'ivy-next-line-and-call)
(define-key ivy-minibuffer-map (kbd "C-<up>") 'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-restrict-to-matches)
(define-key ivy-minibuffer-map (kbd "C-s") 'ivy-next-history-element)
(define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

(define-key ivy-occur-grep-mode-map (kbd "C-o") 'other-window)

(define-key ivy-switch-buffer-map (kbd "C-k")
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
