;;; package --- Summary

(setq inhibit-splash-screen t)

;; keep from backuping in current directory
(setq backup-directory-alist `(("." . "~/.saves")))

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
 '(auto-dim-other-buffers-dim-on-focus-out t)
 '(auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
 '(auto-dim-other-buffers-mode t)
 '(browse-url-browser-function (quote browse-url-chrome))
 '(browse-url-chrome-arguments (quote ("--new-window")))
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (tango-dark)))
 '(debug-on-error nil)
 '(default ((t (:height 90 :width normal :family "Inconsolata"))))
 '(echo-keystrokes 0)
 '(elfeed-feeds
   (quote
    ("http://cestlaz.github.io/rss.xml" "http://nullprogram.com/feed/" "http://planet.emacsen.org/atom.xml" "https://www.electronicsweekly.com/news/feed/" "https://www.electronicsweekly.com/rss-feeds/" "http://pragmaticemacs.com/feed/")))
 '(elpy-rpc-backend "rope")
 '(fci-rule-color "#c7c7c7")
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(gdb-many-windows t t)
 '(global-fci-mode nil)
 '(global-linum-mode nil)
 '(helm-autoresize-max-height 22)
 '(helm-autoresize-min-height 22)
 '(helm-autoresize-mode t)
 '(helm-display-buffer-default-width 32)
 '(helm-display-header-line nil)
 '(helm-mode t)
 '(helm-split-window-default-side (quote right))
 '(helm-split-window-in-side-p t)
 '(helm-swoop-split-direction (quote split-window-vertically))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(hl-sexp-background-color "#1c1f26")
 '(hlt-max-region-no-warning 30)
 '(ivy-fixed-height-minibuffer t)
 '(ivy-height 14)
 '(ivy-ignore-buffers (quote ("\\` " "\\*Helm" "\\*Ivy" "TAGS")))
 '(keyboard-coding-system (quote utf-8-unix))
 '(magit-commit-arguments nil)
 '(magit-diff-use-overlays nil)
 '(magit-display-buffer-function (quote magit-display-buffer-fullframe-status-v1))
 '(max-mini-window-height 10)
 '(multi-term-buffer-name "TERM")
 '(multi-term-scroll-to-bottom-on-output t)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files (quote ("~/tmp/1.org")))
 '(package-selected-packages
   (quote
    (counsel-projectile anaconda-mode nlinum auto-compile helm-ag ag helm-projectile avy ace-jump-mode bookmark+ helm-describe-modes helm-descbinds ivy-hydra helm-themes golden-ratio helm-swoop auto-dim-other-buffers popwin crux imenu-anywhere ssh irony counsel hungry-delete undo-tree expand-region volatile-highlights elfeed company-irony-c-headers flycheck-irony projectile use-package pylint magit jedi helm-gtags helm-flymake helm-etags-plus helm-company gtags google-c-style ggtags frame-cmds flycheck-pycheckers fill-column-indicator elpy drupal-mode counsel-gtags company-jedi company-irony)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-display-hud nil)
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-modes
   (quote
    ("erc-mode" "help-mode" "completion-list-mode" "Buffer-menu-mode" "gnus-.*-mode" "occur-mode" "term-mode")))
 '(resize-mini-windows t)
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "-I/home/benjamin/workspace/"))))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(semantic-idle-scheduler-idle-time 10)
 '(semantic-mode t)
 '(shell-file-name "/bin/dash")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
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
     ("C-s" . isearch-forward)
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
 '(vc-annotate-background "#d4d4d4")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#437c7c")
     (40 . "#336c6c")
     (60 . "#205070")
     (80 . "#2f4070")
     (100 . "#1f3060")
     (120 . "#0f2050")
     (140 . "#a080a0")
     (160 . "#806080")
     (180 . "#704d70")
     (200 . "#603a60")
     (220 . "#502750")
     (240 . "#401440")
     (260 . "#6c1f1c")
     (280 . "#935f5c")
     (300 . "#834744")
     (320 . "#732f2c")
     (340 . "#6b400c")
     (360 . "#23733c"))))
 '(vc-annotate-very-old-color "#23733c")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "PfEd" :slant normal :weight normal :height 90 :width normal))))
 '(auto-dim-other-buffers-face ((t (:background "#252525" :foreground "dark gray"))))
 '(button ((t (:foreground "dark red" :underline t :weight normal))))
 '(cursor ((t (:background "dark orange"))))
 '(hl-line ((t (:inherit highlight :background "#6a7c6e" :foreground "gainsboro"))))
 '(linum ((t (:inherit (shadow default) :foreground "khaki"))))
 '(minibuffer-prompt ((t (:foreground "gold" :weight normal))))
 '(mode-line ((t (:background "#d3d7cf" :foreground "#2e3436" :box (:line-width -1 :style released-button)))))
 '(powerline-active1 ((t (:inherit mode-line :background "#333333"))))
 '(term ((t nil)))
 '(term-color-blue ((t (:background "blue2" :foreground "steel blue"))))
 '(term-color-green ((t (:background "green3" :foreground "lime green"))))
 '(term-color-red ((t (:background "red3" :foreground "indian red")))))
