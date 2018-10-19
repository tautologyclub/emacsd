(require 'counsel)
(require 'bookmark)

;;;###autoload
(defun counsel-bookmark-current-buffer-file ()
  "Like usual but with current path as initial input."
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

;;;###autoload
(defun ivy-switch-buffer-no-leading-stars ()
  (interactive)
  (minibuffer-with-setup-hook (lambda () (insert "!\*"))
    (call-interactively #'ivy-switch-buffer))
  )

;;;###autoload
(defun swiper-pre-insert-symbol ()
  (interactive)
  (minibuffer-with-setup-hook (lambda () (insert ivy--default))
    (call-interactively #'swiper)))

;;;###autoload
(defun ivy-kill-buffer ()
  (interactive)
  (ivy-set-action 'kill-buffer)
  (ivy-call)
  (ivy--reset-state ivy-last)
  (ivy-set-action 'ivy--switch-buffer-action))

;;;###autoload
(defun ivy-jump-to-multiterm ()
  (interactive)
  (ivy-quit-and-run
    (let ((default-directory ivy--directory))
      (multi-term))))



(provide 'ivy-addons)
;;; ivy-addons.el ends here
