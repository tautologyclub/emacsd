(require 'ediff)
(require 'diff-mode)
(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)
(csetq ediff-diff-options "--text")
(csetq ediff-diff-options "-w --text")

(defvar benjamin/ediff-last-windows nil)
(defun benjamin/store-pre-ediff-winconfig ()
  (setq benjamin/ediff-last-windows (current-window-configuration)))

(defun benjamin/restore-pre-ediff-winconfig ()
  (set-window-configuration benjamin/ediff-last-windows))

(add-hook 'ediff-before-setup-hook #'benjamin/store-pre-ediff-winconfig)
(add-hook 'ediff-quit-hook #'benjamin/restore-pre-ediff-winconfig)

(defun ora-ediff-prepare-buffer ()
  (when (memq major-mode '(org-mode emacs-lisp-mode))
    (outline-show-all)))

(add-hook 'ediff-prepare-buffer-hook 'ora-ediff-prepare-buffer)

(defun ora-ediff-jk ()
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-keymap-setup-hook #'ora-ediff-jk)

;;;###autoload
(defun ora-ediff-hook ())

;;;###autoload
(defun ora-diff-hook ())

(mapc
 (lambda (k)
   (define-key diff-mode-map k
     `(lambda () (interactive)
         (if (region-active-p)
             (replace-regexp "^." ,k nil
                             (region-beginning)
                             (region-end))
           (insert ,k)))))
 (list " " "-" "+"))
