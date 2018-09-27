;;; counsel-bar.el --- Summary:
;;; Commentary:
;;; Code:

(defcustom counsel-bar-right-side nil "Ha." :group 'counsel-bar)
(defcustom counsel-bar-width 20 "Ha." :group 'counsel-bar)
(setq counsel-bar-width 30)

(defvar counsel-bar-window nil
  "Speedbar window.")
(defvar counsel-bar-mode-map (make-sparse-keymap)
  "Map for `nav-mode'.")
(defvar counsel-bar-active-map (make-sparse-keymap)
  "Active minor mode map.")

(define-minor-mode counsel-bar-mode
  "Do some shit. "
  :group 'counsel-bar
  :global nil
  :keymap counsel-bar-mode-map
  (if counsel-bar-mode
      (progn )
    ;;disable
    ))

(define-minor-mode counsel-bar-active-mode
  "Do some shit. "
  :group 'counsel-bar
  :global nil
  :keymap counsel-bar-active-map
  (if counsel-bar-active-mode
      (progn )
    ;;disable
    ))

(defvar counsel-bar-candidates nil)
(make-variable-buffer-local 'counsel-bar-candidates)

(defcustom counsel-bar-filter-regex "^\\*"
  "Fuasfasf."
  :group 'counsel-bar
  :type 'string)

(defun counsel-bar--insert (candidate &optional number)
  "Insert CANDIDATE unless it satifies predicate, NUMBER too."
  (if number (insert (format " %-3s" number)))
  (insert (propertize (concat candidate "\n")
                      'face font-lock-variable-name-face)))

(defun counsel-bar--filter-candidate (candidate)
  "Ass fff aa CANDIDATE."
  (if (string-match-p counsel-bar-filter-regex candidate) nil t))

(defun counsel-bar-open-window ()
  "Asf ff ass."
  (interactive)
  (setq counsel-bar-candidates
        (seq-filter 'counsel-bar--filter-candidate
                    (sort (counsel-projectile--project-buffers) 'string<)))
  (let ((current-window (selected-window))
        (tmp-counsel-bar-candidates counsel-bar-candidates)
        (new-window (split-window
                     (selected-window)
                     counsel-bar-width
                     t)))
    (switch-to-buffer (concat "*counsel-bar*<" (projectile-project-name) ">"))
    (insert (propertize (concat "-- " (projectile-project-name) " --\n\n")
                        'face font-lock-keyword-face))
    (mapcar* 'counsel-bar--insert
             (sort tmp-counsel-bar-candidates 'string<)
             (number-sequence 1 (length tmp-counsel-bar-candidates)))
    (counsel-bar-active-mode)

    (unless counsel-bar-right-side (other-window 1))))

(global-set-key (kbd "C-2") 'counsel-bar-open-window)

(mapc
 (lambda (x)
   (funcall
    'define-key counsel-bar-mode-map
    (kbd (concat "M-s " (number-to-string x) " RET"))
    `(lambda () (interactive)
      (switch-to-buffer (nth (- ,x 1) counsel-bar-candidates)))))
 (number-sequence 1 70))


(provide 'counsel-bar)
;;; counsel-bar.el ends here
