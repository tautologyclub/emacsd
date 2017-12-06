
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" .
                                 "http://marmalade-repo.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/helm/")
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "dark orange" "#cc79a7" "#56b4e9" "white"])
 '(async-bytecomp-allowed-packages nil)
 '(auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
 '(avy-keys
   (quote
    (97 115 101 100 102 103 114 116 111 112 106 107 108 105 113 119 110 109)))
 '(browse-url-browser-function (quote browse-url-chrome))
 '(browse-url-chrome-arguments (quote ("--new-window")))
 '(column-number-mode nil)
 '(company-auto-complete-chars nil)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 9)
 '(company-tooltip-idle-delay 0.5)
 '(company-tooltip-limit 20)
 '(compilation-message-face (quote default))
 '(counsel-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(debug-on-error nil)
 '(delete-by-moving-to-trash t)
 '(echo-keystrokes 0.01)
 '(eldoc-idle-delay 1.5)
 '(electric-pair-pairs (quote ((34 . 34) (123 . 125))))
 '(elpy-rpc-backend "rope")
 '(fci-rule-color "#c7c7c7")
 '(fill-column 79)
 '(flycheck-check-syntax-automatically (quote (save new-line mode-enabled)))
 '(flycheck-clang-includes
   (quote
    ("/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs/hardware_stub.h")))
 '(flycheck-display-errors-delay 1.5)
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(global-fci-mode nil)
 '(global-flycheck-mode t)
 '(global-linum-mode nil)
 '(global-semantic-stickyfunc-mode t)
 '(helm-autoresize-max-height 24)
 '(helm-autoresize-min-height 24)
 '(helm-autoresize-mode t)
 '(helm-descbinds-mode t)
 '(helm-display-buffer-default-width 32)
 '(helm-display-header-line nil)
 '(helm-mode t)
 '(helm-swoop-split-direction (quote split-window-vertically))
 '(irony-additional-clang-options
   (quote
    ("-I/home/benjamin/workspace/reac/inc" "-std=c90" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__" "-D __USE_GNU")))
 '(ivy-fixed-height-minibuffer t)
 '(ivy-height 24)
 '(ivy-ignore-buffers (quote ("\\` " "\\*Helm" "\\*Ivy" "TAGS")))
 '(ivy-mode t)
 '(keyboard-coding-system (quote utf-8-unix))
 '(line-number-mode nil)
 '(magit-commit-arguments nil)
 '(magit-diff-use-overlays nil)
 '(magit-display-buffer-function (quote magit-display-buffer-fullframe-status-v1))
 '(max-mini-window-height 10)
 '(mode-line-default-help-echo nil)
 '(mode-line-in-non-selected-windows nil)
 '(mouse-avoidance-mode (quote banish) nil (avoid))
 '(multi-term-buffer-name "TERM")
 '(multi-term-scroll-to-bottom-on-output t)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files nil)
 '(org-log-done (quote time))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(org-trello-files (quote ("~/.org/mf/trello.org")) nil (org-trello))
 '(package-selected-packages
   (quote
    (slack org-trello vimish-fold helm-make function-args evil multiple-cursors git-gutter-fringe+ helm-google helm-flycheck framemove company-c-headers flycheck-rtags rtags ace-jump-buffer fastnav pdf-tools dired+ rg smex which-key lispy wgrep smart-hungry-delete counsel-projectile anaconda-mode nlinum auto-compile helm-ag ag helm-projectile avy ace-jump-mode helm-describe-modes helm-descbinds ivy-hydra helm-themes golden-ratio helm-swoop auto-dim-other-buffers popwin crux imenu-anywhere ssh irony counsel hungry-delete undo-tree expand-region volatile-highlights elfeed company-irony-c-headers flycheck-irony projectile use-package pylint magit jedi helm-gtags helm-flymake helm-etags-plus helm-company gtags google-c-style ggtags frame-cmds flycheck-pycheckers fill-column-indicator elpy drupal-mode counsel-gtags company-jedi company-irony)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-display-hud nil)
 '(projectile-enable-caching nil)
 '(projectile-globally-ignored-modes
   (quote
    ("erc-mode" "help-mode" "completion-list-mode" "Buffer-menu-mode" "gnus-.*-mode" "occur-mode" "term-mode")))
 '(projectile-mode-line "PROJECTILE")
 '(python-indent-guess-indent-offset t)
 '(python-indent-guess-indent-offset-verbose nil)
 '(resize-mini-windows t)
 '(safe-local-variable-values
   (quote
    ((irony-additional-clang-options "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/CUnit" "-Wall -Wextra" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-include /home/benjamin/workspace/reac_git/code/lccp/source/test/stubs/hardware_stub.h" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/CUnit" "-Wall -Wextra" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/CUnit" "-Wall -Wextra" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-Wall -Wextra" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__" "-include /home/benjamin/workspace/reac_git/code/lccp/source/test/stubs/ior5f100mj.h")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__" "-include /home/benjamin/workspace/reac_git/code/lccp/source/test/stubs/hardware_stub.h")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__" "-D P14_bit __BITS8" "-D P11_bit __BITS8")
     (irony-additional-clang-options "-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")
     (irony-additional-clang-options quote
                                     ("-I/home/benjamin/workspace/reac/inc" "-I/home/benjamin/workspace/reac_git/code/lccp/source" "-I/home/benjamin/workspace/reac_git/code/lccp/source/test/stubs" "-D __saddr=" "-D __ro_placement=" "-D __far=" "-D __no_init=" "-D __no_bit_access=" "-D __IAR_SYSTEMS_ICC__" "-D __ARL78__" "-D __CORE__=__RL78_1__")))))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(semantic-idle-scheduler-idle-time 5)
 '(semantic-mode t)
 '(shell-file-name "/bin/bash")
 '(tab-width 4)
 '(term-bind-key-alist
   (quote
    (("C-c C-c" . term-interrupt-subjob)
     ("C-c C-e" . term-send-esc)
     ("C-S-x" . term-send-raw)
     ("C-d" . term-send-backspace)
     ("C-f" . term-send-del)
     ("C-p" . previous-line)
     ("C-n" . next-line)
     ("C-s" . swiper)
     ("C-x t" . jnm/term-toggle-mode)
     ("C-r" . isearch-backward)
     ("C-m" . term-send-return)
     ("C-y" . term-paste)
     ("M-f" . term-send-forward-word)
     ("M-b" . term-send-backward-word)
     ("<C-backspace>" . term-send-backward-kill-word)
     ("M-r" . term-send-reverse-search-history)
     ("M-d" . term-send-delete-word)
     ("M-," . term-send-raw)
     ("M-." . comint-dynamic-complete))))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(term-unbind-key-list (quote ("C-x" "C-z" "C-c" "C-h" "C-y" "<ESC>" "M-o")))
 '(tool-bar-mode nil)
 '(tramp-verbose 6)
 '(transient-mark-mode t)
 '(truncate-partial-width-windows 80)
 '(wgrep-auto-save-buffer t)
 '(windmove-wrap-around nil)
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "PfEd" :family "Inconsolata"))))
 '(auto-dim-other-buffers-face ((t (:background "#242b2d" :foreground "#c4c4c4"))))
 '(avy-lead-face ((t (:background "light salmon" :foreground "black" :weight normal))))
 '(avy-lead-face-0 ((t (:inherit avy-lead-face :background "light coral" :foreground "black"))))
 '(avy-lead-face-1 ((t (:inherit avy-lead-face :background "tomato" :foreground "black"))))
 '(button ((t (:foreground "dark red" :underline t :weight normal))))
 '(git-gutter+-added ((t (:foreground "#00a000" :weight bold))))
 '(highlight-indentation-face ((t nil)))
 '(hl-line ((t (:background "#303a3d"))))
 '(linum ((t (:inherit (shadow default) :background "light gray" :foreground "red"))))
 '(minibuffer-prompt ((t (:foreground "dark orange" :weight normal))))
 '(mode-line ((t (:background "#d3d7cf" :foreground "#2e3436" :height 0.1))))
 '(semantic-highlight-func-current-tag-face ((t (:background "Gray90"))))
 '(term ((t nil)))
 '(term-color-blue ((t (:background "blue2" :foreground "steel blue"))))
 '(term-color-green ((t (:background "green3" :foreground "lime green"))))
 '(term-color-red ((t (:background "red3" :foreground "indian red")))))


