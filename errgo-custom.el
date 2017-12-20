
(defun my-next-error-wrapped (&optional arg reset)
  "Jumps to previous error if at first error jump to last error instead.
Prefix argument ARG says how many error messages to move forwards (or
backwards, if negative). With just C-u as prefix moves to first error"
  (interactive "P")
  (condition-case nil
      (call-interactively 'next-error)
    ('user-error  (next-error 1 t)
                  (my-indicate-error-nav-wrapped 'next))))

(defun my-jump-to-last-error (buffer)
  "Jump to last error in the BUFFER, this assumes that
the error is at last but third line"
  (save-selected-window
    (select-window (get-buffer-window buffer))
    (goto-char (point-max))
    (forward-line -3)
    (call-interactively 'compile-goto-error)))

(defun my-previous-error-wrapped (&optional arg)
  "Jumps to previous error if at first error jump to last error instead.
Prefix argument ARG says how many error messages to move backwards (or
forwards, if negative)."
  (interactive "P")
  (condition-case nil
      (if (compilation-buffer-p (current-buffer))
          (compilation-previous-error 1)
        (call-interactively 'previous-error))
    ('user-error (progn
                   (let ((error-buffer (next-error-find-buffer)))
                     ;; If the buffer has an associated error buffer use it to
                     ;; to move to last error
                     (if (and (not (eq (current-buffer) error-buffer))
                              (compilation-buffer-p error-buffer))
                         (my-jump-to-last-error error-buffer)
                       ;; Otherwise move to last point and invoke previous error
                       (goto-char (point-max))
                       (call-interactively 'previous-error)))))))
