
(require 'semantic/bovine/c)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(add-to-list 'semantic-lex-c-preprocessor-symbol-file
             "/usr/lib/clang/5.0.0/include/stddef.h")

(setq c-default-style "linux" c-basic-offset 4)
(require 'semantic)
(require 'company)
(require 'cc-mode)
(require 'helm-gtags)
(require 'gud)
(require 'flycheck)

(defun c-occur-overview ()
  "Display an occur buffer with declarations/definitions/etc.  Also, resize somewhat."
  (interactive)
  (let ((list-matching-lines-face nil))
    (occur "^[a-z].*("))
  (enlarge-window 25)
  (hydra-errgo/body))

(define-key c-mode-base-map (kbd "M-q") nil)
(define-key c-mode-base-map (kbd "M-e") nil)
(define-key c-mode-base-map (kbd "M-a") nil)
(define-key c-mode-base-map (kbd "M-j") nil)
(define-key c-mode-base-map (kbd "C-M-a") nil)
(define-key c-mode-base-map (kbd "C-M-e") nil)
(define-key c-mode-base-map (kbd "C-M-j") nil)
(define-key c-mode-base-map (kbd "C-M-k") nil)
(define-key c-mode-base-map (kbd "C-c o") 'c-occur-overview)
(define-key c-mode-base-map (kbd "C-c C-c") 'compile)
(define-key c-mode-base-map (kbd "C-c C-w") 'senator-kill-tag)
(define-key flycheck-mode-map (kbd "C-x f") 'benjamin/flycheck-list-errors)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)

(define-key c-mode-base-map (kbd "M-c") 'hydra-gdb/body)
(define-key gud-mode-map (kbd "M-c") 'hydra-gdb/body)

(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)



(require 'company)
(defun benjamin/c-hook ()
  "You know.  My hook and stuff."
  (subword-mode)
  (auto-fill-mode)
  (flycheck-mode)
  ;; (helm-gtags-mode)
  (irony-mode)
  (company-mode)
  (semantic-mode -1)
  (setenv "GTAGSLIBPATH" "/home/benjamin/.gtags/")
  (set (make-local-variable 'company-backends)
        '((
           company-c-headers
           company-irony
           ;; company-semantic
           ;; company-files
           company-cmake
           ;; company-keywords
           ;; company-gtags
           ;; company-capf
           ))))
(add-hook 'c-mode-hook 'benjamin/c-hook)
(add-hook 'c++-mode-hook 'benjamin/c-hook)


(setq helm-gtags-auto-update t)             ;; feel this one out.
(setq helm-gtags-use-input-at-cursor t)
