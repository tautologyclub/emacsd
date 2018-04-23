(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu"        . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa-stable" . "https://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade"    . "https://marmalade-repo.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/repos/counsel-term/")
(add-to-list 'load-path "~/repos/feebleline")
(add-to-list 'load-path "~/.emacs.d/ample-light-theme")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(package-initialize)
(if (not (fboundp 'use-package))
    (progn (package-refresh-contents) (package-install 'use-package)))
;; -- end of formalities -------------------------------------------------------


(defmacro csetq (variable value)
  "Macro stolen from abo-abo, custom set VARIABLE to VALUE etc."
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))

(defmacro lambi (&rest b)
  "B lazy yo."
  `(lambda () (interactive),@b))

(csetq custom-file "~/.emacs.d/customizations.el")
(load-file custom-file)

(use-package    kill-at-point)
(use-package    counsel-term
  :custom       (counsel-term-ff-initial-input          "")
                (counsel-term-history-initial-input     "")
  :load-path    "~/repos/counsel-term")

(use-package    term-addons
  :after        (multi-term)
  :config       (add-hook 'sh-mode-hook 'benjamin/sh-hook))

(use-package    some-defuns)
(use-package    some-hydras)
(use-package    zoom-frm)
(use-package    pdf-custom)

(use-package    gdscript-mode
  :ensure       nil
  :load-path    "~/repos/gdscript-mode")

(use-package    ample-light-theme               ;; forked
  :ensure       nil
  :config       (ample-light-theme)
  :load-path    "~/.emacs.d/ample-theme")

(use-package    undo-tree
  :config       (global-undo-tree-mode 1)
  :bind         (:map undo-tree-map
                      ("C-x r" . nil)
                      ("C-_"   . nil)))

(use-package    multi-term
  :bind
  (:map
    term-raw-map
     ("C-g" . (lambda () (interactive) (term-send-raw-string "")))
     ("H-w" . counsel-term-ff)
     ("H-c" . counsel-term-cd)
     ("M-r" . counsel-term-history)
     ("H-f" . avy-goto-word-or-subword-1)
     ("H-k" . (lambda () (interactive) (term-send-raw-string "")))
     ("C-d" . term-send-raw)
     ("C-p" . projectile-command-map)
     ("C-l" . forward-char)
     ("C-h" . backward-char)
     ("C-n" . term-downdir)
     ("C-S-n" . term-updir)
     ("C-s" . swiper)
     ("C-r" . term-send-backspace)
     ("<f9>". term-send-backspace) ; == [
     ("C-m" . term-send-return)
     ("C-y" . term-paste)
     ("H-i" . term-paste)
     ("C-q" . backward-word)
     ("M-q" . term-send-backward-word)
     ("M-f" . term-send-forward-word)
     ("M-p" . term-send-up)
     ("M-n" . term-send-down)
     ("M-d" . term-send-delete-word)
     ("M-," . term-send-raw)
     ("H-M-f" . (lambda ()
                  (interactive)
                  (term-send-raw-string " fuck")
                  (sleep-for 0.2)(term-send-raw-string "")))
     ;; ("C-x t" . term-toggle-mode-w/warning)
     ("C-c C-c" . term-interrupt-subjob)
     ("C-c C-e" . term-send-esc)
     ("C-c C-z" . (lambda () (interactive) (term-send-raw-string "")))
     ("C-c C-x" . (lambda () (interactive) (term-send-raw-string "")))
     ("C-c C-u" . (lambda () (interactive) (term-send-raw-string "sudo ")))
     ("C-c C-l" . (lambda () (interactive) (term-send-raw-string "")))
     ("<C-backspace>" . term-send-backward-kill-word)
     ("<C-return>" . term-cd-input)
     )
  (:map
   term-mode-map
     ("C-p"   . nil)
     ("C-x t" . term-toggle-mode-w/warning))
  :ensure       t
  :custom       (multi-term-program     "/bin/bash")
                (term-prompt-regexp     "^$\\ ")
                (multi-term-switch-after-close nil)
                (term-buffer-maximum-size 16384))

(use-package    hideshow
  :config       (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package    fill-column-indicator
  :ensure       nil
  :custom       (fci-rule-display 80)
                (fci-rule-width 1)
                (fci-rule-color "#545454")
  :config       (add-hook 'org-mode-hook 'fci-mode))

(use-package    projectile
  :ensure       t
  :custom       (projectile-completion-system   'ivy)
                (projectile-enable-caching t)
                (projectile-globally-ignored-modes
                 (quote
                  ("erc-mode" "help-mode" "completion-list-mode"
                   "Buffer-menu-mode" "gnus-.*-mode" "occur-mode")))
                (projectile-mode-line "")
  :config       (projectile-mode 1))

(use-package    helm
  :ensure       t
  :custom       (helm-mode-line-string ""))

(use-package    feebleline
  :load-path    "~/repos/feebleline"
  :ensure       nil
  :custom       (feebleline-show-git-branch             t)
                (feebleline-show-dir                    t)
                (feebleline-show-time                   nil)
                (feebleline-show-previous-buffer        nil)
  :config       (feebleline-mode 1))

(use-package    ivy
  :ensure       t
  :custom       (ivy-use-virtual-buffers        t)
                (ivy-wrap                       t)
                (ivy-use-selectable-prompt      t)
                (ivy-fixed-height-minibuffer    t)
                (ivy-height                     24)
                (ivy-extra-directories          nil)
                (ivy-count-format               "%d/%d - ")
                (ivy-display-style              'fancy)
                (ivy-ignore-buffers '("\\` "))
                (add-to-list 'ivy-ignore-buffers "\\*Flycheck")
                (add-to-list 'ivy-ignore-buffers "\\*CEDET")
                (add-to-list 'ivy-ignore-buffers "\\*BACK")
                (add-to-list 'ivy-ignore-buffers "\\*Help\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Messages\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Compile-Log\\*")
                (add-to-list 'ivy-ignore-buffers "\\*helm")
  :config       (ivy-mode 1)
  )

(use-package    avy
  :ensure       t
  :custom       (avy-case-fold-search nil)
                (avy-keys '(?a ?s ?d ?f ?g ?j ?k ?l ?w ?e ?r ?i ?o ?p ?m)))

(use-package    magit
  :ensure       t
  :after        (ivy)
  :custom       (magit-completing-read-function 'ivy-completing-read))

(use-package    counsel
  :ensure       t
  :custom       (counsel-grep-swiper-limit      120000)
                (counsel-rg-base-command
                 (concat "rg -i --no-heading --line-number --max-columns 120 "
                         "--max-count 200 --max-filesize 100M "
                         "--color never %s .")))

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
                (company-tooltip-idle-delay 0.2)
                (company-show-numbers t)
                (company-tooltip-limit 10)
  :config       (counsel-mode 1)
                (add-hook 'after-init-hook 'global-company-mode))

(use-package    autorevert
  :custom       (auto-revert-verbose nil)
                (global-auto-revert-non-file-buffers t)
  :config       (global-auto-revert-mode))

(use-package    auto-dim-other-buffers
  :ensure       t
  :config       (auto-dim-other-buffers-mode 1))

(use-package    volatile-highlights
  :ensure       t
  :config       (volatile-highlights-mode 1))

(use-package    wgrep
  :ensure       t
  :config       (add-hook 'wgrep-setup-hook 'save-some-buffers))

(use-package    recentf
  :custom       (recentf-max-saved-items 100)
  :config       (recentf-mode 1))

(use-package    whitespace
  :custom       (whitespace-style '(face empty tabs lines-tail trailing)))

(use-package    hl-line
  :ensure       nil
  :custom       (hl-line-mode -1))

(use-package    helm-gtags
  :ensure       t
  :custom       (helm-gtags-auto-update         t)
                (helm-gtags-use-input-at-cursor t)
  :config       (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  :hook         (prog-mode-hook . helm-gtags-mode))

(use-package    flycheck
  :custom       (flycheck-check-syntax-automatically '(mode-enabled idle-change save))
                (flycheck-idle-change-delay 0.5)
                (flycheck-display-errors-delay 0.2)
                (flycheck-pos-tip-timeout 20)
  :config       (add-hook 'after-init-hook 'global-flycheck-mode))

(use-package    dts-mode
  :ensure       nil
  :config       (add-to-list 'auto-mode-alist '("\\.dts$" . dts-mode)))

(use-package    linum
  :ensure       nil
  :custom       (global-linum-mode nil))

(use-package    org
  :custom       (org-hide-leading-stars t)
  :config       (define-key org-mode-map (kbd "C-o")
                  (lambi (beginning-of-line) (newline)
                         (forward-line -1)))
  :bind         (:map org-mode-map
                      ("C-a" . nil)
                      ("C-e" . nil)
                      ("M-a" . nil)
                      ("M-e" . nil)
                      ("C-j" . next-line)
                      ("C-k" . previous-line)))

(use-package    vimish-fold             :ensure t)
(use-package    counsel-projectile      :ensure t)
(use-package    expand-region           :ensure t)
(use-package    switch-buffer-functions :ensure t)
(use-package    multiple-cursors        :ensure t)
(use-package    hungry-delete           :ensure t)
(use-package    iedit                   :ensure t)
(use-package    move-text               :ensure t)
(use-package    yasnippet               :ensure t)
(use-package    function-args           :ensure nil)


;;-- Random general stuff ----------------------------------------------------;;
(setq enable-recursive-minibuffers nil)
(setq mouse-autoselect-window t)
(setq shift-select-mode nil)

(setq scroll-margin 2)
(setq scroll-preserve-screen-position nil)
(setq scroll-error-top-bottom t)
(put 'scroll-left 'disabled nil)

(setq tab-width 4)
(setq tab-always-indent t)

(setq save-interprogram-paste-before-kill t)
(setq select-enable-clipboard t)
(setq kill-buffer-query-functions
      (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(setq-default indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq initial-major-mode 'org-mode)                             ;; for *Scratch*

(setq echo-keystrokes 0.1)

(setq backup-by-copying         t
      backup-directory-alist    '(("." . "~/.saves"))
      delete-old-versions       t
      kept-new-versions         10
      kept-old-versions         5
      delete-by-moving-to-trash t
      version-control           t)
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(setq gc-cons-threshold 20000000)
(set-default 'sentence-end-double-space nil)
(set-default 'fill-column 80)

(fset 'yes-or-no-p 'y-or-n-p)
(setenv "GTAGSLIBPATH" "~/.gtags")

(auto-compression-mode t)
(ansi-color-for-comint-mode-on)

(window-divider-mode t)
(csetq window-divider-default-bottom-width 1)
(csetq window-divider-default-places (quote bottom-only))

(yas-global-mode 1)
(delete-selection-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

(electric-pair-mode)

(add-hook 'before-save-hook     'delete-trailing-whitespace)
(add-hook 'find-file-hook       'find-file-root-header-warning)
(add-hook 'org-mode-hook        'turn-on-auto-fill)
(add-hook 'occur-hook           'occur-rename-buffer)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-to-list 'auto-mode-alist '("defconfig$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.conf$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.scr$" . sh-mode))

(defun set-hook-newline-and-indent ()
  "Rebind RET."
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'prog-mode-hook 'set-hook-newline-and-indent)

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

;; some temporary hacks
(load "~/.emacs.d/ivy-custom.el")
(load "~/.emacs.d/face-by-mode.el")
(load "~/.emacs.d/helm-custom.el")
(load "~/.emacs.d/python-custom.el")
(load "~/.emacs.d/projectile-custom.el")
(load "~/.emacs.d/flycheck-custom.el")
(load "~/.emacs.d/c-custom.el")
(load "~/.emacs.d/gdb-custom.el")
(load "~/.emacs.d/ora-ediff.el")
(load "~/.emacs.d/git-custom.el")
(load "~/.emacs.d/indicate-cursor.el")

;; This ensures bindings gets loaded last
(add-hook 'after-init-hook (lambi (load "~/.emacs.d/bindings2.el")))

(condition-case nil (kill-buffer "*scratch*") (error nil))

(provide 'init)
;;; init.el ends here
