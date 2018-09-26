
;;;###autoload
(defun i3-workspace-dim (dim)
  "Height of current i3 workspace in pixels."
  (string-to-number
   (shell-command-to-string
    (concat "i3-msg -t get_workspaces | \
        jq '.[] | select(.focused==true).rect." dim "'"))))

(defun fix-frame-face ()
  "Fix multi monitor face stuff."
  (set-frame-font
   (if (<= (i3-workspace-dim "height") 1080)
       "Inconsolata-8"
     "Inconsolata-10")
   nil nil))

(add-hook 'focus-in-hook 'fix-frame-face)

(provide 'some-i3-defuns)
;;; some-i3-defuns.el ends here
