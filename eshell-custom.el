(add-hook 'eshell-mode-hook (lambda ()
                              (setq pcomplete-cycle-completions nil)))
(add-hook 'eshell-mode-hook (lambda ()
                              (define-key eshell-mode-map (kbd "M-s") nil)))
