
;;; Code:
(require 'org)
(define-key org-mode-map (kbd "C-a")    nil)
(define-key org-mode-map (kbd "C-e")    nil)
(define-key org-mode-map (kbd "M-a")    nil)
(define-key org-mode-map (kbd "M-e")    nil)
(define-key org-mode-map (kbd "C-j")    'next-line)
(define-key org-mode-map (kbd "C-k")    'previous-line)

(provide 'org-custom)