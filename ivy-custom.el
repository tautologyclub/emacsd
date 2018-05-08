;;; -*- lexical-binding: t -*-

;;; Code:


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
(define-key ivy-minibuffer-map      (kbd "C-k")     'ivy-previous-line)
(define-key ivy-minibuffer-map      (kbd "C-S-j")   'ivy-next-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-S-k")   'ivy-previous-line-and-call)
(define-key ivy-minibuffer-map      (kbd "C-r")     'ivy-previous-history-element)
(define-key ivy-minibuffer-map      (kbd "C-s")     'ivy-next-history-element)
(define-key ivy-minibuffer-map      (kbd "H-o")     'ivy-dispatching-done)
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
(define-key ivy-switch-buffer-map (kbd "M-o") nil)

;; counsel/swiper specific
(define-key counsel-find-file-map (kbd "C-r") nil)
(define-key counsel-find-file-map (kbd "H-r") 'counsel-up-directory)
(define-key swiper-map (kbd "M-<tab>") 'swiper-mc)

(define-key ivy-switch-buffer-map (kbd "M-k")
  (lambda () (interactive)
    (ivy-set-action 'kill-buffer)
    (ivy-call)
    (ivy--reset-state ivy-last)
    (ivy-set-action 'ivy--switch-buffer-action)
    ))
