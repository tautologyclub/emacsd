;;; -*- lexical-binding: t -*-

;;; Code:
(require 'magit)
(require 'ivy)
(require 'counsel)
(require 'projectile)

(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "%d/%d - ")
(setq ivy-wrap t)
(setq ivy-use-selectable-prompt t)
(setq magit-completing-read-function 'ivy-completing-read)
(setq ivy-extra-directories nil)
(setq counsel-grep-swiper-limit 120000)

(require 'avy)
(setq avy-case-fold-search nil)

;; counsel-bookmark with current buffer file as initial input
(defun counsel-bookmark-current-buffer-file ()
  "Forward to `bookmark-jump' or `bookmark-set' if bookmark doesn't exist."
  (interactive)
  (require 'bookmark)
  (ivy-read "Create or jump to bookmark: "
            (bookmark-all-names)
            :initial-input buffer-file-name
            :action (lambda (x)
                      (cond ((and counsel-bookmark-avoid-dired
                                  (member x (bookmark-all-names))
                                  (file-directory-p (bookmark-location x)))
                             (with-ivy-window
                               (let ((default-directory (bookmark-location x)))
                                 (counsel-find-file))))
                            ((member x (bookmark-all-names))
                             (with-ivy-window
                               (bookmark-jump x)))
                            (t
                             (bookmark-set x))))
            :caller 'counsel-bookmark))


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


(defun ivy-previous-line-and-call-and-recenter (&optional arg)
  "Move cursor vertically down ARG candidates.
Call the permanent action if possible."
  (interactive "p")
  (ivy-previous-line arg)
  (ivy--exhibit)
  (ivy-call-and-recenter))

(defun ivy-next-line-and-call-and-recenter (&optional arg)
  "Move cursor vertically down ARG candidates.
Call the permanent action if possible."
  (interactive "p")
  (ivy-next-line arg)
  (ivy--exhibit)
  (ivy-call-and-recenter))

;; bindings
(define-key ivy-minibuffer-map      (kbd "M-o")     nil)
(define-key ivy-minibuffer-map      (kbd "S-SPC")   nil)

(define-key ivy-minibuffer-map      (kbd "C-j")     'ivy-next-line)
(define-key ivy-switch-buffer-map   (kbd "C-j")     'ivy-next-line)
(define-key ivy-minibuffer-map      (kbd "C-k")     'ivy-previous-line)
(define-key ivy-switch-buffer-map   (kbd "C-k")     'ivy-previous-line)
(define-key ivy-minibuffer-map      (kbd "C-S-j")   'ivy-next-line-and-call-and-recenter)
(define-key ivy-minibuffer-map      (kbd "C-S-j")   'ivy-next-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-S-k")   'ivy-previous-line-and-call-and-recenter)
(define-key ivy-minibuffer-map      (kbd "C-S-k")   'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-s")     'ivy-next-history-element)
(define-key ivy-minibuffer-map      (kbd "C-u")     'ivy-dispatching-done)
(define-key ivy-minibuffer-map      (kbd "M-r")     'ivy-backward-kill-word)

(define-key ivy-minibuffer-map (kbd "H-t")
  (lambi (ivy-quit-and-run
	  (let ((default-directory ivy--directory)) (multi-term)))))

(define-key ivy-minibuffer-map      (kbd "C-x e")   'ivy-end-of-buffer)
(define-key ivy-switch-buffer-map   (kbd "C-x e")   'ivy-end-of-buffer)
(define-key ivy-minibuffer-map      (kbd "C-x a")   'ivy-beginning-of-buffer)
(define-key ivy-switch-buffer-map   (kbd "C-x a")   'ivy-beginning-of-buffer)

(define-key ivy-minibuffer-map      (kbd "C-x <return>") 'ivy-restrict-to-matches)
(define-key ivy-minibuffer-map      (kbd "C-<return>")   'ivy-toggle-ignore)

(define-key ivy-minibuffer-map      (kbd "<return>")    'ivy-alt-done)
(define-key ivy-minibuffer-map      (kbd "C-<up>")      'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-<down>")    'ivy-next-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-c o")       'ivy-occur)
(define-key ivy-occur-grep-mode-map (kbd "C-c w")       'ivy-wgrep-change-to-wgrep-mode)

;; counsel/swiper specific
(define-key counsel-find-file-map (kbd "C-r") 'counsel-up-directory)
(define-key swiper-map (kbd "M-<tab>") 'swiper-mc)

;; (setq counsel-rg-base-command "rg -i --no-heading --line-number --max-columns 120 --max-count 200 --max-filesize 100M --color never %s . 2> /dev/null")
(setq counsel-rg-base-command "rg -i --no-heading --line-number --max-columns 120 --max-count 200 --max-filesize 100M --color never %s .")

(add-hook 'wgrep-setup-hook 'save-some-buffers)

(define-key ivy-switch-buffer-map (kbd "M-k")
  (lambda () (interactive)
    (ivy-set-action 'kill-buffer)
    (ivy-call)
    (ivy--reset-state ivy-last)
    (ivy-set-action 'ivy--switch-buffer-action)
    ))

(define-key ivy-switch-buffer-map (kbd "M-o") nil)
(defun ivy-switch-buffer-no-leading-stars ()
  (interactive)
  (minibuffer-with-setup-hook
      (lambda () (insert "!\*"))
    (call-interactively #'ivy-switch-buffer))
)

;; (setq ivy-ignore-buffers '("\\` " "\\`\\*"))
(setq ivy-ignore-buffers '("\\` "))

(add-hook 'occur-hook 'occur-rename-buffer)

(add-to-list 'ivy-ignore-buffers "\\*Flycheck")
(add-to-list 'ivy-ignore-buffers "\\*CEDET")
(add-to-list 'ivy-ignore-buffers "\\*BACK")
(add-to-list 'ivy-ignore-buffers "\\*Help\\*")
(add-to-list 'ivy-ignore-buffers "\\*Messages\\*")
(add-to-list 'ivy-ignore-buffers "\\*Compile-Log\\*")
(add-to-list 'ivy-ignore-buffers "\\*helm")
