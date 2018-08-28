;;; package --- Summary:
;;; Code:
;;; Commentary:

(defcustom linux-src-root "~/repos/linux/"
  "Default location of kernel source tree root.

Make sure it ends with a slash."
  :type 'string
  :group 'kernel-dev)

(defcustom uboot-src-root "/home/benjamin/work/consat/nxp-android-bsp/uboot-imx/"
  "Default location of uboot source tree root.

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

(defun kconfig-option-at-point-projectile-root ()
  (interactive)
  "Like the normal function but with projectile-root as src root."
  (let ((linux-src-root (projectile-project-root)))
    (call-interactively 'kconfig-option-at-point)))

(defun kconfig-option-at-point-uboot ()
  (interactive)
  (kconfig-option-at-point-arbitrary-root uboot-src-root))

(provide 'kernel-dev-mode)
;;; kernel-dev-mode.el ends here
