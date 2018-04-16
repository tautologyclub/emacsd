(require 'multi-term)

(setq multi-term-program "/bin/bash")
(setq term-prompt-regexp "^$\\ ")
(csetq multi-term-buffer-name "TERM")
(ansi-color-for-comint-mode-on)



(defun dropdown-multiterm ()
  "Split window, open a terminal below and move focus to it."
  (interactive)
  (split-window-below)
  (windmove-down)
  (multi-term))

(defun dropdown-multiterm-right ()
  "Split window, open a terminal below and move focus to it."
  (interactive)
  (split-window-right)
  (windmove-right)
  (multi-term))

(defun jnm/term-toggle-mode ()
  "Toggles term between line mode and char mode."
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

;; Function for getting last multi-term buffer if one exists, or create a new one if not.
(defun last-term-buffer (l)
  "Return most recently used term buffer L."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

(defun get-term ()
  "Switch to the term buffer last used.

Or create a new one if none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

(require 'counsel-term)

;; More fixes for multi-term
(eval-after-load "term"
  '(progn
     ;; Fix forward/backward word when (term-in-char-mode).
     (define-key term-raw-map (kbd "<C-left>")
       (lambda () (interactive) (term-send-raw-string "\eb")))
     (define-key term-raw-map (kbd "<C-right>")
       (lambda () (interactive) (term-send-raw-string "\ef")))
     (define-key term-raw-map (kbd "C-_") nil)
     (define-key term-raw-map (kbd "C-k") 'previous-line)
     (define-key term-raw-map (kbd "C-j") 'next-line)
     (define-key term-raw-map (kbd "C-r") 'term-send-backspace)
     (define-key term-raw-map (kbd "C-d") 'term-send-del)
     (define-key term-raw-map (kbd "C-f") 'right-word)
     (define-key term-raw-map (kbd "C-q") 'left-word)
     (define-key term-raw-map (kbd "C-p") 'projectile-command-map)
     ;; Disable killing and yanking in char mode (term-raw-map).
     (mapc
      (lambda (func)
        (eval `(define-key term-raw-map [remap ,func]
                 (lambda () (interactive) (ding)))))
      '(backward-kill-paragraph
        backward-kill-sentence backward-kill-sexp backward-kill-word
        bookmark-kill-line kill-backward-chars kill-backward-up-list
        kill-forward-chars kill-line kill-paragraph kill-rectangle
        kill-region kill-sentence kill-sexp kill-visual-line
        kill-whole-line kill-word subword-backward-kill subword-kill
        yank yank-pop yank-rectangle))))

(define-key term-mode-map (kbd "C-p") 'projectile-command-map)
(define-key term-mode-map (kbd "C-x t") 'jnm/term-toggle-mode)
(define-key term-mode-map (kbd "H-M-t") 'jnm/term-toggle-mode)

(setq term-bind-key-alist nil)
(custom-set-variables term-bind-key-alist
  '(
    ("C-g"           . (lambda () (interactive) (term-send-raw-string "")))
    ("H-j"           . completion-at-point) ;; doesn't work, todo...
    ("H-w"           . counsel-term-ff)
    ("H-c"           . counsel-term-cd)
    ("M-r"           . counsel-term-history)
    ("H-f"           . avy-goto-word-or-subword-1)
    ("H-k"           . (lambda () (interactive) (term-send-raw-string "")))
    ("C-d"           . term-send-raw)
    ("C-p"           . projectile-command-map)
    ("C-l"           . forward-char)
    ("C-h"           . backward-char)
    ("C-S-n"         . term-updir)q
    ("C-n"           . term-downdir)
    ("C-s"           . swiper)
    ("C-r"           . term-send-backspace)
    ("C-m"           . term-send-return)
    ("C-y"           . term-paste)
    ("C-q"           . backward-word)
    ("M-q"           . term-send-backward-word)
    ("M-f"           . term-send-forward-word)
    ("M-p"           . term-send-up)
    ("M-n"           . term-send-down)
    ("<C-backspace>" . term-send-backward-kill-word)
    ("<C-return>"    . term-cd-input)
    ("M-d"           . term-send-delete-word)
    ("M-,"           . term-send-raw)
    ("M-."           . company-complete) ;; doesn't work
    ("H-M-t"         . jnm/term-toggle-mode)
    ("C-c C-c"       . term-interrupt-subjob)
    ("C-c C-e"       . term-send-esc)
    ("C-c C-z"       . (lambda () (interactive) (term-send-raw-string "")))
    ("C-c C-x"       . (lambda () (interactive) (term-send-raw-string "")))
    ("C-c C-u"       . (lambda () (interactive) (term-send-raw-string "sudo ")))
    ("H-M-p"         . (lambda () (interactive) (term-send-raw-string "sudo ")))
    ("H-M-u"         . (lambda () (interactive) (term-send-raw-string "sudo ")))
    ("H-M-l"         . (lambda () (interactive) (term-send-raw-string "")))
    ("H-M-f"         . (lambda () (interactive) (term-send-raw-string " fuck")(sleep-for 0.2) (term-send-raw-string "")))
    ("C-x t"         . jnm/term-toggle-mode)
    )
  ;; todo: send-backward-kill-word where?
)

;; some hax
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


(defun benjamin/sh-hook ()
  "My hook for shell mode."
  (local-set-key (kbd "C-c C-c") 'dropdown-launch-me)
  (local-set-key (kbd "C-c C-t") 'multiterm-launch-me)
  (local-set-key (kbd "C-c C-,") 'multiterm-source-me)
  (local-set-key (kbd "C-c C-.") 'dropdown-source-me)
  )
(add-hook 'sh-mode-hook 'benjamin/sh-hook)


;; renaming term buffers cuz I love them
(setq counsel-term--home-dir (expand-file-name "~"))

(setq benjamin/term-rename-prefix "/bin/bash @ ")
(defun benjamin/term-renamer ()
  "Eat poop."
  (concat benjamin/term-rename-prefix
          (replace-regexp-in-string
           counsel-term--home-dir "~"
           default-directory
           )))

(require 'switch-buffer-functions)
(add-hook 'term-mode-hook
          (lambda () (add-hook
                      (make-local-variable
                       'switch-buffer-functions)
                      (lambda (prev cur)
                        (rename-buffer (benjamin/term-renamer) t)))))

;; colorize term-mode buffers in counsel
(defface counsel-buffer-face-term-mode
  '((t :inherit 'font-lock-keyword-face :italic t :bold nil))
  "fuck off")
(custom-set-faces '(counsel-buffer-face-term-mode
                    ((t :inherit 'font-lock-function-name-face))))

(setq ivy-switch-buffer-faces-alist
      '((dired-mode . ivy-subdir)
        (org-mode . org-level-4)))
(add-to-list 'ivy-switch-buffer-faces-alist
             '(term-mode . counsel-buffer-face-term-mode))


(defun benjamin/get-term ()
  "Just kind of a better get-term if you want zany renaming."
  (interactive)
  (let ((term-buffer-candidate (benjamin/term-renamer)))
    (if (get-buffer term-buffer-candidate)
        (switch-to-buffer term-buffer-candidate)
      (message (concat "New term-buffer @ " default-directory))
      (multi-term))))


























;; hey
