;;; kill-at-point --- Summary: Obvious extensions to thing-at-point

(require 'thingatpt)
(require 'expand-region)

;;; Commentary:

;;; Code:

;;;###autoload
(defun kill-thing-at-point (thing)
  "Kill whole THING at point."
  (let ((message-log-max nil))
    (let ((bounds (bounds-of-thing-at-point thing)))
      bounds (kill-region (car bounds) (cdr bounds)))))

;;;###autoload
(defun kill-word-at-point ()
  "Kill whole word at point."
  (interactive)
  (kill-thing-at-point 'word))

;;;###autoload
(defun kill-symbol-at-point ()
  "Kill whole symbol at point."
  (interactive)
  (kill-thing-at-point 'symbol))

;;;###autoload
(defun kill-sexp-at-point ()
  "Kill whole sexp at point."
  (interactive)
  (kill-thing-at-point 'sexp))

;;;###autoload
(defun kill-list-at-point ()
  "Kill whole list at point."
  (interactive)
  (kill-thing-at-point 'list))

;;;###autoload
(defun kill-string-at-point ()
  "Kill whole string at point."
  (interactive)
  (kill-thing-at-point 'string))

;;;###autoload
(defun kill-inner ()
  "Kill inside matching delimiters, including double quotes."
  (interactive)
  (if (er--point-inside-string-p)
      (save-excursion (er/mark-inside-quotes)
                      (call-interactively 'kill-region))
  (let ((bounds (bounds-of-thing-at-point 'list))) bounds
       (let ((beg (car bounds)))
         (kill-region (+ 1 beg) (- (cdr bounds) 1))
         (if (equal (point) beg)
             (forward-char 1))))))

;;;###autoload
(defun copy-thing-at-point (thing)
  "Add THING at point to kill ring."
  (let ((bounds (bounds-of-thing-at-point thing)))
    bounds (kill-ring-save (car bounds) (cdr bounds))))

;;;###autoload
(defun copy-word-at-point ()
  "Add word at point to kill ring."
  (interactive)
  (copy-thing-at-point 'word))

;;;###autoload
(defun copy-symbol-at-point ()
  "Add symbol at point to kill ring."
  (interactive)
  (copy-thing-at-point 'symbol))

;;;###autoload
(defun copy-sexp-at-point ()
  "Add sexp at point to kill ring."
  (interactive)
  (copy-thing-at-point 'sexp))

;;;###autoload
(defun copy-list-at-point ()
  "Add list at point to kill ring."
  (interactive)
  (copy-thing-at-point 'list))

;;;###autoload
(defun copy-string-at-point ()
  "Add string at point to kill ring."
  (interactive)
  (copy-thing-at-point 'string))

(provide 'kill-at-point)
;;; kill-at-point ends here
