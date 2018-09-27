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

(defcustom counsel-bar-filter-regex "^*" "Fuasfasf." :group 'counsel-bar)
(setq counsel-bar-filter-regex nil)

(defun counsel-bar--filtered-insert (candidate &optional number)
  "Insert CANDIDATE unless it satifies predicate, NUMBER too."
  ;; (unless (string-match-p counsel-bar-filter-regex candidate)
  (if number (insert (format "%-3s" number)))
  (insert (propertize (concat candidate "\n") 'face font-lock-comment-face)))
;; )

(defun counsel-bar-get-window () (interactive)
  "Asf ff ass."
  (let ((current-window (selected-window))
        ;; Get split new window.
        (new-window (split-window
                     (selected-window)
                     counsel-bar-width
                     t)))
    ;; Select split window.
    (setq counsel-bar-window ;; todo: -- buffer local
          (if counsel-bar-right-side
              ;; Select right window when `counsel-bar-right-side' is enable.
              new-window
            ;; Otherwise select left widnow.
            current-window))
    (switch-to-buffer (concat "*counsel-bar*<" (buffer-name) ">"))
    (mapcar* 'counsel-bar--filtered-insert
             (sort (counsel-projectile--project-buffers) 'string<)
             (number-sequence 1 (length (counsel-projectile--project-buffers))))

    (other-window 1) ;; hacky :(

    )
  )

(counsel-bar-get-window)
(global-set-key (kbd "C-2") 'counsel-bar-get-window)

(setq list2 '("apa" "banan"))
(setq list1 '("1" "2"))
(mapcar* (lambda (x y) (message (concat x y))) list1 list2)

(provide 'counsel-bar)
;;; counsel-bar.el ends here
