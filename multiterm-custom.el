

;;;###autoload
(defun dropdown-multiterm ()
  "Split window, open a terminal below and move focus to it."
  (interactive)
  (split-window-below)
  (windmove-down)
  (multi-term))

;;;###autoload
(defun jnm/term-toggle-mode ()
  "Toggle term between line mode and char mode."
  (interactive)
  (if (term-in-line-mode)
      (progn
        (term-char-mode)
        (setq header-line-format nil)
        )
    (progn
      (term-line-mode)
      (let* ((warning "   *** Line Mode ***   ")
             (space (+ 6 (- (window-width) (length warning))))
             (bracket (make-string (/ space 2) ?-))
             (warning (concat bracket warning bracket)))
        (setq header-line-format
              (propertize  warning 'face '(:foreground "white" :background "red3")))
        ))))

;;;###autoload
(defun last-term-buffer (l)
"Return most recently used term buffer L."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

;;;###autoload
(defun get-term ()
"Switch to the term buffer last used, or create a new one if none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

;; ;; More fixes for multi-term ;; todo: do these do anything?
;; (eval-after-load "term"
;;   '(progn
;;      ;; Fix forward/backward word when (term-in-char-mode).
;;      (define-key term-raw-map (kbd "<C-left>")
;;        (lambda () (interactive) (term-send-raw-string "\eb")))
;;      (define-key term-raw-map (kbd "<C-right>")
;;        (lambda () (interactive) (term-send-raw-string "\ef")))
;;      (define-key term-raw-map (kbd "C-_") nil)
;;      (define-key term-raw-map (kbd "C-k") 'term-send-raw)
;;      (define-key term-raw-map (kbd "C-j") 'next-line)
;;      (define-key term-raw-map (kbd "C-j") 'term-send-raw)
;;      (define-key term-raw-map (kbd "C-r") 'term-send-backspace)
;;      (define-key term-raw-map (kbd "C-d") 'term-send-del)
;;      (define-key term-raw-map (kbd "C-f") 'right-word)
;;      (define-key term-raw-map (kbd "C-q") 'left-word)
;;      (define-key term-raw-map (kbd "C-p") 'projectile-command-map)
;;      ;; Disable killing and yanking in char mode (term-raw-map).
;;      (mapc
;;       (lambda (func)
;;         (eval `(define-key term-raw-map [remap ,func]
;;                  (lambda () (interactive) (ding)))))
;;       '(backward-kill-paragraph
;;         backward-kill-sentence backward-kill-sexp backward-kill-word
;;         bookmark-kill-line kill-backward-chars kill-backward-up-list
;;         kill-forward-chars kill-line kill-paragraph kill-rectangle
;;         kill-region kill-sentence kill-sexp kill-visual-line
;;         kill-whole-line kill-word subword-backward-kill subword-kill
;;         yank yank-pop yank-rectangle))))

;; (define-key term-mode-map (kbd "C-p") 'projectile-command-map)
;; (define-key term-mode-map (kbd "C-x t") 'jnm/term-toggle-mode)

(require 'counsel-term)

(setq term-bind-key-alist nil)
(setq term-bind-key-alist
  '(
    ("("             . (lambda () (interactive) (term-send-raw-string "()")))
    ("["             . (lambda () (interactive) (term-send-raw-string "[]")))
    ("{"             . (lambda () (interactive) (term-send-raw-string "{}")))
    ("C-c C-x"       . (lambda () (interactive) (term-send-raw-string "")))
    ("C-c C-a"       . (lambda () (interactive) (term-send-raw-string "")))
    ("C-x t"         . jnm/term-toggle-mode)
    ("C-d"           . term-send-raw)
    ("C-p"           . projectile-command-map)
    ("C-l"           . term-send-raw)
    ("C-h"           . backward-char)
    ("<C-m>"         . term-updir)
    ("C-n"           . term-downdir)
    ("H-t"           . jnm/term-toggle-mode)
    ("C-s"           . swiper)
    ("C-r"           . term-send-backspace)
    ("C-m"           . term-send-return)
    ("C-y"           . term-paste)
    ("C-q"           . term-send-backward-word)
    ("C-f"           . term-send-forward-word)
    ("M-p"           . term-send-up)
    ("M-n"           . term-send-down)
    ("<C-backspace>" . term-send-backward-kill-word)
    ("<C-return>"    . term-cd-input)
    ("H-M-k"         . (lambda () (interactive) (volatile-kill-buffer) (previous-buffer)))
    ("M-d"           . term-send-delete-word)
    ("M-,"           . term-send-raw)
    ;; ("M-."           . company-complete)
    ("C-c m"	     . (lambda () (interactive) (term-send-raw-string "mkdir -p ")))
    ("C-c C-s"       . (lambda () (interactive) (term-send-raw-string "sudo ")))
    ("C-c C-u"       . (lambda () (interactive) (term-send-raw-string "sudo ")))
    ("C-c C-l"       . (lambda () (interactive) (term-send-raw-string "ll")))
    ("C-c C-c"       . term-interrupt-subjob)
    ("C-c C-e"       . term-send-esc)
    ("M-r"           . counsel-term-history)
    ("H-c"           . ivy-term-recursive-cd)
    ("H-f"           . ivy-term-ff)
    )
)

;; some shell scripting hax
(defun dropdown-launch-me ()
  "Run current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (shell-command (concat "chmod a+x " buffer-file-name))
    (dropdown-multiterm)
    (term-send-raw-string (concat "./" tmp-filename ""))))

(defun dropdown-source-me ()
  "Source current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (dropdown-multiterm)
    (term-send-raw-string (concat ". " tmp-filename ""))))

(defun multiterm-launch-me ()
  "Run current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (shell-command (concat "chmod a+x " buffer-file-name))
    (multi-term)
    (term-send-raw-string (concat "./" tmp-filename ""))))

(defun multiterm-source-me ()
  "Source current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (multi-term)
    (term-send-raw-string (concat ". " tmp-filename ""))))

(add-hook 'sh-mode-hook (lambda () (interactive)
  (progn
    (local-set-key (kbd "C-c C-c") 'dropdown-launch-me)
    (local-set-key (kbd "C-c C-t") 'multiterm-launch-me)
    (local-set-key (kbd "C-c C-,") 'multiterm-source-me)
    (local-set-key (kbd "C-c C-.") 'dropdown-source-me)
    )))


(provide 'multiterm-custom)
;;; multiterm-custom ends here
