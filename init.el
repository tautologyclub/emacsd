;;; init.el --- Summary:
;;; Commentary:
;;; Code:

;;; todo: https://github.com/abo-abo/hydra/wiki/Macro

(require 'package)
(add-to-list 'package-archives '("melpa"        . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://melpa-stable.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("marmalade"    . "https://marmalade-repo.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/repos/counsel-term/")
(add-to-list 'load-path "~/repos/feebleline")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(load-file "~/.emacs.d/ample-theme/ample-light-theme.el")
(package-initialize)
(if (not (fboundp 'use-package))
    (progn (package-refresh-contents) (package-install 'use-package)))
(setq custom-file (make-temp-file "/tmp/custom.el"))


(defmacro lambi (&rest b)
  "Just a lazy macro, have to mention B in docstring."
  `(lambda () (interactive),@b))


; -- my own stuff (mostly) -----------------------------------------------------
(use-package    kill-at-point)
(use-package    kernel-dev-mode)
(use-package    ivy-addons)
(use-package    helm-addons)
(use-package    some-defuns)
(use-package    some-hydras)
(use-package    pdf-custom)
(use-package    zoom-frm)
(use-package    company-flyspell) ;; raw download

(use-package    term-addons
  :config       (add-hook 'sh-mode-hook 'benjamin/sh-hook))

(use-package    counsel-term
  :custom       (counsel-term-ff-initial-input      "")
                (counsel-term-history-initial-input "")
  :load-path    "~/repos/counsel-term")

(use-package    ample-light-theme  ;; forked
  :config       (ample-light-theme)
  :load-path    "~/.emacs.d/ample-theme")

(use-package    feebleline
  :load-path    "~/repos/feebleline"
  :custom       (feebleline-show-git-branch      nil) ;; FIXME: revise implementation to cache branch, messes up sshfs/tramp right now
                (feebleline-show-dir             t)
                (feebleline-show-time            nil)
                (feebleline-show-previous-buffer nil)
  :config       (feebleline-mode 1))

(use-package    timeclock-x ;; raw download from wiki
  :after        (projectile)
  :custom       (timeclock-get-reason-function nil)
                (timeclock-get-project-function 'projectile-project-name)
  :config       (defun timeclock-query-comment () "")
                (add-hook
                 'projectile-after-switch-project-hook
                 (lambda ()
                   (condition-case nil (timeclock-out) (error nil))
                   (call-interactively 'timeclock-in))))


; -- others stuff --------------------------------------------------------------
(use-package    undo-tree
  :ensure       t
  :config       (global-undo-tree-mode 1)
  :bind         (:map undo-tree-map ("C-x r" . nil)
                                    ("C-_"   . nil)))

(use-package    multi-term
  :ensure       t
  :bind         (:map term-mode-map
                      ("C-p"   . nil)
                      ("M-o"   . nil)
                      ("C-t t" . term-toggle-mode))
  :custom       (multi-term-program     "/bin/bash")
                (term-prompt-regexp     "^$\\ ")
                (term-buffer-maximum-size 16384)
                (multi-term-switch-after-close nil)
                (term-char-mode-buffer-read-only nil)
                (term-char-mode-point-at-process-mark nil)
  :config       (setq term-bind-key-alist nil)
                (setq term-bind-key-alist
                      '(("C-g" . (lambda () (interactive) (term-send-raw-string "")))
                        ("C-d" . term-send-raw)
                        ("C-_" . nil)
                        ("C-r" . counsel-term-history)
                        ("C-p" . projectile-command-map)
                        ("C-j" . next-line)
                        ("C-k" . previous-line)
                        ("C-l" . forward-char)
                        ("C-h" . backward-char)
                        ("C-b" . nil)
                        ("H-n" . term-downdir)
                        ("H-p" . term-updir)
                        ("C-n" . mark-line)
                        ("C-s" . swiper)
                        ("C-t" . nil)
                        ("C-p" . nil)
                        ("C-m" . term-send-return)
                        ("H-w" . counsel-term-ff)
                        ("C-y" . term-paste)
                        ("H-i" . term-paste)
                        ("H-f" . avy-goto-word-or-subword-1)
                        ("H-k" . (lambda () (interactive) (term-send-raw-string "")))
                        ("H-l" . (lambda () (interactive) (term-send-raw-string "")))
                        ;; electric pairs in term
                        ("["   . (lambda () (interactive) (term-send-raw-string "[]")))
                        ("("   . (lambda () (interactive) (term-send-raw-string "()")))
                        ("{"   . (lambda () (interactive) (term-send-raw-string "{}")))
                        ("H-c" . counsel-term-cd)
                        ("M-r" . term-send-backward-kill-word)
                        ("M-q" . term-send-backward-word)
                        ("M-f" . term-send-forward-word)
                        ("M-o" . other-window)
                        ("M-p" . term-send-up)
                        ("M-n" . term-send-down)
                        ("M-d" . term-send-delete-word)
                        ("M-," . term-send-raw)
                        ("C-S-a" . beginning-of-line)
                        ("C-S-e" . end-of-line)
                        ("C-S-l" . (lambda () (interactive) (term-send-raw-string "")))
                        ("<f9>". term-send-backspace) ; == [
                        ("TAB" . term-send-raw)
                        ("H-M-f" . find-file-at-point)
                        ("H-M-u"   . (lambda () (interactive)
                                       (term-send-raw-string "sudo ")))
                        ("C-t t" . term-toggle-mode)
                        ("C-c C-c" . term-interrupt-subjob)
                        ("C-c C-e" . term-send-esc)
                        ("C-c C-z" . (lambda () (interactive) (term-send-raw-string "")))
                        ("C-c C-x" . (lambda () (interactive) (term-send-raw-string "")))
                        ("C-c C-l" . (lambda () (interactive) (term-send-raw-string "")))
                        ("<C-backspace>" . term-send-backward-kill-word)
                        ("<C-return>"    . term-cd-input))))

(use-package    fill-column-indicator
  :ensure       t
  :custom       (fci-rule-display 80)
                (fci-rule-width 1)
                (fci-rule-color "#545454")
  :config       (add-hook 'org-mode-hook 'fci-mode))

(use-package    smex
  :ensure       t)

;; todo
(use-package    projectile
  :ensure       t
  :custom       (projectile-completion-system   'ivy)
                (projectile-enable-caching       nil)
                (projectile-globally-ignored-modes
                 '("erc-mode" "help-mode" "completion-list-mode"
                   "Buffer-menu-mode" "gnus-.*-mode" "occur-mode"))
                (projectile-mode-line "")
  :config       (add-to-list 'projectile-project-root-files ".repo")
                (add-to-list 'projectile-project-root-files ".dir-locals.el")
                (defun projectile-get-term ()
                  "Get multi-term in project root."
                  (interactive)
                  (let ((projectile--proj-term-name
                         (concat "term:" (projectile-project-name))))
                    (if (not (eq nil (get-buffer projectile--proj-term-name)))
                        (switch-to-buffer projectile--proj-term-name)
                      (projectile-with-default-dir (projectile-project-root)
                        (multi-term)
                        (rename-buffer projectile--proj-term-name)))))
                (projectile-mode 1)
  :bind (:map projectile-command-map
              ("t"   . projectile-get-term)
              ("T"   . projectile-test-project)
              ("u"   . projectile-run-project)
              ("r"   . counsel-projectile-rg)
              ("o"   . projectile-find-other-file)
              ("e"   . projectile-recentf)
              ("j"   . projectile-find-tag)
              ("O"   . projectile-find-other-file-other-window)
              ("p"   . counsel-projectile)
              ("C-p" . counsel-projectile)
              ("s"   . counsel-projectile-switch-project)
              ("d"   . counsel-projectile-find-dir)
              ("g"   . counsel-projectile-git-grep)
              ("q"   . projectile-replace)
              ("c"   . projectile-compile-project)
              ("C-f" . projectile-find-file-in-known-projects)
              ("A"   . projectile-run-async-shell-command-in-root)))

(use-package    counsel-projectile
  :ensure       t
  :config
  ;; this is super hacky, todo
  (defun counsel-projectile-switch-project-action-run-term (project)
    "Overridden!"
    (let ((projectile-switch-project-action
           (lambda () (projectile-get-term))))
      (counsel-projectile-switch-project-by-name project)))
  :custom
    (counsel-projectile-switch-project-action
     (quote
      (18
       ("o" counsel-projectile-switch-project-action "jump to a project buffer or file")
       ("f" counsel-projectile-switch-project-action-find-file "jump to a project file")
       ("d" counsel-projectile-switch-project-action-find-dir "jump to a project directory")
       ("b" counsel-projectile-switch-project-action-switch-to-buffer "jump to a project buffer")
       ("m" counsel-projectile-switch-project-action-find-file-manually "find file manually from project root")
       ("S" counsel-projectile-switch-project-action-save-all-buffers "save all project buffers")
       ("k" counsel-projectile-switch-project-action-kill-buffers "kill all project buffers")
       ("K" counsel-projectile-switch-project-action-remove-known-project "remove project from known projects")
       ("c" counsel-projectile-switch-project-action-compile "run project compilation command")
       ("C" counsel-projectile-switch-project-action-configure "run project configure command")
       ("E" counsel-projectile-switch-project-action-edit-dir-locals "edit project dir-locals")
       ("v" counsel-projectile-switch-project-action-vc "open project in vc-dir / magit / monky")
       ("sg" counsel-projectile-switch-project-action-grep "search project with grep")
       ("ss" counsel-projectile-switch-project-action-ag "search project with ag")
       ("sr" counsel-projectile-switch-project-action-rg "search project with rg")
       ("xs" counsel-projectile-switch-project-action-run-shell "invoke shell from project root")
       ("xe" counsel-projectile-switch-project-action-run-eshell "invoke eshell from project root")
       ("xt" counsel-projectile-switch-project-action-run-term "invoke term from project root")
       ("O" counsel-projectile-switch-project-action-org-capture "org-capture into project")))))

;; todo
(use-package    helm
  :ensure       t
  :config       (put 'benjamin/helm-kill-buffer    'helm-only t)
                (define-key helm-map (kbd "M-k")   'benjamin/helm-kill-buffer)
                (define-key helm-map (kbd "C-j")   'helm-next-line)
                (define-key helm-map (kbd "C-k")   'helm-previous-line)
                (define-key helm-map (kbd "C-S-j") 'helm-follow-action-forward)
                (define-key helm-map (kbd "C-S-k") 'helm-follow-action-backward)
                (define-key helm-map (kbd "<f9>")  'helm-backspace)
  :custom       (helm-mode-line-string "")
                (helm-buffer-details-flag nil))

(use-package    ivy-rich
  :disabled     t ; todo evaluate
  :ensure       t
  :after        (ivy)
  :custom       (ivy-rich-path-style 'abbrev)
                (ivy-rich-parse-remote-buffer nil)
                (ivy-rich-switch-buffer-mode-max-length 1)
                (ivy-rich-switch-buffer-name-max-length 60)
  :config       (ivy-set-display-transformer
                 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
                (defun ivy-rich-switch-buffer-major-mode () ""))

(use-package    ivy
  :ensure       t
  :custom       (ivy-use-virtual-buffers        t)
                (ivy-wrap                       t)
                (ivy-use-selectable-prompt      t)
                (ivy-fixed-height-minibuffer    t)
                (ivy-height                     24)
                (ivy-height-alist
                 '((counsel-evil-registers . 5)
                   (counsel-yank-pop       . 24)
                   (counsel-git-log        . 24)
                   (counsel--generic       . 24)
                   (counsel-el             . 7)))
                (ivy-extra-directories          nil)
                (ivy-count-format               "%d/%d - ")
                (ivy-display-style              'fancy)
                (ivy-ignore-buffers             '("\\` "))
  :bind         (:map ivy-minibuffer-map
                      ("M-o"    . nil)
                      ("S-SPC"  . nil)
                      ("C-j"    . ivy-next-line)
                      ("C-k"    . ivy-previous-line)
                      ("C-S-k"  . ivy-previous-line-and-call)
                      ("C-S-j"  . ivy-next-line-and-call)
                      ("C-r"    . ivy-previous-history-element)
                      ("C-s"    . ivy-next-history-element)
                      ("H-o"    . ivy-dispatching-done)
                      ("C-v"    . ivy-scroll-up-command)
                      ("C-S-v"  . ivy-scroll-down-command)
                      ("M-r"    . ivy-backward-kill-word)
                      ("C-x e"  . ivy-end-of-buffer)
                      ("C-x a"  . ivy-beginning-of-buffer)
                      ("C-c o"  . ivy-occur)
                      ("C-x <return>"    . ivy-restrict-to-matches)
                      ("C-x <C-return>"  . ivy-toggle-ignore)
                      ("<return>"        . ivy-alt-done)
                      ("C-<up>"          . ivy-previous-line-and-call)
                      ("C-<down>"        . ivy-next-line-and-call))
  :config       (ivy-mode 1)
                (add-to-list 'ivy-ignore-buffers "\\*Flycheck")
                (add-to-list 'ivy-ignore-buffers "\\*CEDET")
                (add-to-list 'ivy-ignore-buffers "\\*BACK")
                (add-to-list 'ivy-ignore-buffers "\\*Help\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Messages\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Compile-Log\\*")
                (add-to-list 'ivy-ignore-buffers "\\*helm")
                (setq ivy-virtual-abbreviate 'full)
                (define-key ivy-occur-grep-mode-map
                  (kbd "C-c w") 'ivy-wgrep-change-to-wgrep-mode)
                (define-key ivy-switch-buffer-map (kbd "M-o") nil)
                (define-key ivy-switch-buffer-map (kbd "M-k")
                  (lambi (ivy-set-action 'kill-buffer)
                         (ivy-call)
                         (ivy--reset-state ivy-last)
                         (ivy-set-action 'ivy--switch-buffer-action)))
                (define-key ivy-minibuffer-map (kbd "H-t")
                  (lambi (ivy-quit-and-run
                           (let ((default-directory ivy--directory))
                             (multi-term))))))

(use-package    avy
  :ensure       t
  :custom       (avy-case-fold-search nil)
                (avy-keys '(?a ?s ?d ?f ?g ?j ?k ?l ?w ?e ?r ?i ?o ?p ?m)))

(use-package    magit
  :ensure       t
  :after        (ivy)
  :custom       (magit-completing-read-function 'ivy-completing-read)
                (magit-display-buffer-function
                 'magit-display-buffer-fullframe-status-v1)
                (magit-status-sections-hook
                 '( magit-insert-status-headers
                   magit-insert-merge-log
                   magit-insert-rebase-sequence
                   magit-insert-am-sequence
                   magit-insert-sequencer-sequence
                   magit-insert-bisect-output
                   magit-insert-bisect-rest
                   magit-insert-bisect-log
                   magit-insert-untracked-files
                   magit-insert-unstaged-changes
                   magit-insert-staged-changes
                   magit-insert-stashes
                   magit-insert-unpulled-from-upstream
                   magit-insert-unpulled-from-pushremote
                   magit-insert-unpushed-to-pushremote)))

;; todo
(define-key magit-status-mode-map    "j" 'magit-section-forward)
(define-key magit-status-mode-map    "k" 'magit-section-backward)
(define-key magit-status-mode-map    "\C-k" nil)
(define-key magit-hunk-section-map    "\C-j" nil)
(define-key magit-hunk-section-map    "\C-k" nil)
(define-key magit-file-section-map    "\C-j" nil)
(define-key magit-file-section-map    "\C-k" nil)
(define-key magit-status-mode-map    "\C-d" 'magit-discard)
(define-key magit-log-mode-map       "j" 'magit-section-forward)
(define-key magit-log-mode-map       "k" 'magit-section-backward)
(define-key magit-commit-section-map "j" 'magit-section-forward)
(define-key magit-commit-section-map "k" 'magit-section-backward)
(define-key magit-diff-mode-map      "j" 'magit-section-forward)
(define-key magit-diff-mode-map      "k" 'magit-section-backward)

(defun git-commit-fill-column-hook ()
  "I mean a commit message should not be 80 chars."
  (setq fill-column 120))
(add-hook 'git-commit-mode-hook 'git-commit-fill-column-hook)

(use-package    swiper
  :ensure       t
  :custom       (counsel-grep-swiper-limit      120000))

(use-package    counsel
  :ensure       t
  :bind         (:map counsel-find-file-map
                      ("C-j"    . ivy-next-line)
                      ("C-k"    . ivy-previous-line)
                      ("C-S-k"  . ivy-previous-line-and-call)
                      ("C-S-j"  . ivy-next-line-and-call)
                      ("C-r"    . ivy-previous-history-element)
                      ("C-s"    . ivy-next-history-element)
                      ("M-r"    . ivy-backward-kill-word)
                      ("C-c o"  . ivy-occur))
  :config       (define-key counsel-mode-map (kbd "H-f") nil)
                (define-key counsel-find-file-map
                  (kbd "H-r") 'counsel-up-directory)
  :custom        (counsel-rg-base-command
                 (concat "rg -i --no-heading --line-number --max-columns 120 "
                         "--max-count 200 --max-filesize 100M "
                         "--color never %s . 2>/dev/null")))

(use-package    company
  :ensure       t
  :custom       (company-auto-complete-chars '(?. ?>))
                (company-backends
                 '(company-semantic
                   company-clang company-cmake
                   company-capf company-files
                   (company-dabbrev-code
                    company-gtags company-etags
                    company-keywords)
                   company-oddmuse company-dabbrev))
                (company-idle-delay 0)
                (company-minimum-prefix-length 2)
                (company-irony-ignore-case nil)
                (company-tooltip-idle-delay 1)
                (company-show-numbers t)
                (company-tooltip-limit 10)
  :config       (counsel-mode 1)
                (add-hook 'after-init-hook 'global-company-mode)
                (define-key company-active-map (kbd "\"") 'company-select-next)
                (define-key company-active-map (kbd "C-n") 'company-select-next)
                (define-key company-active-map (kbd "C-p") 'company-select-previous))

;; silly hack to make indent/complete functionality work properly
(define-key company-mode-map [remap indent-for-tab-command]
  'company-indent-for-tab-command)
(defvar completion-at-point-functions-saved nil)
(defun company-indent-for-tab-command (&optional arg)
  (interactive "P")
  (let ((completion-at-point-functions-saved completion-at-point-functions)
        (completion-at-point-functions '(company-complete-common-wrapper)))
    (indent-for-tab-command arg)))
(defun company-complete-common-wrapper ()
  (let ((completion-at-point-functions completion-at-point-functions-saved))
    (company-complete-common)))

;; abo-abo awesome company use-digit hack:
(let ((map company-active-map))
  (mapc
   ;; (lambda (x) (define-key map (format "%d" x) nil))
   (lambda (x) (define-key map (format "%d" x) 'ora-company-number))
   (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (define-key map (kbd "<return>") nil))
(defun ora-company-number ()
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
        (company-complete-number (string-to-number k)))))


(use-package    asm-mode
  :config       (define-key asm-mode-map (kbd "C-j") nil))

(use-package    jedi
  :disabled     t   ;; apparently company-jedi REPLACES jedi
  :ensure       t
  :init         (add-hook 'python-mode-hook 'jedi:setup)
                (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package    company-jedi
  :ensure       t
  :config       (add-hook 'python-mode-hook
                  (lambi (add-to-list 'company-backends 'company-jedi))))

(use-package    edit-server
  :ensure       t
  :config       (edit-server-start))

(use-package    switch-buffer-functions
  :ensure       t)

(use-package    autorevert
  :custom       (auto-revert-verbose                 nil)
                (global-auto-revert-non-file-buffers   t)
  :config       (global-auto-revert-mode))

(use-package    auto-dim-other-buffers
  :ensure       t
  :custom       (auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
  :config       (auto-dim-other-buffers-mode 1))

(use-package    volatile-highlights
  :ensure       t
  :config       (volatile-highlights-mode 1))

;; todo -- I forgot how to use this thing effectively
(use-package    wgrep
  :ensure       t
  :custom       (wgrep-auto-save-buffer t))

(use-package    recentf
  :custom       (recentf-max-saved-items 100)
  :config       (recentf-mode 1))

(use-package    whitespace
  :custom       (whitespace-style '(face empty tabs lines-tail trailing)))

(use-package    hl-line
  :ensure       nil
  :config       (global-hl-line-mode 1))

(use-package    helm-gtags
  :ensure       t
  :custom       (helm-gtags-auto-update         t)
                (helm-gtags-use-input-at-cursor t)
  :config       (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
                (setenv "GTAGSLIBPATH" "~/.gtags") ;; todo bad
  :hook         (prog-mode-hook . helm-gtags-mode))

(use-package    flycheck
  :ensure        t
  :custom       (flycheck-check-syntax-automatically '(mode-enabled idle-change save))
                (flycheck-idle-change-delay 0.5)
                (flycheck-display-errors-delay 0.5)
  :config       (add-hook 'after-init-hook 'global-flycheck-mode)
                (define-key flycheck-mode-map
                  (kbd "C-x f") 'benjamin/flycheck-list-errors))

(use-package    flycheck-pos-tip
  :ensure       t
  :after        (flycheck)
  :custom       (flycheck-pos-tip-timeout 20)
  :config       (with-eval-after-load 'flycheck (flycheck-pos-tip-mode)))

(use-package    irony
  :ensure       t
  :config       (defun my-irony-mode-hook ()
                  "Pretty sure this does nothing relevant."
                  (define-key irony-mode-map [remap completion-at-point]
                    'irony-completion-at-point-async)
                  (define-key irony-mode-map [remap complete-symbol]
                    'irony-completion-at-point-async)
                  (irony-cdb-autosetup-compile-options))
                (add-hook 'irony-mode-hook 'my-irony-mode-hook))

(use-package    flycheck-irony
  :ensure       t
  :after        (flycheck irony)
  :config       (eval-after-load 'flycheck
                  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package    dts-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.dts$" . dts-mode))
                (add-to-list 'auto-mode-alist '("\\.dtsi$" . dts-mode))
                (add-hook 'dts-mode-hook 'subword-mode)
                (add-hook 'dts-mode-hook 'helm-gtags-mode))

(use-package    bitbake
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.bb$" . bitbake-mode))
                (add-to-list 'auto-mode-alist '("\\.bbappend$" . bitbake-mode))
                (add-hook 'bitbake-mode-hook 'subword-mode)
                (add-hook 'bitbake-mode-hook 'helm-gtags-mode))

(use-package    hippie-exp
  :ensure       t
  :custom       (hippie-expand-try-functions-list
                 '(try-expand-dabbrev
                   try-expand-dabbrev-all-buffers
                   try-expand-dabbrev-from-kill
                   try-complete-file-name-partially
                   try-complete-file-name
                   try-expand-all-abbrevs
                   try-expand-list
                   try-expand-line
                   try-complete-lisp-symbol-partially)))

(use-package    linum
  :ensure       nil
  :custom       (global-linum-mode nil))

(use-package    flyspell
  :bind         (:map flyspell-mode-map
                      (("C-.")   . nil)
                       ("σ"       . company-flyspell)
                       ("C-;"     . flyspell-correct-word-before-point)
                       ("H-M-y"   . flyspell/save-word))
  :config       (defun flyspell/save-word ()
                  (interactive)
                  (let ((current-location (point))
                        (word (flyspell-get-word)))
                    (when (consp word)
                      (flyspell-do-correct 'save nil (car word)
                                           current-location (cadr word)
                                           (caddr word) current-location))))
  :custom       (flyspell-issue-message-flag nil)
                (flyspell-issue-welcome-flag nil))

(use-package    org
  :custom       (org-hide-leading-stars t)
                ;; (org-ellipsis " {…}")
                (org-ellipsis " {...}")
                (org-agenda-files
                 '("~/work/agenda.org"
                   "~/notes/read.org"
                   "~/notes/todo.org"
                   "~/notes/emacs.org"
                   "~/work/elci.org"
                   "~/work/gptp.org"
                   "~/work/endian/p1807-smartpuck/smartpuck.org"
                   "~/work/endian/glhf/glhf.org"
                   "~/work/v2v-module/v2v.org"))
  :config       (add-hook 'org-mode-hook 'turn-on-auto-fill)
                ;; (add-hook 'org-mode-hook (lambi (fringe-mode nil)) t t)
                (add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
                (define-key org-mode-map (kbd "C-o")
                  (lambi (beginning-of-line) (newline)
                         (forward-line -1)))
                (copy-face font-lock-constant-face 'calendar-iso-week-face)
                (set-face-attribute 'calendar-iso-week-face nil
                                    :height 0.7)
                (setq calendar-intermonth-text
                      '(propertize
                        (format "%2d"
                                (car
                                 (calendar-iso-from-absolute
                                  (calendar-absolute-from-gregorian
                                   (list month day year)))))
                        'font-lock-face 'calendar-iso-week-face))
                ;; (setq org-agenda-start-on-weekday 'monday)
                (load-file "~/.emacs.d/sv-kalender.el")
  :bind         (:map org-mode-map
                      ("C-a"        . nil)
                      ("C-e"        . nil)
                      ("M-a"        . nil)
                      ("M-RET"      . nil)
                      ("<C-tab>"    . nil)
                      ("M-e"        . nil)
                      ("C-S-a"      . outline-previous-visible-heading)
                      ("C-S-e"      . outline-next-visible-heading)
                      ("C-j"        . next-line)
                      ("C-k"        . previous-line)))

(use-package    org-capture
  :custom       (org-default-notes-file "~/notes/capture.org")
  :config       (add-to-list 'org-agenda-files "~/notes/capture.org")
                (setq org-capture-templates
                  '(("t" "Task" entry (file+headline "" "Tasks")
                     "* TODO %?\n  %u\n  %a")
                    ("T" "Task with Clipboard" entry
                     (file "~/notes/capture.org")
                     "* TODO %?\n%U\n   %c" :empty-lines 1)
                    ("n" "Note" entry (file "~/notes/capture.org")
                     "* NOTE %?\n%U" :empty-lines 1)
                    ("N" "Note with Clipboard" entry
                     (file "~/notes/capture.org")
                     "* NOTE %?\n%U\n   %c" :empty-lines 1)
                    ("e" "Event" entry
                     (file+headline "~/notes/capture.org" "Transient")
                     "* EVENT %?\n%U" :empty-lines 1)
                    ("E" "Event With Clipboard" entry
                     (file+headline "~/notes/capture.org/Events.org"
                                    "Transient")
                     "* EVENT %?\n%U\n   %c" :empty-lines 1))))

(use-package    markdown-mode
  :ensure        t
  :config       (add-hook 'markdown-mode-hook 'fci-mode)
                (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
  :bind         (:map markdown-mode-map
                      ("M-RET" . nil))
                )

(use-package    git-gutter+
  :ensure       t
  ;; wrecks TRAMP for some reason, disabled by default:
  :config       (global-git-gutter+-mode -1))

(use-package    goto-chg
  :ensure       t)

(use-package    helm-systemd
  :ensure       t
  :custom       (helm-systemd-list-all t)
                (helm-systemd-list-not-loaded t))

(use-package    anaconda-mode
  :ensure       t
  :config       (add-hook 'python-mode-hook 'anaconda-mode)
                (with-eval-after-load "anaconda-mode"
                  (define-key anaconda-mode-map (kbd "M-r") nil)))

(use-package    elpy
  :ensure       t
  :custom       (elpy-rpc-backend "jedi")
                (python-indent-guess-indent-offset t)
                (python-shell-interpreter "ipython")
                (python-indent-offset 4)
                (python-shell-interpreter-args "-i --simple-prompt")
                (python-indent-guess-indent-offset-verbose nil)
                (python-skeleton-autoinsert t)
  :config       (remove-hook 'elpy-modules 'elpy-module-flymake)
                (remove-hook 'elpy-modules 'elpy-module-highlight-indentation)
                (add-to-list 'elpy-modules 'flycheck-mode)
                (elpy-enable)
                (add-hook 'python-mode-hook
                          (lambi (set (make-local-variable 'flycheck-checker)
                                      'python-flake8))))

(use-package    pyenv-mode
  :ensure       t
  :config       (pyenv-mode))

(use-package    frame
  :config       (window-divider-mode t)
                (custom-set-faces
                 '(window-divider ((t (:foreground "#707070")))))
  :custom       (window-divider-default-bottom-width 1)
                (window-divider-default-places 'bottom-only))

(use-package    yasnippet
  :ensure       t
  ;; :after        (auto-indent-mode)
  :config       (yas-global-mode 1))

(use-package    semantic
  :custom       (semantic-idle-scheduler-idle-time 5)
  :config       (semantic-mode 1)
                (defun my-inhibit-semantic-p ()
                  (not (equal major-mode 'org-mode)))
                (with-eval-after-load 'semantic
                  (add-to-list 'semantic-inhibit-functions
                               #'my-inhibit-semantic-p))
                (global-semantic-idle-scheduler-mode t)
                (add-to-list 'semantic-default-submodes
                             'global-semantic-idle-scheduler-mode)
                (add-to-list 'semantic-default-submodes
                             'global-semanticdb-minor-mode)
                (semantic-add-system-include "/usr/lib/python3.6" 'python-mode)
                (semantic-add-system-include "/usr/lib/python2.7" 'python-mode))

(defun c-occur-overview ()
  "Grep for definitions/declarations etc, in C."
  (interactive)
  (let ((list-matching-lines-face nil))
    (occur "^[a-z].*("))
  (enlarge-window 25)
  (hydra-errgo/body))

(use-package    company-irony              :ensure t)
(use-package    company-irony-c-headers    :ensure t)
(use-package    semantic/bovine/c
  :config       (add-to-list 'semantic-lex-c-preprocessor-symbol-file
                             "/usr/lib/clang/5.0.0/include/stddef.h"))

(defvar indent-after-yank nil)
(defun set-local-indent-after-yank (true)
  "Habpowjeg TRUE fepowjfew."
  (if true
      (progn (add-hook 'yank 'indent-region t t)
             (setq indent-after-yank t))
    (progn (remove-hook 'yank 'indent-region)
           (setq indent-after-yank nil))))

(defadvice yank (after indent-yanked-stuff activate)
  "Indent region after yanking stuff."
  (exchange-point-and-mark)
  (call-interactively 'indent-region))

(use-package    cc-mode
  :after        (semantic)
  :custom       (c-default-style        "user")
                (c-basic-offset         4)
                (c-backslash-max-column 80)
  :bind         (:map c-mode-base-map
                      ("M-q"    . nil) ("M-e"    . nil) ("M-a"    . nil)
                      ("C-M-a"  . nil) ("C-M-e"  . nil) ("M-j"    . nil)
                      ("C-M-j"  . nil) ("C-M-k"  . nil)
                      ("C-c o"  . c-occur-overview)
                      ;; todo: (defun toggle-show-ifdef ())
                      ("H-M-h"     . hide-ifdef-block)
                      ("H-M-H"     . show-ifdef-block)
                      ("C-c H-M-h" . hide-ifdefs)
                      ("C-c H-M-H" . show-ifdefs)
                      ("C-c C-c"   . compile)
                      ("M-c"       . hydra-gdb/body)       ;; todo
                      ("C-i"       . company-indent-for-tab-command))
  :init         (semanticdb-enable-gnu-global-databases 'c-mode)
                (semanticdb-enable-gnu-global-databases 'c++-mode))

(defun benjamin/c-hook ()
  "Setup for C bla."
  (if (string-match-p "linux\\|uboot|u-boot" buffer-file-name)
      (progn (c-set-style "linux")
             (setq c-tab-always-indent t))
    (progn (setq c-basic-offset 4)
           (setq c-tab-always-indent t)
           (c-set-style "user")))
  (set-local-indent-after-yank t)
  (subword-mode 1)
  (flycheck-mode 1)
  (helm-gtags-mode 1)
  (fci-mode -1) ;; destroys company
  (hide-ifdef-mode 1) ;; needed...?
  (irony-mode 1)
  (company-mode 1)
  (semantic-mode 1)
  (semantic-stickyfunc-mode -1)
  (set (make-local-variable 'company-backends)
       '((company-irony-c-headers
          ;; company-c-headers
          company-irony
          company-cmake)))
  (setenv "GTAGSLIBPATH" "/home/benjamin/.gtags/"))
(add-hook 'c-mode-hook 'benjamin/c-hook)
(add-hook 'c++-mode-hook 'benjamin/c-hook)

(use-package    pdf-tools
  :ensure       t
  :config       (with-eval-after-load 'pdf-view
                  (progn (define-key pdf-view-mode-map
                           (kbd "M-g g") 'pdf-view-goto-page)
                         (define-key pdf-view-mode-map
                           (kbd "M-g M-g") 'pdf-view-goto-page)
                         (define-key pdf-view-mode-map
                           (kbd "k") 'previous-line)
                         (define-key pdf-view-mode-map
                           (kbd "j") 'next-line)
                         (define-key pdf-view-mode-map
                           (kbd "C-k") 'pdf-view-previous-page)
                         (define-key pdf-view-mode-map
                           (kbd "H-M-m") 'pdf-view-mark-whole-page)
                         (define-key pdf-view-mode-map
                           (kbd "C-j") 'pdf-view-next-page)))
                  (add-to-list 'auto-mode-alist '("\\.pdf$" . pdf-view-mode)))

(use-package    gud
  :custom       (gud-pdb-command-name "python -m pdb")
  :config       (define-key gud-mode-map (kbd "M-c") 'hydra-gdb/body))



;; SPC             realgud:cmd-step
;; +               realgud:cmd-enable
;; -               realgud:cmd-disable
;; 1               realgud-goto-arrow1
;; 2               realgud-goto-arrow2
;; 3               realgud-goto-arrow3
;; 4               realgud:goto-loc-hist-4
;; 5               realgud:goto-loc-hist-5
;; 6               realgud:goto-loc-hist-6
;; 7               realgud:goto-loc-hist-7
;; 8               realgud:goto-loc-hist-8
;; 9               realgud:goto-loc-hist-9
;; <               realgud:cmd-newer-frame
;; >               realgud:cmd-older-frame
;; C               realgud-window-cmd-undisturb-src
;; D               realgud:cmd-delete
;; E               realgud:cmd-eval-at-point
;; F               realgud:window-bt
;; I               realgud:cmdbuf-info-describe
;; J               realgud:cmd-jump
;; K               realgud:cmd-kill
;; Q               realgud:cmd-terminate
;; R               realgud:cmd-restart
;; S               realgud-window-src-undisturb-cmd
;; T               realgud:cmd-backtrace
;; U               realgud:cmd-until
;; X               realgud:cmd-clear
;; b               realgud:cmd-break
;; c               realgud:cmd-continue
;; d               realgud:cmd-newer-frame
;; e               realgud:eval-dotsymbol-at-point
;; f               realgud:cmd-finish
;; n               realgud:cmd-next
;; p               realgud:eval-dotsymbol-at-point
;; q               realgud:cmd-quit
;; r               realgud:cmd-restart
;; s               realgud:cmd-step
;; u               realgud:cmd-older-frame
;; <A-down>        realgud-track-hist-newer
;; <A-up>          realgud-track-hist-older
;; <M-S-down>      realgud-track-hist-newest
;; <M-S-up>        realgud-track-hist-oldest
;; <M-down>        realgud-track-hist-newer
;; <M-kp-2>        realgud-track-hist-newer
;; <M-kp-8>        realgud-track-hist-older
;; <M-kp-down>     realgud-track-hist-newer
;; <M-kp-up>       realgud-track-hist-older
;; <M-print>       realgud-track-hist-older
;; <M-up>          realgud-track-hist-older
;; <S-f11>         realgud:cmd-finish
;; <S-f5>          realgud:cmd-quit
;; <delete>        realgud:cmd-delete
;; <enter>         realgud:cmd-repeat-last
;; <f10>           realgud:cmd-next
;; <f11>           realgud:cmd-step
;; <f5>            realgud:cmd-continue
;; <f9>            realgud:cmd-break
;; <insert>        realgud-short-key-mode
;; <mouse-2>       realgud:tooltip-eval
;; <left-margin> <mouse-1> realgud-cmds--mouse-add-remove-bp
;; C-c SPC         realgud:cmd-break
;; C-x C-q         realgud-short-key-mode
;; C-x C-a C-q     realgud-short-key-mode
;; <m-insert>      realgud-short-key-mode

(defun my-forward-whitespace ()
  (interactive)
  (forward-whitespace 1))

(defun my-backward-whitespace ()
  (interactive)
  (forward-whitespace -1))

;; TODO: Fix realgud so that we can insert visual breaks. jfc...
(use-package    realgud
  :ensure       t
  :custom       (realgud:pdb-command-name "python -m pdb")
                (realgud-safe-mode nil)
  :config       (defun realgud:eval-dotsymbol-at-point ()
                  "The eval-at-point stuff included in realgud are baaad."
                  (interactive)
                  (with-syntax-table (make-syntax-table (syntax-table))
                    (modify-syntax-entry ?. "_")
                    (let ((bounds (bounds-of-thing-at-point 'symbol)))
                      (realgud:cmd-eval-region (car bounds) (cdr bounds)))))
                (define-key realgud-track-mode-map (kbd "M-c") realgud-short-key-mode-hook)
  :bind         (:map realgud:shortkey-mode-map
                      ("e" . realgud:eval-dotsymbol-at-point)

                      ("J" . realgud:cmd-jump)
                      ("K" . realgud:cmd-kill)
                      ("h" . my-backward-whitespace)
                      ("j" . next-lines-indentation)
                      ("k" . previous-lines-indentation)
                      ("l" . my-forward-whitespace)

                      ("c" . realgud:cmd-continue)
                      ("n" . realgud:cmd-next)))

(use-package    diff-mode
  :config       (define-key diff-mode-map (kbd "M-.") 'diff-goto-source)
                (define-key diff-mode-map (kbd "M-o") nil))

(use-package    ediff
  :custom        (ediff-window-setup-function 'ediff-setup-windows-plain)
                (ediff-split-window-function 'split-window-horizontally)
                (ediff-diff-options "-w --text"))

(defun ediff-jk ()
  "Vimish navigation for ediff."
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))
(add-hook 'ediff-keymap-setup-hook #'ediff-jk)

(use-package    erc
  :custom       (erc-autojoin-channels-alist '(("#emacs")))
                (erc-nick "g00iekabl00ie"))

(use-package    hexl
  :config       (add-to-list 'auto-mode-alist '("\\.hex$" . hexl-mode)))

(use-package    elf-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.elf$" . elf-mode)))


(use-package    face-remap
  :config        (defun set-boring-buffer-face ()
                   (interactive)
                   (setq buffer-face-mode-face
                         '(:background "gray" :foreground "black"))
                   (buffer-face-mode))
                (add-hook 'help-mode-hook 'set-boring-buffer-face)
                (add-hook 'Info-mode-hook 'set-boring-buffer-face))

(use-package    elec-pair
  :config       (electric-pair-mode 1))

(use-package    auto-indent-mode
  :disabled     t ;; terrible
  :ensure       t
  :custom       (auto-indent-on-visit-file          nil)
                (auto-indent-indent-style           'conservative)
                (auto-indent-untabify-on-save-file  nil)
                ;; (auto-indent-known-indent-level-variables
                 ;; '( lisp-body-indent
                    ;; sgml-basic-offset
                    ;; python-indent
		            ;; python-indent-offset))
  :config       (auto-indent-global-mode))

(use-package    display-line-numbers
  :config       (global-display-line-numbers-mode t)) ;; test

(use-package py-autopep8             :ensure t)
(use-package stickyfunc-enhance      :ensure t)
(use-package hydra                   :ensure t)
(use-package vimish-fold             :ensure t)
(use-package expand-region           :ensure t)
(use-package switch-buffer-functions :ensure t)
(use-package multiple-cursors        :ensure t)
(use-package hungry-delete           :ensure t)
(use-package iedit                   :ensure t)
(use-package move-text               :ensure t)
(use-package git-timemachine         :ensure t)
(use-package goto-chg                :ensure t)
(use-package function-args           :ensure t)
(use-package lispy                   :ensure t)
(use-package helm-chrome             :ensure t)
(use-package helm-google             :ensure t)
(use-package highlight               :ensure t)
(use-package fireplace               :ensure t)
(use-package flyspell-correct-ivy    :ensure t)
(use-package visual-fill-column      :ensure t)

(defvar benjamin/visual-fill nil)
(defun benjamin/visual-fill ()
  (interactive)
  (if (not benjamin/visual-fill)
      (progn (toggle-truncate-lines -1)
             (fci-mode -1)
             (visual-fill-column-mode 1)
             (setq benjamin/visual-fill t))
    (toggle-truncate-lines +1)
    (visual-fill-column-mode -1)
    (setq benjamin/visual-fill nil)))


;;-- Some general hooks --------------------------------------------------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'find-file-hook   'find-file-root-header-warning)
(add-hook 'occur-hook       'occur-rename-buffer)
(add-hook 'prog-mode-hook
 (lambi (set-local-indent-after-yank t)
        (hs-minor-mode 1)
        ;; (set (make-local-variable 'comment-auto-fill-only-comments) t)
        (local-set-key (kbd "RET") 'newline-and-indent)))

;;-- Random general stuff ------------------------------------------------------
(setq-default
 fill-column                            80
 truncate-lines                         nil
 tab-width                              4
 cursor-type                            t
 ;; cursor-type                           'hollow
 indent-tabs-mode                       nil)

(setq
 enable-recursive-minibuffers           nil
 ;; enable-recursive-minibuffers           t
 cursor-type                            t
 ;; cursor-type                            'hollow
 explicit-shell-file-name               "/bin/bash"
 tab-always-indent                      t
 indent-tabs-mode                       nil
 auto-hscroll-mode                      nil
 mouse-autoselect-window                t
 shift-select-mode                      nil
 echo-keystrokes                        0.1
 bookmark-save-flag                     1
 scroll-margin                          2
 scroll-preserve-screen-position        nil
 scroll-error-top-bottom                t
 fill-column                            80
 sentence-end-double-space              nil
 inhibit-splash-screen                  t
 initial-major-mode                     'org-mode
 gc-cons-threshold                      20000000
 backup-by-copying                      t
 delete-old-versions                    t
 kept-new-versions                      10
 kept-old-versions                      5
 delete-by-moving-to-trash              t
 version-control                        t
 auto-save-file-name-transforms        `((".*" ,temporary-file-directory t))
 backup-directory-alist                '(("."  . "~/.saves"))
 create-lockfiles                       nil
 save-interprogram-paste-before-kill    t
 select-enable-clipboard                t
 ;; browse-url-browser-function            'browse-url-chrome
 ;; browse-url-chrome-arguments            "--new-window"
 compilation-scroll-output              'first-error
 tab-always-indent                      'complete
 vc-follow-symlinks                     t
 kill-buffer-query-functions
 (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(ansi-color-for-comint-mode-on)
(fset 'yes-or-no-p            'y-or-n-p)
(put 'scroll-left             'disabled nil)
(put 'narrow-to-region        'disabled nil)
(set-language-environment     "UTF-8")
(set-default-coding-systems   'utf-8)
(menu-bar-mode                -1)
(tool-bar-mode                -1)
(scroll-bar-mode              -1)
(delete-selection-mode         1)
(auto-compression-mode         1)
(fringe-mode                   0)


(add-to-list 'auto-mode-alist '("defconfig$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.conf$"   . conf-mode))
(add-to-list 'auto-mode-alist '("\\.sch$"    . text-mode))
(add-to-list 'auto-mode-alist '("\\.scr$"    . sh-mode))
(add-to-list 'auto-mode-alist '("\\rc$"      . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash"    . sh-mode))

;; Open some defaults
(load        "~/.emacs.d/bindings2.el")
(find-file    "~/.emacs.d/bindings2.el")
(find-file    "~/.emacs.d/init.el")
(condition-case nil (kill-buffer "*scratch*") (error nil))

;; -- tmp ----------------------------------------------------------------------
(setq safe-local-variable-values
      '((irony-additional-clang-options "-I/home/benjamin/repos/linux/include" "-include/home/benjamin/repos/linux/include/linux/kconfig.h" "-D__KERNEL__" "-D__GNUC__" "-DMODULE" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")))

(provide 'init)
;;; init.el ends here
