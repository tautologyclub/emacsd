;;; asdf

;;; Code:

(defvar original-cursor-color (face-attribute 'cursor :background))
(setq original-cursor-color "#699dce")

(defun cursor-color-notification ()
  "Signal something by temporarily changing cursor color."
  (run-at-time "0.5 sec" nil (lambda ()
                               (set-cursor-color original-cursor-color)))
  (set-cursor-color "yellow"))

(defadvice kill-ring-save (after cursor-notifier-kill-ring-save compile activate) (cursor-color-notification))
(defadvice kill-line-save (after cursor-notifier-kill-ring-save compile activate) (cursor-color-notification))
(defadvice push-mark      (after cursor-notifier-kill-ring-save compile activate) (cursor-color-notification))
(defadvice save-buffer    (after cursor-notifier-kill-ring-save compile activate) (cursor-color-notification))
(defadvice keyboard-quit (before cursor-notifier-kill-ring-save compile activate) (cursor-color-notification))

(defadvice keyboard-quit (before clear-quit-msg compile activate)
  (run-at-time "0.2 sec" nil 'message ""))
(defadvice minibuffer-keyboard-quit (before clear-quit-msg compile activate)
  (run-at-time "0.2 sec" nil 'message ""))
