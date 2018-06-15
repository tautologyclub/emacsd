;;; package --- Summary:
;;; Code:
;;; Commentary:

(defcustom linux-src-root "~/repos/linux/"
  "Location of kernel source tree root.

Make sure it ends with a slash."
  :type 'string
  :group 'kernel-dev)

(defun kconfig-option-at-point ()
  "Open Kconfig documentation for CONFIG_OPTION at point."
  (interactive)
  (let ((symatp (thing-at-point 'symbol)))
    ;; Check if symbol-at-point is all uppercase
    (unless (equal (upcase symatp) symatp)
      (error "No kernel config option at point!"))
    (let ((conf (replace-regexp-in-string "^CONFIG_" "config " symatp t)))
      (let ((grep-result (shell-command-to-string
                          (concat "cd " linux-src-root " && "
                                  "grep --color -nHri --include=Kconfig \""
                                  conf "$\" 2>/dev/null"))))
        (let ((res-list (split-string grep-result ":")))
          (let ((kconf (pop res-list))
                (line (pop res-list)))
            (unless (and kconf line)
              (error (concat conf " not documented!")))
            (find-file (concat linux-src-root kconf))
            (goto-line (string-to-number line))))))))

(defun kconfig-option-at-point-arbitrary-root (root)
  "Like the normal function but with ROOT as src root."
  (let ((linux-src-root root))
    (call-interactively 'kconfig-option-at-point)))

(provide 'kernel-dev-mode)
;;; kernel-dev-mode.el ends here
