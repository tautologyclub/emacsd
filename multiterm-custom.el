(require 'multi-term)
(setq multi-term-program "/bin/bash")

(require 'term)
(add-hook 'term-mode-hook 'my-multiterm-modeline-off)

(defun my-multiterm-modeline-off ()
  (add-hook 'after-change-major-mode-hook
            (lambda () (setq mode-line-format nil))))

(defun jnm/term-toggle-mode ()
  "Toggles term between line mode and char mode."
  (interactive)
  (if (term-in-line-mode)
      (progn
        (term-char-mode)
        (setq header-line-format nil)
        )
    (progn
      (term-line-mode)
      (let* ((warning "   *** Line Mode ***   ")
             (space (+ 6 (- (window-width) (length warning))))
             (bracket (make-string (/ space 2) ?-))
             (warning (concat bracket warning bracket)))
        (setq header-line-format
              (propertize  warning 'face '(:foreground "white" :background "red3")))
        ))))

;; fixme...
(defcustom term-bind-key-alist
  '(
    ("C-S-c" . term-interrupt-subjob)
    ("C-c C-c" . term-interrupt-subjob)
    ("C-p" . previous-line)
    ("C-n" . next-line)
    ("C-s" . swiper)
    ("C-r" . isearch-backward)
    ("C-x t" . jnm/term-toggle-mod)
    ("C-m" . term-send-raw)
    ("C-S-x" . term-send-raw)
    )
  "The key alist that will need to be bind.
If you do not like default setup, modify it, with (KEY . COMMAND) format."
  :type 'alist
  :group 'multi-term)
(ansi-color-for-comint-mode-on)
