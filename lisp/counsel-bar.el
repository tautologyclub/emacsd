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

(define-minor-mode counsel-bar-mode
  "Do some shit. "
  :group 'counsel-bar
  :global nil
  :keymap counsel-bar-mode-map
  (if counsel-bar-mode
      (progn nil)
    ;;disable
    ))

(defvar counsel-bar-candidates nil)
(make-variable-buffer-local 'counsel-bar-candidates)

(defcustom counsel-bar-filter-regex "^\\*" "Fuasfasf." :group 'counsel-bar :type 'string)
(setq counsel-bar-filter-regex "^\\*")

(defun counsel-bar--insert (candidate &optional number)
  "Insert CANDIDATE unless it satifies predicate, NUMBER too."
  (if number (insert (format " %-3s" number)))
  (insert (propertize (concat candidate "\n") 'face font-lock-variable-name-face))
  )

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
    (switch-to-buffer (concat "*counsel-bar*<" (buffer-name) ">"))
    (insert (propertize (concat "-- " (projectile-project-name) " --\n") 'face font-lock-keyword-face))
    (mapcar* 'counsel-bar--insert
             (sort tmp-counsel-bar-candidates 'string<)
             (number-sequence 1 (length tmp-counsel-bar-candidates)))

    (unless counsel-bar-right-side (other-window 1)) ;; hacky :(
    ))

(global-set-key (kbd "C-2") 'counsel-bar-open-window)

(global-set-key (kbd "M-s 1 RET") (lambi (when counsel-bar-candidates (switch-to-buffer (nth 0 counsel-bar-candidates )))))
(global-set-key (kbd "M-s 2") (lambi (switch-to-buffer (nth 1 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 3") (lambi (switch-to-buffer (nth 2 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 4") (lambi (switch-to-buffer (nth 3 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 5") (lambi (switch-to-buffer (nth 4 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 6") (lambi (switch-to-buffer (nth 5 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 7") (lambi (switch-to-buffer (nth 6 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 8") (lambi (switch-to-buffer (nth 7 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 9") (lambi (switch-to-buffer (nth 8 counsel-bar-candidates ))))
(global-set-key (kbd "M-s 10 RET") (lambi (switch-to-buffer (nth 9 counsel-bar-candidates ))))

(provide 'counsel-bar)
;;; counsel-bar.el ends here
