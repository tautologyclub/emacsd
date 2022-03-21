(require 'face-remap)
(defvar highlight-focus:last-buffer nil)
(defvar highlight-focus:cookie nil)
(defvar highlight-focus:app-has-focus t)
(defvar highlight-focus:face 'default)
(defvar highlight-focus:face-property :background)
(defvar highlight-focus:face-property-value "white")
(defvar highlight-focus:face-property-value-on "gainsboro")
(defvar highlight-focus:face-property-value-off "spring green")
(setq highlight-focus:face-property-value-on "light gray")
(setq highlight-focus:face-property-value-off "dark gray")
;; --- even todoier ---
(set-face-attribute 'fringe nil
                    :background "light gray")
(set-face-attribute 'term nil
                    :background "light gray")
(set-face-attribute 'term nil
                    : "light gray")

(defun highlight-focus:check ()
  "Check if focus has changed, and if so, update remapping."
  (condition-case nil
      (let ((current-buffer (and highlight-focus:app-has-focus (current-buffer))))
        (unless (or (minibufferp) (eq highlight-focus:last-buffer current-buffer))
          (when (and highlight-focus:last-buffer highlight-focus:cookie)
            (with-current-buffer highlight-focus:last-buffer
              (face-remap-add-relative
               highlight-focus:face
               highlight-focus:face-property
               highlight-focus:face-property-value-off)))
          (setq highlight-focus:last-buffer current-buffer)
          (when current-buffer
            (setq highlight-focus:cookie
                  (face-remap-add-relative
                   highlight-focus:face
                   highlight-focus:face-property
                   highlight-focus:face-property-value-on)))))
    (error (setq highlight-focus:last-buffer nil))))

(defun highlight-focus:app-focus (state)
  (setq highlight-focus:app-has-focus state)
  (highlight-focus:check))

(defadvice other-window (after highlight-focus activate)
  (highlight-focus:check))
(defadvice select-window (after highlight-focus activate)
  (highlight-focus:check))
(defadvice select-frame (after highlight-focus activate)
  (highlight-focus:check))
(defadvice select-frame-set-input-focus (after highlight-focus activate)
  (highlight-focus:check))

(add-hook 'window-configuration-change-hook 'highlight-focus:check)
(add-hook 'focus-in-hook (lambda () (highlight-focus:app-focus t)))
(add-hook 'focus-out-hook (lambda () (highlight-focus:app-focus nil)))