(defmacro csetq (variable value)
  "Abo-abo weird macro.  Look at VARIABLE and VALUE, wow."
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))

(require 'cc-mode)
(require 'counsel)
(require 'helm)
(require 'auto-complete)
(require 'semantic)
(require 'semantic/bovine/gcc)
(require 'expand-region)
(require 'whitespace)
(require 'company)
(require 'volatile-highlights)
(require 'wgrep)
(require 'function-args)
(require 'yasnippet)
;; (fa-config-default) ;; stop stealing my bindings ;; todo obv

(require 'org-trello)
(setq org-trello-current-prefix-keybinding (kbd "C-c o"))


(setq scroll-margin 2)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq tab-width 4)
(setq tab-always-indent t)
(setq scroll-error-top-bottom t)
(setq save-interprogram-paste-before-kill t)
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(setq-default indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq scroll-preserve-screen-position nil)
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups
(setq select-enable-clipboard t)
(fset 'yes-or-no-p 'y-or-n-p)

(yas-global-mode 1)
(global-undo-tree-mode 1)
(delete-selection-mode t)
(volatile-highlights-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(global-auto-revert-mode)
(put 'scroll-left 'disabled nil)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(electric-pair-mode)
(projectile-global-mode t)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (make-local-variable 'face-remapping-alist)
            (add-to-list 'face-remapping-alist
                         '(default (:background "#3c4447")))))
(auto-dim-other-buffers-mode 1)
(counsel-projectile-on)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(defun set-hook-newline-and-indent ()
  "Rebind RET."
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'prog-mode-hook 'set-hook-newline-and-indent)


(add-to-list 'semantic-default-submodes
             'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(semantic-mode 1)
(global-semantic-idle-scheduler-mode t)
;(global-ede-mode t)
;(ede-enable-generic-projects)

(defface find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")
(defun find-file-root-header-warning ()
  "*Display a warning in header line of the current buffer.
This function is suitable to add to `find-file-hook'."
  (when (string-equal
         (file-remote-p (or buffer-file-name default-directory) 'user)
         "root")
    (let* ((warning "WARNING: EDITING FILE AS ROOT!")
           (space (+ 6 (- (window-width) (length warning))))
           (bracket (make-string (/ space 2) ?-))
           (warning (concat bracket warning bracket)))
      (setq header-line-format
            (propertize  warning 'face 'find-file-root-header-face)))))

(add-hook 'find-file-hook 'find-file-root-header-warning)
(add-hook 'dired-mode-hook 'find-file-root-header-warning)


;; annoying fix for flymake error messages
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)



;; Open some defaults
(find-file "~/.emacs.d/bindings2.el")
(find-file "~/.org/emacs.org")
(find-file "~/.emacs.d/init.el")

;; ugly load
(load "~/.emacs.d/custom-defun.el")
(load "~/.emacs.d/multiterm-custom.el")
(load "~/.emacs.d/hydras.el")
(load "~/.emacs.d/hydra-nav.el")
(load "~/.emacs.d/semicolon-modifier.el")
(load "~/.emacs.d/annotation-custom.el")
(load "~/.emacs.d/ivy-custom.el")
(load "~/.emacs.d/face-by-mode.el")
(load "~/.emacs.d/defuns.el")
(load "~/.emacs.d/helm-custom.el")
(load "~/.emacs.d/python-custom.el")
(load "~/.emacs.d/simple-paren.el")
(load "~/.emacs.d/ggtags-custom.el")
(load "~/.emacs.d/fci-custom.el")
;; (load "~/.emacs.d/helm-swoop-custom.el")
(load "~/.emacs.d/projectile-custom.el")
(load "~/.emacs.d/flycheck-custom.el")
(load "~/.emacs.d/c-custom.el")
(load "~/.emacs.d/ora-ediff.el")
(load "~/.emacs.d/hydra-jumper.el")
(load "~/.emacs.d/git-custom.el")
;; (load "~/.emacs.d/irony-custom.el")
(load "~/.emacs.d/editing-defuns.el")
(load "~/.emacs.d/compile-custom.el")
(load "~/.emacs.d/bindings2.el")
(setq org-agenda-files (list "~/.org/medfield.org"
                             "~/.org/work.org"
                             "~/.org/reac.org"
                             "~/.org/unjo.org"
                             "~/.org/home.org"))

(make-variable-buffer-local 'compile-command) ;; todo


(defun message-buffer-file-name-or-nothing ()
  "Mode line proxy."
  (if buffer-file-name
      (message "[%s] (%s:%s) %s"
           (format-time-string "%H:%M:%S")
           (string-to-number (format-mode-line "%l"))
           (current-column)
           (buffer-file-name)
           )
    (message "[%s]" (format-time-string "%H:%M:%S")))
  )

;; Get the modeline proxy to work with i3 switch focus
(defadvice handle-switch-frame (around switch-frame-message-name)
  (message-buffer-file-name-or-nothing)
  ad-do-it
  (message-buffer-file-name-or-nothing))
(ad-activate 'handle-switch-frame)
(add-hook 'focus-in-hook 'message-buffer-file-name-or-nothing)


(condition-case nil
    (kill-buffer "*scratch*")
  (error nil))

(provide '.emacs)
;;; .emacs ends here
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
