;;; Summary --- helm-addons.el
;;; Commentary:
;;; Code:

(require 'helm-buffers)

(defun helm-display-mode-line (source &optional force)
  "Hey. SOURCE FORCE." "")

(defun helm-toggle-header-line ()
  (if (= (length helm-sources) 1)
      (set-face-attribute 'helm-source-header nil :height 0.1)
    (set-face-attribute 'helm-source-header nil :height 1.0)))
(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)

(defun benjamin/helm-buffers-list ()
  "My hacky helm-buffers hack."
  (interactive)
  (let ((helm-mode-was-active helm-mode))
    (unwind-protect
        (progn
          (helm-mode 1)
          (unless helm-source-buffers-list
            (setq helm-source-buffers-list
                  (helm-make-source "Buffers" 'helm-source-buffers)))
          (let ((helm-split-window-default-side 'right)
                (helm-split-window-inside-p t)
                (helm-display-buffer-default-width 38)
                (truncate-lines t)
                (helm-display-header-line nil))
            (helm :sources              '(helm-source-buffers-list)
                  :buffer               "*helm buffers*"
                  :keymap               helm-buffer-map
                  :input                "\!\\* "
                  :truncate-lines       helm-buffers-truncate-lines))))
    (unless helm-mode-was-active
      (helm-mode -1))))

(defun benjamin/helm-buffers-persistent-kill (_buffer)
  (let ((marked (helm-marked-candidates)))
    (unwind-protect
        (cl-loop for b in marked do
		         (progn (helm-preselect
				         (format "^%s"
						         (helm-buffers--quote-truncated-buffer b)))
				        (helm-buffers-persistent-kill-1 b)
				        (message nil)
				        (helm--remove-marked-and-update-mode-line b)))
      (with-helm-buffer
        (setq helm-marked-candidates nil
              helm-visible-mark-overlays nil))
      (helm-force-update (helm-buffers--quote-truncated-buffer
                          (helm-get-selection))))))

(defun benjamin/helm-kill-buffer ()
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'kill-action
                  '(benjamin/helm-buffers-persistent-kill . never-split))
    (helm-execute-persistent-action 'kill-action)))

(defun helm-backspace ()
  (interactive)
  (condition-case nil (backward-delete-char 1)
    (error (helm-keyboard-quit))))

(provide 'helm-addons)
;;; helm-addons.el ends here
