(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "#545454")

;; Fix for increasing font-size under fci-mode
(require 'zoom-frm)
(if window-system (progn
                   (global-set-key (kbd "C--" ) 'zoom-frm-out)
                   (global-set-key (kbd "C-=" ) 'zoom-frm-in)))

(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode t)))

;(add-hook 'prog-mode-hook 'fci-mode)
