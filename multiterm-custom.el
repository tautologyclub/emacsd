
(require 'multi-term)
(require 'counsel-term)

(setq multi-term-program "/bin/bash")
(setq term-prompt-regexp "^$\\ ")
(csetq multi-term-buffer-name "TERM")
(ansi-color-for-comint-mode-on)

(define-key term-mode-map (kbd "C-p") 'projectile-command-map)
(define-key term-mode-map (kbd "C-x t") 'term-toggle-mode-w/warning)
(define-key term-mode-map (kbd "H-M-t") 'term-toggle-mode-w/warning)

(setq term-bind-key-alist nil)
(setq term-bind-key-alist
  '(
    ("C-g"           . (lambda () (interactive) (term-send-raw-string "")))
    ("H-w"           . counsel-term-ff)
    ("H-c"           . counsel-term-cd)
    ("M-r"           . counsel-term-history)
    ("H-f"           . avy-goto-word-or-subword-1)
    ("H-k"           . (lambda () (interactive) (term-send-raw-string "")))
    ("C-d"           . term-send-raw)
    ("C-p"           . projectile-command-map)
    ("C-l"           . forward-char)
    ("C-h"           . backward-char)
    ("C-S-n"         . term-updir)
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
    ("H-M-t"         . term-toggle-mode-w/warning)
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

(defun benjamin/sh-hook ()
  "My hook for shell mode."
  (local-set-key (kbd "C-c C-c") 'dropdown-launch-me)
  (local-set-key (kbd "C-c C-t") 'multiterm-launch-me)
  (local-set-key (kbd "C-c C-,") 'multiterm-source-me)
  (local-set-key (kbd "C-c C-.") 'dropdown-source-me)
  )
(add-hook 'sh-mode-hook 'benjamin/sh-hook)






;; hey
