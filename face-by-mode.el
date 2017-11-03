;; Use variable width font faces in current buffer
 (defun my-buffer-face-mode-variable ()
   "Set font to a variable width (proportional) fonts in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:family "Symbola" :height 100 :width semi-condensed))
   (buffer-face-mode))

 ;; Use monospaced font faces in current buffer
 (defun my-buffer-face-mode-fixed ()
   "Sets a fixed width (monospace) font in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:background "gray" :foreground "black"))
   (buffer-face-mode))

(add-hook 'help-mode-hook 'my-buffer-face-mode-fixed)
