;;; counsel-bar.el --- Summary:
;;; Commentary:
;;; Code:

(require 'projectile)
(require 'counsel-projectile)

(defcustom counsel-bar-right-side nil "Ha." :group 'counsel-bar)
(defcustom counsel-bar-width 20 "Ha." :group 'counsel-bar)
(defcustom counsel-bar-filter-regex "^\\*"
  "Fuasfasf."
  :group 'counsel-bar
  :type 'string)

(defcustom counsel-bar-follow-around nil
  "Fuasfasf."
  :group 'counsel-bar
  :type 'boolean)
(setq counsel-bar-follow-around nil)

(defvar counsel-bar-window nil
  "Speedbar window.")
(defvar counsel-bar-mode-map (make-sparse-keymap)
  "Map for `nav-mode'.")
(defvar counsel-bar-active-map (make-sparse-keymap)
  "Active minor mode map.")

(defvar counsel-bar--timer)
(global-set-key (kbd "H-M-j") 'counsel-bar-mode)

(defadvice other-window (after avoid-counsel-bar)
  "Avoid counsel-bar window advice."
  (when (eq (current-buffer) (get-buffer (counsel-bar--own-name)))
    (other-window 1)))

(define-minor-mode counsel-bar-mode
  "Do some shit. "
  :group 'counsel-bar
  :global t
  :keymap counsel-bar-mode-map
  (if counsel-bar-mode
      ;; -- activate ----
      (progn
        (add-hook 'focus-in-hook 'counsel-bar-open-window);
        (add-hook 'focus-out-hook 'counsel-bar-open-window);
        (setq counsel-bar--timer (run-with-timer 1 1 'counsel-bar-open-window))
        (counsel-bar-open-window)
        (ad-activate 'other-window))

    ;; -- deactivate  ----
    (ad-deactivate 'other-window)
    (remove-hook 'focus-in-hook 'counsel-bar-open-window);
    (remove-hook 'focus-out-hook 'counsel-bar-open-window);
    (let ((win-to-del (get-buffer-window (counsel-bar--own-name))))
      (when win-to-del (delete-window win-to-del)))
    (cancel-timer counsel-bar--timer)
    (kill-matching-buffers "\*counsel\-bar" nil t)))

(defvar counsel-bar-candidates nil)

;; fixme
(defface counsel-bar-buffer-face
  '((t :inherit 'font-lock-comment-face))
  "Feebleline filename face."
  :group 'counsel-bar)
(set-face-attribute 'counsel-bar-buffer-face nil :height 0.8)
(set-face-attribute 'counsel-bar-buffer-face nil :family "Noto Sans")
(set-face-attribute 'counsel-bar-buffer-face nil :bold nil)
(set-face-attribute 'counsel-bar-buffer-face nil :italic nil)

(defun counsel-bar--insert-candidate (candidate &optional number)
  "Insert CANDIDATE unless it satifies predicate, NUMBER too."
  (if number (insert (propertize (format " %s%-3s" number ")")
                                 'face 'counsel-bar-buffer-face)))
  (insert (propertize (concat candidate "\n")
                      'face 'counsel-bar-buffer-face)))

(defun counsel-bar--filter-candidate (candidate)
  "Ass fff aa CANDIDATE."
  (if (string-match-p counsel-bar-filter-regex candidate) nil t))

(defun counsel-bar--own-name ()
  "The name of the counsel-bar buffer corresponding to current project."
  "*counsel-bar*"
  )

(defun counsel-bar--insert-buffer-list (buffer buflist)
  "Insert BUFLIST into BUFFER."
  (let ((tmp-proj-name (projectile-project-name)))
    (with-current-buffer buffer
      (erase-buffer)
      (insert (propertize (concat "-- " tmp-proj-name " --\n\n")
                          'face 'counsel-bar-buffer-face))
      (mapcar* 'counsel-bar--insert-candidate
               buflist
               (number-sequence 1 (length buflist))))))

(defun counsel-bar--get-project-buffers ()
  "Error catching variant of counsel-projectile--project-buffers."
  (condition-case nil (counsel-projectile--project-buffers) (error nil)))

(defun counsel-bar-open-window ()
  "Asf ff ass."
  (interactive)
  (setq counsel-bar-candidates
        (seq-filter 'counsel-bar--filter-candidate
                    (sort (counsel-bar--get-project-buffers) 'string<)))

  (if (and counsel-bar-mode counsel-bar-candidates)
      ;; replicate cuz it's buffer local
      (let ((active-buffer (current-buffer))
            (tmp-counsel-bar-candidates counsel-bar-candidates)
            (existing-bar-window (get-buffer-window (counsel-bar--own-name)
                                                    'visible)))
        (if existing-bar-window
            (counsel-bar--insert-buffer-list (get-buffer
                                              (counsel-bar--own-name))
                                             tmp-counsel-bar-candidates)
          (split-window (selected-window) counsel-bar-width t)
          (counsel-bar--insert-buffer-list (switch-to-buffer
                                            (counsel-bar--own-name))
                                           tmp-counsel-bar-candidates)
          (set-window-dedicated-p existing-bar-window t)
          (window-preserve-size existing-bar-window t t)
          (setq window-size-fixed nil)
          ;; (let ((fit-window-to-buffer-horizontally t))
          ;; (fit-window-to-buffer)) ;; todo
          (other-window 1)))))

(defun self-insert-or-buffer-kill (&optional arg)
  (interactive "P")
  (if arg (kill-buffer (nth (- arg 1) counsel-bar-candidates))
    (self-insert-command 1)))

(defun self-insert-or-buffer-jump (&optional arg)
  (interactive "P")
  (if arg (switch-to-buffer (nth (- arg 1) counsel-bar-candidates))
    (self-insert-command 1)))

(defun self-insert-or-buffer-jump-other-window (&optional arg)
  (interactive "P")
  (if arg (switch-to-buffer-other-window (nth (- arg 1) counsel-bar-candidates))
    (self-insert-command 1)))

(define-key counsel-bar-mode-map (kbd "j") 'self-insert-or-buffer-jump)
(define-key counsel-bar-mode-map (kbd "J") 'self-insert-or-buffer-jump-other-window)
(define-key counsel-bar-mode-map (kbd "K") 'self-insert-or-buffer-kill)


(provide 'counsel-bar)
;;; counsel-bar.el ends here
