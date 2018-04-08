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

;; Personal keyboard layout mappings -- deprecated!
(defun set-kblayout-swedish ()
  "Set layout to swedish."
  (interactive)
  (shell-command "setxkbmap -layout se"))

(defun set-kblayout-benjamin ()
  "Set layout to benjaminish."
  (interactive)
  (shell-command "setxkbmap us; xmodmap ~/.Xmodmap")
  (shell-command "/bin/bash ~/.emacs.d/HOME/xcape-restart.sh"))
