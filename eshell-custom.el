;; (setq eshell-mode-hook nil)
(add-hook 'eshell-mode-hook (lambda ()
                              (setq pcomplete-cycle-completions nil)))
(add-hook 'eshell-mode-hook #'company-mode)
(add-hook 'eshell-mode-hook (lambda ()
                              (setq company-backends '(company-capf))))
(add-hook 'eshell-mode-hook (lambda ()
                              (define-key eshell-mode-map (kbd "M-s") nil)))
(add-hook 'eshell-mode-hook (lambda ()
                              (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)))

(setq eshell-prompt-function
      (lambda nil
        (concat
         (propertize (eshell/pwd) 'face `(:foreground "pink"))
         (propertize " $ " 'face `(:foreground "gainsboro")))))
(setq eshell-highlight-prompt nil)
