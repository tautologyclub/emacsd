(require 'term)
(add-hook 'term-mode-hook 'my-multiterm-modeline-off)

(defun my-multiterm-modeline-off ()
  (add-hook 'after-change-major-mode-hook
            (lambda () (setq mode-line-format nil))))


;; does not play nicely with tabbar-mode
(defun jnm/term-toggle-mode ()
  "Toggles term between line mode and char mode"
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
