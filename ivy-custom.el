;;; -*- lexical-binding: t -*-

;;; Code:
(require 'magit)
(require 'ivy)
(ivy-mode t)

(setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d)") ;; meh
(setq ivy-wrap t)
(setq ivy-use-selectable-prompt t)
(setq magit-completing-read-function 'ivy-completing-read)
(setq ivy-extra-directories nil)



;; deleting files. Dangerous, should prob just remove
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

;; bindings
(define-key ivy-minibuffer-map      (kbd "M-o") nil)

(define-key ivy-minibuffer-map      (kbd "C-j") 'ivy-next-line)
(define-key ivy-switch-buffer-map   (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map      (kbd "C-k") 'ivy-previous-line)
(define-key ivy-switch-buffer-map   (kbd "C-k") 'ivy-previous-line)
(define-key ivy-minibuffer-map      (kbd "C-S-j") 'ivy-next-line-and-call)
(define-key ivy-switch-buffer-map   (kbd "C-S-j") 'ivy-next-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-S-k") 'ivy-previous-line-and-call)
(define-key ivy-switch-buffer-map   (kbd "C-S-k") 'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-s") 'ivy-next-history-element)
(define-key ivy-minibuffer-map      (kbd "C-u") 'ivy-dispatching-done)
(define-key ivy-minibuffer-map      (kbd "M-r") 'ivy-backward-kill-word)

(define-key ivy-minibuffer-map      (kbd "C-x e") 'ivy-end-of-buffer)
(define-key ivy-switch-buffer-map   (kbd "C-x e") 'ivy-end-of-buffer)
(define-key ivy-minibuffer-map      (kbd "C-x a") 'ivy-beginning-of-buffer)
(define-key ivy-switch-buffer-map   (kbd "C-x a") 'ivy-beginning-of-buffer)

(define-key ivy-minibuffer-map      (kbd "C-x <return>") 'ivy-restrict-to-matches)
(define-key ivy-minibuffer-map      (kbd "C-<return>") 'ivy-toggle-ignore)

(define-key ivy-minibuffer-map      (kbd "<return>") 'ivy-alt-done)
(define-key ivy-minibuffer-map      (kbd "C-<up>") 'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-<down>") 'ivy-next-line-and-call)

;; ivy-occur
(define-key ivy-minibuffer-map (kbd "C-c o") 'ivy-occur)
(define-key ivy-occur-grep-mode-map (kbd "C-c w") 'ivy-wgrep-change-to-wgrep-mode)

(require 'counsel)
(define-key counsel-find-file-map (kbd "C-r") 'counsel-up-directory)

(setq counsel-rg-base-command "rg -i --no-heading --line-number --max-columns 79 --max-count 200 --max-filesize  --color never %s .")

(require 'projectile)
(add-hook 'wgrep-setup-hook 'save-some-buffers)

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
(add-hook 'occur-hook 'occur-rename-buffer)
