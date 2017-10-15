;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Irony
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; ;; Use comapny-mode with Irony
;; (require 'company)
;; (with-eval-after-load 'company

;;   (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;; (setq company-backends (delete 'company-semantic company-backends))
;; ;; Enable tab-completion with no delay
;; (setq company-idle-delay 0)
;; (define-key c-mode-base-map (kbd "<S-SPC>") 'company-complete)
;; ;; Add support for completing C/C++ headers
;; (require 'company-irony-c-headers)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))
;; )
;; Integrate Irony with Flycheck
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; Set cppcheck standard to C++11
(setq irony-additional-clang-options '("-std=gnu99"
                       "-I/home/benjamin/workspace/alkit/"))
