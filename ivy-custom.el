(require 'ivy)

(eval-after-load "ivy-mode"
  (define-key ivy-minibuffer-map (kbd "C-<down>") 'ivy-next-line-and-call))
(eval-after-load "ivy-mode"
  (define-key ivy-minibuffer-map (kbd "C-<up>") 'ivy-previous-line-and-call))

(defun my-ivy-switch-buffer (regex-list)
  (let ((ivy-ignore-buffers regex-list))
    (ivy-switch-buffer)))

(defun my-ivy-buffers-no-stars ()
  "ignore everything starting with a star along with whatever ivy's defaults are"
  (interactive)
  (my-ivy-switch-buffer (append ivy-ignore-buffers `("^\*"))))