(set-cursor-color "#000000")

;; Package managing
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'package-archives '("marmalade" .
                                 "http://marmalade-repo.org/packages/"))

;; fixme: check for nil etc
(defun buffer-name-to-echo-area (&optional ARG PRED)
  (message "[%s] %s"
           (format-time-string "%H:%M:%S")
           (buffer-file-name))
  )

(setq echo-keystrokes 0.05)


(require 'cc-mode)
(require 'counsel)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq tab-always-indent t)
;; (setq tab-always-indent 'complete)  ;; uncommenting because it sucks in minibuffer
(setq scroll-error-top-bottom t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/helm/")

(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; fixme...
(defcustom term-bind-key-alist
  '(
    ("C-S-c" . term-interrupt-subjob)
    ("C-c C-c" . term-interrupt-subjob)
    ("C-p" . previous-line)
    ("C-n" . next-line)
    ("C-s" . isearch-forward)
    ("C-r" . isearch-backward)
    ("C-m" . term-send-raw)
    ("C-S-x" . term-send-raw)
    )
  "The key alist that will need to be bind.
If you do not like default setup, modify it, with (KEY . COMMAND) format."
  :type 'alist
  :group 'multi-term)

(ansi-color-for-comint-mode-on)

(defun simplified-end-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-max)))
(defun simplified-beginning-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-min)))


(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'prog-mode-hook 'set-newline-and-indent)
;; (add-hook 'prog-mode-hook 'nlinum-mode)
;; (add-hook 'prog-mode-hook 'hl-line-mode)
;; (add-hook 'prog-mode-hook 'fci-mode)
;; (add-hook 'org-mode-hook 'fci-mode)


;; (require 'tabbar)
;; (tabbar-mode)
(require 'auto-complete)
(require 'semantic)
(require 'semantic/bovine/gcc)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes
;;              'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(semantic-mode 1)
;(global-ede-mode t)
;(ede-enable-generic-projects)

;; CEDET BINDINGS
(semantic-add-system-include "/home/benjamin/workspace/" 'c-mode)
(global-set-key (kbd "C-x C-g") 'semantic-ia-fast-jump)
(global-set-key (kbd "C-x C-,") 'semantic-complete-jump)

;; flycheck for c/c++

(defun my-flycheck-c-setup ()
  (setq flycheck-clang-language-standard "gnu99"))

(add-hook 'c-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "~/workspace/")))))
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook #'my-flycheck-c-setup)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;; Open .emacs as default
(find-file "~/.emacs")
(find-file "~/.emacs.d/bindings-us.el")
(find-file "~/.org/emacs.org")
(find-file "~/.org/unjo.org")
(find-file "~/.org/tracking/1741.org")

;; TOOGLE COMMENT FOR CURRENT LINE OR REGION
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no "
  "active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(defadvice comment-or-uncomment-region-or-line (after deactivate-mark-nil
                                                      activate)
  (if (called-interactively-p)
      (setq deactivate-mark nil)))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

;; For convenience
(setq default-directory "~/" )

(require 'expand-region)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq mode-line-format nil)))

;; (lambda () (interactive) (term-send-raw-string "\eb")))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(load "~/.emacs.d/annotation-custom.el")
(load "~/.emacs.d/ivy-custom.el")
(load "~/.emacs.d/face-by-mode.el")
(load "~/.emacs.d/luddite-custom.el")
(load "~/.emacs.d/multiterm-custom.el")
(load "~/.emacs.d/irony-custom.el")
(load "~/.emacs.d/helm-custom.el")
(load "~/.emacs.d/simple-paren.el")
(load "~/.emacs.d/helm-swoop-custom.el")
;; (load "~/.emacs.d/ggtags-custom.el")
(load "~/.emacs.d/fci-custom.el")
(load "~/.emacs.d/tmp-crux.el")


;(setq mode-line-format nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; company mode

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

                                        ;(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

;; don't prompt when killing buffers with active processes
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; Function for getting last multi-term buffer if one exists, or create a new one if not.
(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))
(defun get-term ()
  "Switch to the term buffer last used, or create a new one if
    none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

;; More fixes for multi-term
(eval-after-load "term"
  '(progn
     ;; Fix forward/backward word when (term-in-char-mode).
     (define-key term-raw-map (kbd "<C-left>")
       (lambda () (interactive) (term-send-raw-string "\eb")))
     (define-key term-raw-map (kbd "<C-right>")
       (lambda () (interactive) (term-send-raw-string "\ef")))
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


;; set tab width, c mode
(setq-default c-basic-offset 4)

;; hide show mode
(add-hook 'prog-mode-hook #'hs-minor-mode)

(defun back-to-indentation-or-beginning () (interactive)
       (if (= (point) (progn (back-to-indentation) (point)))
           (beginning-of-line)))

;; Transposing lines up/down
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(put 'scroll-left 'disabled nil)
(electric-pair-mode)

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


;; Make emacs not kill entire word if newline or backspace
(defun backward-kill-char-or-word ()
  (interactive)
  (cond
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))

(defun kill-line-save (&optional arg)
  "Copy to the kill ring from point to the end of the current line.
    With a prefix argument, copy that many lines from point. Negative
    arguments copy lines backward. With zero argument, copies the
    text before point to the beginning of the current line."
  (interactive "p")
  (save-excursion
    (copy-region-as-kill
     (point)
     (progn (if arg (forward-visible-line arg)
              (end-of-visible-line))
            (point)))))

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; Set backup options, for example save backups in ~/.saves/
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c-mode-common-hook 'irony-mode)
(add-hook 'c-mode-common-hook 'company-mode)

;; Check buffer on save, new line and immediately after anbling flycheck-mode
(setq flycheck-check-syntax-automatically '(mode-enabled save)) ;; new-line also possible
;; (setq flycheck-check-syntax-automatically '(mode-enabled new-line)) ;; new-line also possible


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; company-mode
(require 'company)
;; Use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)


(load "~/.emacs.d/bindings-us.el")

;; Unbind stupid cc-mode binding
(eval-after-load "cc-mode"
  '(define-key c-mode-map (kbd "M-e") nil))

;; Auto-revert buffers when changed on disk
;; (global-auto-revert-mode 1)

;; Delete selection on input
(delete-selection-mode t)

;; volatile highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; scroll margin
(setq scroll-margin 1)

;; kill current line if no region active
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; cursor stuff when scrolling
(setq scroll-preserve-screen-position 1)

;; undo-tree
(global-undo-tree-mode 1)

(package-initialize)
(setq elpy-rpc-backend "jedi")
(elpy-enable)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; ;; not a huge fan, commenting out
;; (require 'hungry-delete)
;; (global-hungry-delete-mode)

;; annoying fix for flymake error messages
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'python-mode-hook
          '(lambda() (flymake-mode)))
(add-hook 'post-command-hook 'my-flymake-show-help)
;; (auto-dim-other-buffers-mode nil)
;(auto-compile-mode nil)

(projectile-global-mode t)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (make-local-variable 'face-remapping-alist)
            (add-to-list 'face-remapping-alist
                         '(default (:background "#454740")))))

(auto-dim-other-buffers-mode 1)

(provide '.emacs)
;;; .emacs ends here
