;;;; package --- Summary:
;;; Commentary:
;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa-stable" . "https://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" .
                                 "https://marmalade-repo.org/packages/"))
(package-initialize)
(add-to-list 'load-path "~/repos/use-package")
(require 'use-package)

(defmacro csetq (variable value)
  "Stolen from abo-abo.  VARIABLE and VALUE blabla."
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))
(defmacro lambi (&rest b)
  "Laziest macro in the world!  B etc."
  `(lambda () (interactive),@b))

;; cleaner init.el
(csetq custom-file (expand-file-name "~/.emacs.d/.custom.el"))
(load custom-file)


;-------------------------------------------------------------------------------
; packages
;-------------------------------------------------------------------------------
(use-package	magit
  :custom       (magit-completing-read-function 'ivy-completing-read)
  :after        ivy
  :ensure       t)
(use-package	projectile
  :ensure       t
  :config       (projectile-global-mode 1))
(use-package	ivy
  :ensure       t
  :custom       (ivy-use-virtual-buffers t)
                (ivy-count-format "%d/%d - ")
                (ivy-wrap t)
                (ivy-use-selectable-prompt t)
                (ivy-extra-directories nil)
                (ivy-display-style 'fancy)
                (ivy-ignore-buffers '("\\' "))
  :init         (ivy-mode t))
(use-package	swiper
  :ensure       t
  :after        ivy
  :custom       (counsel-grep-swiper-limit 60000)
                (counsel-rg-base-command
                 (concat "rg -i --no-heading --line-number --max-columns 120 "
			 "--max-count 200 "
			 "--max-filesize 100M --color never %s .")))
(use-package	counsel-term
  :ensure       nil
  :load-path    "~/repos/counsel-term"
  :after        ivy swiper)
(use-package	feebleline
  :ensure       t
  :load-path    "~/.emacs.d/feebleline"
  :custom       (feebleline-show-time nil)
  :config       (feebleline-mode 1))
(use-package	counsel-projectile
  :ensure       t
  :load-path    "~/repos/counsel-projectile"
  :after        projectile)
(use-package	fill-column-indicator
  :ensure       t
  :load-path    "~/repos/Fill-Column-Indicator"
  :config       (fci-mode 1))
(use-package	auto-dim-other-buffers
  :ensure       t
  :custom       (auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
                (auto-dim-other-buffers-face
                 '((t (:background "#242b2d" :foreground "#c4c4c4"))))
  :config       (auto-dim-other-buffers-mode 1))
(use-package	avy
  :ensure       t
  :custom       (aw-keys  '(?a ?s ?e ?w ?d ?f ?g ?j ?k ?l ?p ?o ?m ?n ))
                (avy-keys '(?a ?s ?e ?w ?d ?f ?g ?j ?k ?l ?p ?o ?m ?n )))
(use-package	company
  :ensure       t
  :custom       (company-auto-complete-chars '(?. ?>))    ;; ???
                (company-backends
                 '(company-semantic company-clang company-xcode company-cmake
                                    company-capf company-files
                                    (company-dabbrev-code
                                     company-gtags company-etags
                                     company-keywords)
                                    company-oddmuse company-dabbrev))
                (company-idle-delay 0)                    ;; ???
                (company-minimum-prefix-length 3)
                (company-tooltip-idle-delay 0.5)          ;; ???
                (company-tooltip-limit 20)                ;; ???
  :config       (counsel-mode 1)
                (add-hook 'after-init-hook 'global-company-mode))
(use-package	erc
  :ensure       nil
  :custom       (erc-autojoin-channels-alist (quote (("#emacs"))))
                (erc-nick "g00iekabl00ie")
                (erc-rename-buffers t))
(use-package	multi-term
  :ensure       t
  :custom       (multi-term-program "/bin/bash")
                (term-prompt-regexp "^$\\ ")
                (ansi-color-for-comint-mode-on))
(use-package	eshell
  :ensure       nil
  :custom       (eshell-banner-message
                 "--- eshell ---------------------------------------------------------------------")
                (explicit-shell-file-name "/bin/bash"))
(use-package	elpy
  :ensure       t
  :custom       (elpy-rpc-backend "rope" t)
  :mode         "\\.py'")
(use-package	helm
  :ensure       t)
(use-package	helm-gtags
  :ensure       t
  :after        helm
  :init         (shell-command "mkdir -p ~/.gtags")
                (setenv "GTAGSLIBPATH" "~/.gtags")
  :config       (add-hook 'prog-mode-hook 'helm-gtags-mode))
(use-package	auto-complete
  :ensure       t)
(use-package	expand-region
  :ensure       t)
(use-package	wgrep
  :ensure       t)
(use-package	yasnippet
  :ensure       t
  :config       (yas-global-mode 1))
(use-package	term
  :ensure       t)
(use-package	undo-tree
  :ensure       t
  :config       (global-undo-tree-mode 1))
(use-package	whitespace
  :ensure       t)

;; scrolling
(csetq mouse-autoselect-window t)
(csetq mouse-avoidance-mode nil)
(csetq scroll-margin 2)
(csetq scroll-error-top-bottom t)
(csetq scroll-preserve-screen-position nil)
(put 'scroll-left 'disabled nil)

; looks
(window-divider-mode		t)
(menu-bar-mode              -1)
(toggle-scroll-bar          -1)
(set-language-environment   "UTF-8")
(set-default-coding-systems 'utf-8)
(csetq echo-keystrokes      0.01)
(csetq inhibit-splash-screen t)

;; selecting text
(transient-mark-mode 1)
(delete-selection-mode)
(setq shift-select-mode         nil
      volatile-highlights-mode  t)

;; text formatting
(setq whitespace-style          '(face empty tabs lines-tail trailing)
      tab-width                 4
      tab-always-indent         t
      indent-tabs-mode          nil
      sentence-end-double-space nil
      fill-column		80)
(electric-pair-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; pasting etc from other programs
(setq save-interprogram-paste-before-kill   t
      select-enable-clipboard               t
      x-select-enable-clipboard             t)

(csetq kill-buffer-query-functions
       (delq 'process-kill-buffer-query-function
             kill-buffer-query-functions))

(setq backup-directory-alist    '(("." . "~/.saves"))
 auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
 backup-by-copying              t
 delete-old-versions            t
 kept-new-versions              20
 kept-old-versions              20
 create-lockfiles               nil
 delete-by-moving-to-trash      t
 version-control                t)

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
(auto-compression-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(recentf-mode 1)
(setq recentf-max-saved-items 100)
(csetq gc-cons-threshold 20000000)
(csetq initial-major-mode 'org-mode)

;; make minibuffer slightly different color
(add-hook 'minibuffer-setup-hook
          (lambda () (make-local-variable 'face-remapping-alist)
            (add-to-list
             'face-remapping-alist '(default (:background "#3c4447")))))


(defun set-hook-newline-and-indent ()
  "Rebind RET."
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'prog-mode-hook 'set-hook-newline-and-indent)
(add-hook 'prog-mode-hook 'hs-minor-mode)

;; I dunno if semantic is really worth it, it's kind of shit
(add-to-list 'semantic-default-submodes
             'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(semantic-mode 1)
(global-semantic-idle-scheduler-mode t)

;; Open some defaults
(find-file "~/.emacs.d/bindings2.el")
(find-file "~/.emacs.d/init.el")

;; ugly load because I didn't know about ;;;###autoload TODO
(load "~/.emacs.d/custom-defun.el")
(load "~/.emacs.d/blq-display.el")
(load "~/.emacs.d/multiterm-custom.el")
(load "~/.emacs.d/hydras.el")
(load "~/.emacs.d/org-custom.el")
(load "~/.emacs.d/hydra-nav.el")
(load "~/.emacs.d/semicolon-modifier.el")
(load "~/.emacs.d/annotation-custom.el")
(load "~/.emacs.d/ivy-custom.el")
(load "~/.emacs.d/face-by-mode.el")
(load "~/.emacs.d/defuns.el")
(load "~/.emacs.d/defun-lexical.el")
(load "~/.emacs.d/helm-custom.el")
(load "~/.emacs.d/python-custom.el")
(load "~/.emacs.d/simple-paren.el")
(load "~/.emacs.d/projectile-custom.el")
(load "~/.emacs.d/flycheck-custom.el")
(load "~/.emacs.d/c-custom.el")
(load "~/.emacs.d/gdb-custom.el")
(load "~/.emacs.d/ora-ediff.el")
(load "~/.emacs.d/git-custom.el")
(load "~/.emacs.d/editing-defuns.el")
(load "~/.emacs.d/compile-custom.el")
(load "~/.emacs.d/mode-mappings.el")
(load "~/.emacs.d/bindings2.el")
(load "~/.emacs.d/private.el")

;; hack for a shit mode:        (todo obv)
(eval-after-load 'pdf-view
  '(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)  )



(provide 'init)
;;; init.el ends here

;; <<<<<<< variant A
;; >>>>>>> variant B
;; (require 'fill-column-indicator)
;; (require 'counsel-projectile)
;; (require 'mu4e)
;; (setq mu4e-get-mail-command "offlineimap")
;; (setq mu4e-update-interval 120)
;; (setq mu4e-sent-folder "/SentItems"
;;       mu4e-drafts-folder "/Drafts"
;;       mu4e-trash-folder "/DeletedItems"
;;       mu4e-refile-folder "/Archive"
;;       user-email-addresss "benjamin@lindqvist.xyz"
;;       smtpmail-default-smtp-server "smtp.office365.com"
;;       smtpmail-smtp-service 587
;;       )
;; ======= end
;; ;; Encryption method: STARTTLS
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
