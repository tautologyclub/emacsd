(eval-after-load 'pdf-view '(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)  )

(require 'doc-view)
(define-key doc-view-mode-map (kbd "M-g") 'doc-view-goto-page)
(define-key doc-view-mode-map (kbd "j") 'doc-view-next-page)
(define-key doc-view-mode-map (kbd "k") 'doc-view-previous-page)
(define-key doc-view-mode-map (kbd "C-j") 'doc-view-next-line-or-next-page)
(define-key doc-view-mode-map (kbd "C-k") 'doc-view-previous-line-or-previous-page)

(provide 'pdf-custom)

;; 35 candidates:
;;     C-n             doc-view-next-line-or-next-page
;;     C-p             doc-view-previous-line-or-previous-page
;;     C-r             doc-view-search-backward
;;     C-s             doc-view-search
;;     C-t             doc-view-show-tooltip
;;     SPC             doc-view-scroll-up-or-next-page
;;     +               doc-view-enlarge
;;     -               doc-view-shrink
;;     0               doc-view-scale-reset
;;     =               doc-view-enlarge
;;     H               doc-view-fit-height-to-window
;;     K               doc-view-kill-proc
;;     P               doc-view-fit-page-to-window
;;     W               doc-view-fit-width-to-window
;;     g               doc-view-revert-buffer
;;     n               doc-view-next-page
;;     p               doc-view-previous-page
;;     r               doc-view-revert-buffer
;;     DEL             doc-view-scroll-down-or-previous-page
;;     S-SPC           doc-view-scroll-down-or-previous-page
;;     <down>          doc-view-next-line-or-next-page
;;     <find>          doc-view-search
;;     <up>            doc-view-previous-line-or-previous-page
;;     C-c C-c         doc-view-toggle-display
;;     C-c C-t         doc-view-open-text
;;     s b             doc-view-set-slice-from-bounding-box
;;     s m             doc-view-set-slice-using-mouse
;;     s r             doc-view-reset-slice
;;     s s             doc-view-set-slice
;;     M-<             doc-view-first-page
;;     M->             doc-view-last-page
;;     <remap> <backward-page> doc-view-previous-page
;;     <remap> <forward-page> doc-view-next-page
;;     <remap> <goto-line> doc-view-goto-page
;;     <remap> <text-scale-adjust> doc-view-scale-adjust
