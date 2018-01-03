(defun benjamin/laptop-mode ()
  (interactive)
  (custom-set-faces '(default ((t (:height 105 :width normal)))))
  (shell-command "xrandr-vga2 off")
  )

(defun benjamin/desktop-mode ()
  (interactive)
  (custom-set-faces '(default ((t (:height 90 :width normal)))))
  (shell-command "xrandr-vga2 on")
  )

(defun benjamin/notify (arg)
  (shell-command (format "notify-send '%s'" arg)))
