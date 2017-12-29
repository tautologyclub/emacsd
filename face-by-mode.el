(defun set-boring-prog-mode-face ()
  (interactive)
  (setq buffer-face-mode-face '(:background "gray" :foreground "black"))
  (setq font-lock-comment-face '(:foreground "#253f14"))
  (setq font-lock-builtin-face '(:foreground "#572a6b" :weight semibold))
  (setq font-lock-preprocessor-face '(:foreground "#572a6b" :weight semibold))
  (setq font-lock-string-face '(:foreground "#14314c"))
  (setq font-lock-function-name-face '(:foreground "#d3aa83"))
  (buffer-face-mode)
  )

(defun set-boring-buffer-face ()
   "Kind of a dry bland face for some stuff."
   (interactive)
   (setq buffer-face-mode-face '(:background "gray" :foreground "black"))
   (buffer-face-mode))

 ;; Set default font faces for Info and ERC modes
(add-hook 'help-mode-hook 'set-boring-buffer-face)
(add-hook 'Info-mode-hook 'set-boring-buffer-face)
(add-hook 'erc-mode-hook  'set-boring-buffer-face)
(add-hook 'org-mode-hook 'set-boring-buffer-face)
;; (add-hook 'prog-mode-hook 'set-boring-prog-mode-face)

(global-set-key (kbd "H-f") 'describe-face)
