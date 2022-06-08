;;; init.el --- Summary:
;;; Commentary:
;;; Code:
;;; todo: https://github.com/abo-abo/hydra/wiki/Macro
(setenv "PATH" (concat "/home/benjamin/bin:/home/benjamin/.local/bin:" (getenv "PATH"))) ; ugh

(require 'package)
(add-to-list 'package-archives '("melpa"        . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://melpa-stable.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("marmalade"    . "https://marmalade-repo.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/repos/counsel-term/")
(add-to-list 'load-path "~/repos/feebleline")

(package-initialize)
(if (not (fboundp 'use-package))
    (progn (package-refresh-contents) (package-install 'use-package)))
;; (setq custom-file "~/.emacs.d/.custom")
;; (load-file custom-file)

(defmacro lambi (&rest b)
  "Just a lazy macro, have to mention B in docstring."
  `(lambda () (interactive),@b))

; -- tmp fix -------------------------------------------------------------------
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")



; -- my own stuff (mostly) -----------------------------------------------------
(use-package    kill-at-point)
(use-package    kernel-dev-mode)
(use-package    helm-addons)
(use-package    some-defuns)
(use-package    some-hydras)
(use-package    some-i3-defuns)
(use-package    pdf-custom)
(use-package    zoom-frm)         ;; raw download
(use-package    company-flyspell) ;; raw download

(use-package    ivy-addons
  :after        (ivy)
  :config       (define-key ivy-minibuffer-map (kbd "M-k") 'ivy-kill-buffer)
                (define-key ivy-switch-buffer-map (kbd "C-k") nil)
                (define-key ivy-minibuffer-map (kbd "H-t") 'ivy-jump-to-multiterm)
                ;; cheap hack:
                (defun ivy--insert-symbol-boundaries () nil )
  )

(use-package    term-addons
  :after        (ivy)
  :config       (add-hook 'sh-mode-hook 'benjamin/sh-hook))

(use-package    counsel-term
  :custom       (counsel-term-ff-initial-input      "")
                (counsel-term-history-initial-input "")
  :load-path    "~/repos/counsel-term")

(defun feebleline-time-string ()
  "Get time string."
  (format "%s" (format-time-string "%H:%M")))

(use-package    feebleline
  :load-path    "~/repos/feebleline"
  :after        (magit font-lock)
  :custom       (feebleline-msg-functions
                 '((feebleline-line-number         :post "" :fmt "%5s")
                   (feebleline-column-number       :pre ":" :fmt "%-2s")
                   (feebleline-file-directory
                    ;; :face feebleline-dir-face :post "")
                    :face default :post "")
                   (feebleline-file-or-buffer-name
                    :face font-lock-keyword-face :post "")
                   (feebleline-file-modified-star
                    :face font-lock-warning-face :post "")
                   (feebleline-git-branch
                    :face feebleline-git-face :pre " : " :post "")
                   ;; (feebleline-time-string         :face font-lock-comment-face :align right)
                   ))
  :config       (feebleline-mode 1))

(use-package    barhop
  :load-path    "~/repos/barhop"
  :after        (counsel-projectile)
  ;; :config       (barhop-mode 1)
  ) ;; not good enough(, yet?)

; -- others stuff --------------------------------------------------------------
;; (use-package eglot :ensure t)
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)

(use-package lsp-mode
  :ensure t
  :commands (lsp ls-deferred)
  :config
  (setq lsp-before-save-edits nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-semantic-tokens-enable nil)
  (setq lsp-enable-semantic-highlighting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-enable-file-watchers nil))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-doc-enable nil)
  )

(use-package ccls
 :ensure t
 :config
 (setq ccls-library-folders-fn (lambda (_workspace)
                                 (list
                                  "/home/benjamin/work/west/zephyr"
                                  "")))
 :hook
 ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp))))

(use-package    undo-tree
  :ensure       t
  :config       (global-undo-tree-mode 1)
  :bind         (:map undo-tree-map ("C-x r" . nil)
                                    ("C-_"   . nil)))

(use-package    scad-mode
  :ensure       t)

(use-package    multi-term
  :ensure       t
  :custom       (multi-term-program     "/bin/bash")
                (term-prompt-regexp     "^$\\ ")
                (term-buffer-maximum-size 2048)
                (multi-term-switch-after-close nil)
                (term-char-mode-buffer-read-only nil)
                (term-char-mode-point-at-process-mark nil)
  :config       (defun benjamin/term-hook ()
                  "Run on open terminal."
                  (set (make-local-variable 'scroll-margin) 0)
                  (let ((map term-raw-map))
                    (define-key map (kbd "M-o")   nil)
                    (define-key map (kbd "C-t")   nil)
                    (define-key map (kbd "C-_")   nil)
                    (define-key map (kbd "C-b")   nil)
                    (define-key map (kbd "C-t")   nil)
                    (define-key map (kbd "C-g")  (lambi (term-send-raw-string "")))
                    (define-key map (kbd "M-o")   'other-window)
                    (define-key map (kbd "C-t t") 'term-toggle-mode)
                    (define-key map (kbd "C-d")   'term-send-raw)
                    (define-key map (kbd "C-r")   'counsel-term-history)
                    (define-key map (kbd "C-q")   'term-send-backward-word)
                    (define-key map (kbd "C-f")   'term-send-forward-word)
                    (define-key map (kbd "C-p")   'hydra-projectile/body)
                    (define-key map (kbd "C-j")   'next-line)
                    (define-key map (kbd "C-k")   'previous-line)
                    (define-key map (kbd "C-l")   'forward-char)
                    (define-key map (kbd "C-h")   'backward-char)
                    (define-key map (kbd "H-n")   'term-downdir)
                    (define-key map (kbd "H-p")   'term-updir)
                    (define-key map (kbd "C-n")   'mark-line)
                    (define-key map (kbd "C-s")   'swiper)
                    (define-key map (kbd "C-m")   'term-send-return)
                    (define-key map (kbd "H-w")   'counsel-term-ff)
                    (define-key map (kbd "C-y")   'term-paste)
                    (define-key map (kbd "H-i")   'term-paste)
                    (define-key map (kbd "H-f")   'avy-goto-word-or-subword-1)
                    (define-key map (kbd "H-c")   'counsel-term-cd)
                    (define-key map (kbd "M-r")   'term-send-backward-kill-word)
                    (define-key map (kbd "M-q")   'term-send-backward-word)
                    (define-key map (kbd "M-f")   'term-send-forward-word)
                    (define-key map (kbd "M-p")   'term-send-up)
                    (define-key map (kbd "M-n")   'term-send-down)
                    (define-key map (kbd "M-d")   'term-send-delete-word)
                    (define-key map (kbd "M-,")   'term-send-raw)
                    (define-key map (kbd "C-S-a") 'beginning-of-line)
                    (define-key map (kbd "C-S-e") 'end-of-line)
                    ;; (define-key map (kbd "<f9>")  'term-send-backspace)
                    (define-key map (kbd "TAB")   'term-send-raw)
                    (define-key map (kbd "H-M-f") 'find-file-at-point)
                    (define-key map (kbd "C-t t") 'term-toggle-mode)
                    (define-key map (kbd "C-c C-c") 'term-interrupt-subjob)
                    (define-key map (kbd "C-c C-e") 'term-send-esc)
                    (define-key map (kbd "<C-backspace>") 'term-send-backward-kill-word)
                    (define-key map (kbd "M-DEL") 'term-send-backward-kill-word)
                    (define-key map (kbd "<C-return>")    'term-cd-input)
                    (define-key map (kbd "H-k")     (lambi (term-send-raw-string "")))
                    (define-key map (kbd "H-l")     (lambi (term-send-raw-string "")))
                    (define-key map (kbd "[")       (lambi (term-send-raw-string "[]")))
                    (define-key map (kbd "(")       (lambi (term-send-raw-string "()")))
                    (define-key map (kbd "{")       (lambi (term-send-raw-string "{}")))
                    (define-key map (kbd "C-S-l")   (lambi (term-send-raw-string "")))
                    (define-key map (kbd "H-M-u")   (lambi (term-send-raw-string "sudo ")))
                    (define-key map (kbd "C-c C-z") (lambi (term-send-raw-string "")))
                    (define-key map (kbd "C-c C-x") (lambi (term-send-raw-string "")))
                    (define-key map (kbd "C-c C-l") (lambi (term-send-raw-string "")))
                    )
                  )
                (add-hook 'term-mode-hook 'benjamin/term-hook))

(use-package    term-projectile
  :ensure       t)

(use-package    fill-column-indicator
  :ensure       t
  :custom       (fci-rule-display 80)
                (fci-rule-width 1)
                (fci-rule-color "#959595")
                (add-hook 'find-file-hook 'turn-on-fci-mode))

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
                (projectile-project-root-files
                 '(".dir-locals.el" ".west" ".repo" "pubspec.yaml" "info.rkt"
                   "Cargo.toml" "stack.yaml" "DESCRIPTION" "Eldev" "Cask"
                   "shard.yml" "Gemfile" ".bloop" "deps.edn" "build.boot"
                   "project.clj" "build.sbt" "application.properties" "gradlew"
                   "build.gradle" "pom.xml" "poetry.lock" "Pipfile" "tox.ini"
                   "setup.py" "requirements.txt" "manage.py" "angular.json"
                   ;; "CMakeLists.txt" "Makefile"
                   "WORKSPACE" "meson.build" "GTAGS"
                   "TAGS" "configure.ac" "configure.in" "cscope.out")
                 )
  :config       (add-to-list 'projectile-project-root-files ".repo")
                (add-to-list 'projectile-project-root-files ".west")
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
                (define-key projectile-mode-map (kbd "C-c p") nil)
  :bind (:map projectile-command-map
              ("t"   . projectile-get-term)
              ("T"   . projectile-test-project)
              ("u"   . projectile-run-project)
              ("r"   . counsel-projectile-ripgrep)
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
                (helm-full-frame t)
                (helm-buffer-details-flag t))
                ;; (helm-buffer-details-flag nil))

(use-package    all-the-icons   :disabled     t ;; meh
  :ensure       t
  :config       (defun ivy-rich-switch-buffer-icon (candidate)
                  (with-current-buffer (get-buffer candidate)
	                (let ((icon (all-the-icons-icon-for-mode major-mode)))
	                  (if (symbolp icon)
	                      (all-the-icons-icon-for-mode 'fundamental-mode)
	                    icon)))))

(use-package    ivy-rich ;;:disabled ;; slightly buggy
  :ensure       t
  :after        (ivy)
  :custom       (ivy-rich-path-style 'full)
                (ivy-rich-parse-remote-buffer nil)
                (ivy-rich--display-transformers-list
                 '(ivy-switch-buffer
                   (:columns
                    (;; (ivy-rich-switch-buffer-icon :width 2)
                     (ivy-rich-candidate (:width 40))
                     ;; (ivy-rich-switch-buffer-size (:width 7))
                     (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
                     ;; (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
                     (ivy-rich-switch-buffer-project (:width 10 :face success))
                     ;; (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.5))))))
                     (ivy-rich-switch-buffer-path (:width 80)))
                    :predicate
                    (lambda (cand) (get-buffer cand)))
                   counsel-M-x
                   (:columns
                    ((counsel-M-x-transformer (:width 40))
                     (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
                   counsel-describe-function
                   (:columns
                    ((counsel-describe-function-transformer (:width 40))
                     (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
                   counsel-describe-variable
                   (:columns
                    ((counsel-describe-variable-transformer (:width 40))
                     (ivy-rich-counsel-variable-docstring (:face font-lock-doc-face))))
                   counsel-recentf
                   (:columns
                    ((ivy-rich-candidate (:width 0.8))
                     (ivy-rich-file-last-modified-time (:face font-lock-comment-face)))))
                 )
                (ivy-rich-switch-buffer-mode-max-length 1)
                (ivy-rich-switch-buffer-name-max-length 60)
                (ivy-format-function #'ivy-format-function-line) ;; ??
  :config       ;; (ivy-rich-mode 1) ;; bit too slow...
  )

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
                   (counsel-git-log        . 60)
                   (counsel--generic       . 24)
                   (counsel-el             . 7)))
                (ivy-extra-directories          nil)
                (ivy-count-format               "%d/%d - ")
                (ivy-display-style              'fancy)
                (ivy-ignore-buffers             '("\\` "))
  :bind         (:map ivy-minibuffer-map
                      ("M-o"        . nil)
                      ("S-SPC"      . nil)
                      ("C-j"        . ivy-next-line)
                      ("C-k"        . ivy-previous-line)
                      ("C-S-k"      . ivy-previous-line-and-call)
                      ("C-S-j"      . ivy-next-line-and-call)
                      ("C-r"        . ivy-previous-history-element)
                      ("C-s"        . ivy-next-history-element)
                      ("H-o"        . ivy-dispatching-done)
                      ("H-M-o"      . hydra-ivy/body)
                      ("C-v"        . ivy-scroll-up-command)
                      ("C-S-v"      . ivy-scroll-down-command)
                      ("M-r"        . ivy-backward-kill-word)
                      ("C-x e"      . ivy-end-of-buffer)
                      ("C-x a"      . ivy-beginning-of-buffer)
                      ("C-c o"      . ivy-occur)
                      ("C-x RET"    . ivy-restrict-to-matches)
                      ("C-s-r"      . ivy-restrict-to-matches)
                      ("C-t C-r"    . ivy-restrict-to-matches)
                      ("C-t C-t"    . ivy-toggle-ignore)
                      ("<return>"   . ivy-alt-done)
                      ("C-<up>"     . ivy-previous-line-and-call)
                      ("C-<down>"   . ivy-next-line-and-call))
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
                (define-key ivy-minibuffer-map (kbd "C-s-g")
                  'minibuffer-keyboard-quit)

                )

(use-package    ivy-hydra
  :ensure       t
  :config       (define-key ivy-minibuffer-map (kbd "H-M-o") 'hydra-ivy/body)
                (define-key ivy-minibuffer-map (kbd "M-o") 'other-window))

(use-package    avy
  :ensure       t
  :custom       (avy-case-fold-search nil)
                (avy-keys '(?a ?s ?d ?f ?g ?j ?k ?l ?w ?e ?r ?i ?o ?p ?m)))

(use-package    magit
  :ensure       t
  :after        (ivy)
  :custom       (magit-completing-read-function 'ivy-completing-read)
                (magit-log-arguments '("--graph" "--color" "--decorate" "-n256"))
                (magit-log-arguments (quote ("--color" "--decorate" "-n256")))
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

(use-package    git-commit
  :preface      (defun me/git-commit-set-fill-column ()
                  (setq-local comment-auto-fill-only-comments nil)
                  (setq fill-column 72))
  :config       (advice-add 'git-commit-turn-on-auto-fill
                            :before #'me/git-commit-set-fill-column))

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

(use-package    magit-todos :disabled ;; prob slows down huge repos too much
  :ensure       t)

(use-package    swiper
  :ensure       t
  :custom       (counsel-grep-swiper-limit      120000)
  :bind         (:map swiper-map
                      ("C-s" . ivy-next-history-element))
  :config
  (defun swiper-all-buffer-p (buffer)
    "Return non-nil if BUFFER should be considered by `swiper-all'."
    (let ((mode (buffer-local-value 'major-mode (get-buffer buffer))))
      (cond
       ;; Ignore TAGS buffers, they tend to add duplicate results.
       ((eq mode #'tags-table-mode) nil)
       ;; Always consider dired buffers, even though they're not backed
       ;; by a file.
       ((eq mode #'dired-mode) t)
       ;; Always consider stash buffers too, as they may have
       ;; interesting content not present in any buffers. We don't #'
       ;; quote to satisfy the byte-compiler.
       ((eq mode 'magit-stash-mode) t)
       ;; Email buffers have no file, but are useful to search
       ((eq mode 'gnus-article-mode) t)
       ((eq mode 'term-mode) t)
       ;; Otherwise, only consider the file if it's backed by a file.
       (t (buffer-file-name buffer))))))

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
                (define-key counsel-find-file-map (kbd "H-r") 'counsel-up-directory)
                (counsel-mode 1)
  :custom       (counsel-rg-base-command
                 (concat "rg -i --no-heading --line-number --max-columns 120 "
                         "--max-count 200 --max-filesize 100M "
                         "--color never %s . 2>/dev/null"))
                ;; (counsel-ag-base-command
                ;;  "ag --nocolor --ignore build/ "
                ;;  "--ignore '*.cbproj' --ignore '*.launch' --nogroup %s")
                (counsel-ag-base-command
                 "ag --nocolor --nogroup %s")
                )

(use-package    auto-complete
  :ensure       t
  :custom       (ac-delay 0.4)
                (ac-auto-show-menu 0.4)
                (ac-use-fuzzy nil)
                (ac-menu-height 14)
                (ac-ignore-case nil)
  :bind         (:map ac-completing-map
                      ("M-j" . ac-next)
                      ("M-k" . ac-previous)
                      )
  :config       (ac-config-default)
                (global-auto-complete-mode t)
  )

(use-package    company
  :disabled     t ;; Company got terrible all of a sudden, no idea why
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
                (company-idle-delay 0.4)
                (company-minimum-prefix-length 2)
                (company-irony-ignore-case nil)
                (company-tooltip-idle-delay 1)
                (company-show-numbers t)
                (company-tooltip-limit 5)
  :config       (add-hook 'after-init-hook 'global-company-mode)
                ;; silly hack to make indent/complete functionality work properly
                (defvar completion-at-point-functions-saved nil)
                (defun company-indent-for-tab-command (&optional arg)
                  (interactive "P")
                  (let ((completion-at-point-functions-saved completion-at-point-functions)
                        (completion-at-point-functions '(company-complete-common-wrapper)))
                    (indent-for-tab-command arg)))
                (defun company-complete-common-wrapper ()
                  (let ((completion-at-point-functions completion-at-point-functions-saved))
                    (company-complete-common)))
                (define-key company-active-map (kbd "M-j") 'company-select-next)
                (define-key company-active-map (kbd "M-k") 'company-select-previous)
                (define-key company-active-map (kbd "C-j") nil)
                (define-key company-active-map (kbd "C-k") nil)
                (define-key company-active-map (kbd "RET") 'nil)
                (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
                (define-key company-mode-map [remap indent-for-tab-command]
                  'company-indent-for-tab-command)
                (define-key company-active-map (kbd "C-1") (lambi (company-complete-number 1)))
                (define-key company-active-map (kbd "C-2") (lambi (company-complete-number 2)))
                (define-key company-active-map (kbd "C-3") (lambi (company-complete-number 3)))
                (define-key company-active-map (kbd "C-4") (lambi (company-complete-number 4)))
                (define-key company-active-map (kbd "C-5") (lambi (company-complete-number 5)))
                (define-key company-active-map (kbd "C-6") (lambi (company-complete-number 6)))
                (define-key company-active-map (kbd "C-7") (lambi (company-complete-number 7)))
                (define-key company-active-map (kbd "C-8") (lambi (company-complete-number 8)))
                (define-key company-active-map (kbd "C-9") (lambi (company-complete-number 9)))
                (define-key company-active-map (kbd "C-0") (lambi (company-complete-number 10))
                  ))


(use-package    asm-mode
  :config       (define-key asm-mode-map (kbd "C-j") nil))

(use-package    cmake-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode)))

(use-package    company-jedi
  :ensure       t
  :config       (add-hook 'python-mode-hook
                  (lambi (add-to-list 'company-backends 'company-jedi))))

(use-package    edit-server :disabled ;; super duper buggy
  :ensure       t
  :config       (edit-server-start))

(use-package    switch-buffer-functions
  :ensure       t)

(use-package    autorevert
  :custom       (auto-revert-verbose                 nil)
                (global-auto-revert-non-file-buffers   t)
  :config       (global-auto-revert-mode))

(use-package    auto-dim-other-buffers
  :disabled t
  :ensure       t
  :custom       (auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
  :config       (add-hook 'after-init-hook (lambda ()
                                             (when (fboundp 'auto-dim-other-buffers-mode)
                                               (auto-dim-other-buffers-mode t))))
                (add-hook 'focus-in-hook 'adob--focus-change)
                (add-hook 'focus-out-hook 'adob--focus-change)
                (custom-set-faces
                 '(auto-dim-other-buffers-face ((t (:background "#c7c7c7"))))))

(use-package    volatile-highlights
  :ensure       t
  :config       (volatile-highlights-mode 1))

;; todo -- I forgot how to use this thing effectively
(use-package    wgrep
  :ensure       t
  :custom       (wgrep-auto-save-buffer t))

(use-package    grep
  :custom       (grep-command "grep --color -nHZ ")
                (grep-use-null-device nil)
  :bind         (:map grep-mode-map
                      ("j"   . compilation-next-error)
                      ("k"   . compilation-previous-error)))

(use-package    recentf
  :custom       (recentf-max-saved-items 5000)
  :config       (recentf-mode 1))

(use-package    whitespace
  :custom       (whitespace-style '(face empty lines-tail trailing)))

(use-package    hl-line
  :ensure       nil
  :custom       (hl-line-sticky-flag nil)
  :config       (global-hl-line-mode -1))

(use-package    helm-gtags
  :ensure       t
  :custom       (helm-gtags-auto-update         t)
                (helm-gtags-use-input-at-cursor t)
  :config       (setenv "GTAGSLIBPATH" "~/.gtags") ;; todo bad
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
  :custom       (flycheck-pos-tip-timeout 5)
  :config       (with-eval-after-load 'flycheck (flycheck-pos-tip-mode)))

(use-package    irony
  :ensure       t
)

(use-package    flycheck-irony
  :ensure       t
  :after        (flycheck irony)
  :config       (eval-after-load 'flycheck
                  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package    dts-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.dts$" . dts-mode))
                (add-to-list 'auto-mode-alist '("\\.dtsi$" . dts-mode))
                (add-to-list 'auto-mode-alist '("\\.dto$" . dts-mode))
                (add-to-list 'auto-mode-alist '("\\.overlay$" . dts-mode))
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

(use-package    linum   :disabled
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
                   ))
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
  :bind         (:map org-mode-map
                      ("C-a"        . nil)
                      ("C-e"        . nil)
                      ;; ("C-S-a"      . nil)
                      ;; ("C-S-e"      . nil)
                      ("M-a"        . nil)
                      ("M-e"        . nil)
                      ("s-a"      . outline-previous-visible-heading)
                      ("s-e"      . outline-next-visible-heading)
                      ("M-RET"      . nil)
                      ;; ("<C-tab>"    . nil)
                      ("M-s M-d"    . nil)
                      ("C-j"        . next-line)
                      ("C-k"        . previous-line)))

(use-package    org-capture
  :after        (org)
  :custom       (org-default-notes-file nil)
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
  :config       (setq markdown-mode-hook nil)(add-hook 'markdown-mode-hook 'fci-mode)
                (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
                (add-hook 'markdown-mode-hook 'flyspell-mode)
                (add-hook 'markdown-mode-hook
                          (lambda ()
                            (progn (setq left-margin-width 2)
                                   (set-window-buffer (get-buffer-window) (current-buffer)))))
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

(use-package    frame
  :config       (window-divider-mode t)
                (custom-set-faces
                 '(window-divider ((t (:foreground "#707070")))))
  :custom       (window-divider-default-bottom-width 1)
                (window-divider-default-right-width 1)
                (window-divider-default-places 'bottom-only))

(use-package    yasnippet
  :ensure       t
  :config       (yas-global-mode 1))

(use-package    semantic/bovine/c
;; fixme -- is this needed/desirable:
  :config       (add-to-list 'semantic-lex-c-preprocessor-symbol-file
                             "/home/benjamin/bin/gcc-arm-none-eabi-7-2018-q2-update/lib/gcc/arm-none-eabi/7.3.1/include/stddef.h")
                (add-to-list
                 'semantic-lex-c-preprocessor-symbol-map
                 '("__deprecated" . "")
                 '("__syscall" . "")))

(use-package    semantic
  :custom       (semantic-idle-scheduler-idle-time 5)
                (semanticdb-default-save-directory "~/.semanticdb")
  :config       (semantic-mode 1)
                (global-semantic-idle-scheduler-mode t)
                (add-to-list 'semantic-default-submodes
                             'global-semantic-idle-scheduler-mode)
                (add-to-list 'semantic-default-submodes
                             'global-semanticdb-minor-mode)
                (semantic-add-system-include "/usr/lib/python3" 'python-mode)
                (semantic-add-system-include "/usr/lib/python3.9" 'python-mode)
                (semantic-add-system-include "/usr/lib/python3.10" 'python-mode)
                (semantic-add-system-include "/usr/lib/python2.7" 'python-mode))

(defun c-occur-overview ()
  "Grep for definitions/declarations etc, in C."
  (interactive)
  (let ((list-matching-lines-face nil))
    (occur "^[a-z\\_].*"))
  (hydra-errgo/body)
  )

(use-package    company-irony              :ensure t)
(use-package    company-irony-c-headers    :ensure t)

(use-package    cc-mode
  :after        (semantic)
  :custom       (c-default-style        "linux")
                (c-basic-offset         8)
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
                      ;; ("C-i"       . company-indent-for-tab-command)
                      ))
  ;; :init         (semanticdb-enable-gnu-global-databases 'c-mode)
                ;; (semanticdb-enable-gnu-global-databases 'c++-mode))

(use-package    pdf-tools
  :ensure       t
  :custom       (pdf-info-epdfinfo-program "/usr/bin/epdfinfo")
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
                (add-to-list 'auto-mode-alist '("\\.pdf" . pdf-view-mode))
                (add-hook 'pdf-view-mode-hook 'pdf-isearch-minor-mode))

(use-package    gud
  :custom       (gud-pdb-command-name "python -m pdb")
  :config       (define-key gud-mode-map (kbd "M-c") 'hydra-gdb/body))

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
  :custom       (erc-autojoin-channels-alist '(("#emacs" "#zephyrproject")))
                (erc-nick "g00iekabl00ie"))

(use-package    hexl ;; FIXME: can be improved
  :bind         (:map hexl-mode-map
                      ("C-t" . nil)
                      ("C-j" . nil)
                      ("C-k" . nil)
                      ("M-o" . nil)
                      )
  :config       (add-to-list 'auto-mode-alist '("\\.hex$" . hexl-mode))
                (add-to-list 'auto-mode-alist '("\\.bin$" . hexl-mode))
                ;; (add-hook 'hexl-mode-hook (lambda () (auto-revert-mode -1)))
                (defun hexlify-buffer ()
                  "Super hacky fix to annoying prompts of hexl-mode auto-revert"
                  (interactive)
                  (setq buffer-undo-list nil)
                  ;; Don't decode text in the ASCII part of `hexl' program output.
                  (let ((coding-system-for-read 'raw-text)
                        (coding-system-for-write buffer-file-coding-system)
                        (buffer-undo-list t))
                    (apply 'call-process-region (point-min) (point-max)
                           (expand-file-name hexl-program exec-directory)
                           t t nil
                           ;; Manually encode the args, otherwise they're encoded using
                           ;; coding-system-for-write (i.e. buffer-file-coding-system) which
                           ;; may not be what we want (e.g. utf-16 on a non-utf-16 system).
                           (mapcar (lambda (s)
                                     (if (not (multibyte-string-p s)) s
                                       (encode-coding-string s locale-coding-system)))
                                   (split-string (hexl-options))))
                    (if (> (point) (hexl-address-to-marker hexl-max-address))
                        (hexl-goto-address hexl-max-address))))
                (defun hexl-revert-buffer-function (_ignore-auto _noconfirm)
                  (let ((coding-system-for-read 'no-conversion)
                        revert-buffer-function)
                    (revert-buffer nil t t)
                    (remove-hook 'change-major-mode-hook 'hexl-maybe-dehexlify-buffer t)
                    (setq major-mode 'fundamental-mode)
                    (hexl-mode)))
  )

(use-package    yaml-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(use-package    elf-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.elf$" . elf-mode)))

;; (use-package    face-remap
;;   :config        (defun set-boring-buffer-face ()
;;                    (interactive)
;;                    (setq buffer-face-mode-face
;;                          '(:background "gray" :foreground "black"))
;;                    (buffer-face-mode))
;;                 (add-hook 'help-mode-hook 'set-boring-buffer-face)
;;                 (add-hook 'Info-mode-hook 'set-boring-buffer-face))

(use-package    elec-pair
  :disabled     ;; just for the annoying << stuff
  :config       (electric-pair-mode 1))

(use-package    smartparens
  :ensure       t
  :config       (smartparens-global-mode 1))

(use-package    paren :disabled ;; kinda annoying tbh
  :custom       (show-paren-delay 0.1)
                (show-paren-highlight-openparen t)
                (show-paren-when-point-inside-paren nil)
  :config       (show-paren-mode 1))

(use-package    eldoc
  :custom       (eldoc-idle-delay 1)
  :config       (defun my-eldoc-display-message (format-string &rest args)
                  "Display eldoc message near point."
                  (when format-string
                    (pos-tip-show (apply 'format format-string args))))
                (setq eldoc-message-function #'my-eldoc-display-message)
                (global-eldoc-mode -1))

(use-package    visual-fill-column
  :ensure       t
  :custom       (eldoc-idle-delay 1)
  :config       (add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
                (add-hook 'visual-fill-column-mode #'visual-line-mode-hook))

;; (use-package    mu4e
;;   :disabled     t
;;   :custom       (mu4e-confirm-quit nil)
;;   :config       (add-hook 'mu4e-view-mode-hook #'visual-line-mode)
;;                 (add-hook 'mu4e-compose-mode-hook
;;                  (lambi (local-set-key (kbd "C-a") 'beginning-of-line-or-block))))

(use-package    slack
  ;; https://github.com/yuya373/emacs-slack
  :ensure       t
  )

;; ?????
(use-package    alert
  :ensure       t
  :commands     (alert)
  :init         (setq alert-default-style 'notifier))

(use-package iedit
  :ensure       t
  :bind (:map iedit-mode-keymap
              ("C-h" . nil)))

(use-package py-autopep8             :ensure t)
(use-package stickyfunc-enhance      :ensure t)
(use-package hydra                   :ensure t)
(use-package vimish-fold             :ensure t)
(use-package expand-region           :ensure t)
(use-package switch-buffer-functions :ensure t)
(use-package multiple-cursors        :ensure t)
(use-package hungry-delete           :ensure t)
(use-package move-text               :ensure t)
(use-package git-timemachine         :ensure t)
(use-package goto-chg                :ensure t)
(use-package function-args           :ensure t)
(use-package lispy                   :ensure t)
(use-package helm-chrome             :ensure t)
(use-package helm-google             :ensure t)
(use-package helm-projectile         :ensure t)
(use-package highlight               :ensure t)
(use-package fireplace               :ensure t)
(use-package flyspell-correct-ivy    :ensure t)
(use-package visual-regexp           :ensure t)
(use-package visual-fill-column      :disabled)
(use-package rainbow-delimiters      :disabled)


;;-- Some general hooks --------------------------------------------------------
(defadvice yank (after indent-yanked-stuff activate)
  "Indent region after yanking stuff. In programming mode."
  (when (derived-mode-p 'prog-mode)
    (exchange-point-and-mark)
    (call-interactively 'indent-region)
    (exchange-point-and-mark)))

(defadvice yank-pop (after indent-yanked-stuff activate)
  "Indent region after yanking stuff. In programming mode."
  (when (derived-mode-p 'prog-mode)
    (exchange-point-and-mark)
    (call-interactively 'indent-region)
    (exchange-point-and-mark)))

(defun benjamin/prog-mode-hook ()
  "My hook for 'prog-mode'."
  (hs-minor-mode 1)
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun benjamin/c-hook ()
  "Setup for C bla."
  (c-set-style "linux")
  (setq indent-tabs-mode t)
  (setq tab-width 8)
  (setq c-basic-offset 8)
  (setq c-tab-always-indent t)
  ;; (if (string-match-p "linux\\|uboot\\|u-boot\\|zephyr\\|kernel\\|voi\\|ez"
  ;;                     buffer-file-name)
  ;;     (progn (c-set-style "linux")
  ;;            (setq indent-tabs-mode t)
  ;;            (setq tab-width 8)
  ;;            (setq c-basic-offset 8)
  ;;            (setq c-tab-always-indent t))
  ;;   (progn (setq c-basic-offset 4)
  ;;          (setq c-tab-always-indent t)
  ;;          (c-set-style "user")))
  (c-set-offset 'substatement-open 0)
  (subword-mode 1)
  (flycheck-mode 1)
  (helm-gtags-mode 1)
  (fci-mode -1)         ;; destroys company
  (whitespace-mode 1)   ;; alternative to fci-mode
  (hide-ifdef-mode 1)   ;; FIXME: tune
  (irony-mode 1)
  (company-mode -1)
  (auto-complete-mode 1)
  (semantic-mode -1)
  (local-set-key (kbd "M-.") 'helm-gtags-dwim)
  (setenv "GTAGSLIBPATH" "/home/benjamin/.gtags/"))

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun make-cap-file-read-only ()
  "Check if file has .cap ending, make it read-only if so."
  (if
      (string= "cap" (file-name-extension buffer-file-name))
      (progn (read-only-mode 1)
             (display-line-numbers-mode 1)
             (message "read-only-mode activated"))))

(use-package    tty-format
  :ensure       nil
  :config       (defun display-ansi-colors ()
                  (interactive)
                  (format-decode-buffer 'ansi-colors)
                  (remove-dos-eol)
                  (make-cap-file-read-only)
                  )
                ;; (add-to-list 'auto-mode-alist '("\\.log\\'" . display-ansi-colors))
                ;; (add-to-list 'auto-mode-alist '("\\.cap\\'" . display-ansi-colors))
)

(use-package    tabbar
  :ensure       t)

(use-package    csharp-mode
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'occur-hook       'occur-rename-buffer)
(add-hook 'prog-mode-hook   'benjamin/prog-mode-hook)
(add-hook 'c-mode-hook      'benjamin/c-hook)
(add-hook 'c++-mode-hook    'benjamin/c-hook)

;;-- Random general stuff ------------------------------------------------------

;; See bin/E for explanation :P
(defvar emacs-pager-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q") 'server-edit)
    map)
  "Keymap for `emacs-pager-mode'.")

(define-minor-mode emacs-pager-mode
  "Helper mode for using emacs as pager."
  :require 'benjamin/emacs-pager
  :keymap emacs-pager-mode-map
  (if emacs-pager-mode
      ;; Activation:
      (progn
        (format-decode-buffer 'ansi-colors)
        (read-only-mode 1)
        (toggle-frame-fullscreen))
    )
  )
(add-to-list 'auto-mode-alist '("\\.emacs-pager\\'" . emacs-pager-mode))


(setq-default
 fill-column                            80
 truncate-lines                         nil
 tab-width                              4
 cursor-type                            t
 ;; cursor-type                           'hollow
 indent-tabs-mode                       nil
 truncate-lines                         t
 left-margin-width                      1
 )

(desktop-save-mode -1)
(savehist-mode 1)

(setq
 truncate-lines                         t
 right-fringe-width                     0
 truncate-lines                         nil
 split-width-threshold                  300
 frame-inhibit-implied-resize           t
 max-mini-window-height                 0.3
 enable-recursive-minibuffers           nil
 ;; enable-recursive-minibuffers           t
 cursor-type                            t
 ;; cursor-type                            'hollow
 explicit-shell-file-name               "/bin/bash"
 indent-tabs-mode                       nil
 auto-hscroll-mode                      nil
 mouse-autoselect-window                nil
 shift-select-mode                      nil
 echo-keystrokes                        0.1
 bookmark-save-flag                     1
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
 x-stretch-cursor                       t
 scroll-margin                          6
 scroll-conservatively                  100
 kill-buffer-query-functions
 (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(ansi-color-for-comint-mode-on)
(fset 'yes-or-no-p            'y-or-n-p)
(put 'scroll-left             'disabled nil)
(set-language-environment     "UTF-8")
(set-default-coding-systems   'utf-8)
(menu-bar-mode                -1)
(tool-bar-mode                -1)
(scroll-bar-mode              -1)
(delete-selection-mode         1)
(auto-compression-mode         1)
(fringe-mode -1)

(add-to-list 'auto-mode-alist '("defconfig$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.conf$"   . conf-mode))
(add-to-list 'auto-mode-alist '("\\.sch$"    . text-mode))
(add-to-list 'auto-mode-alist '("\\.scr$"    . sh-mode))
(add-to-list 'auto-mode-alist '("rc$"        . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash"    . sh-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-dim-other-buffers-face ((t (:background "#232326"))))
 '(font-lock-variable-name-face ((t (:foreground "dark blue"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :foreground "dark green" :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :foreground "saddle brown" :height 1.2))))
 '(whitespace-line ((t (:background "dark gray"))))
 '(whitespace-trailing ((t (:foreground "yellow" :weight bold))))
 '(window-divider ((t (:foreground "#707070")))))


;; Open some defaults
(load        "~/.emacs.d/bindings2.el")
(find-file    "~/.emacs.d/bindings2.el")
(find-file    "~/.emacs.d/init.el")
(condition-case nil (kill-buffer "*scratch*") (error nil))


;;--- super todo ----
;; (defadvice select-frame (after highlight-focus activate)
;;   (highlight-focus:check))

;(load-file "./focus-stuff.el")

(setq company-backends
      (quote
       (company-clang company-cmake company-capf company-files
                      (company-dabbrev-code company-gtags company-etags company-keywords)
                      company-oddmuse company-dabbrev)))

(load-file "./lisp/defuns.el")

(provide 'init)
;;; init.el ends here

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/work/agenda.org") nil nil "Customized with use-package org")
 '(package-selected-packages
   '(lsp-ui ccls eglot lsp-treemacs lsp-mode scad-mode eproject intel-hex-mode auto-complete-config auto-complete elpy helm-projectile auto-dim-other-buffers yasnippet yaml-mode wgrep volatile-highlights visual-regexp visual-fill-column vimish-fold use-package undo-tree term-projectile tabbar switch-buffer-functions stickyfunc-enhance smex smartparens slack realgud pyenv-mode py-autopep8 pdf-tools multiple-cursors multi-term move-text markdown-mode magit lispy ivy-rich ivy-hydra hungry-delete highlight helm-systemd helm-gtags helm-google helm-chrome goto-chg git-timemachine git-gutter+ function-args flyspell-correct-ivy flycheck-pos-tip flycheck-irony fireplace fill-column-indicator expand-region elf-mode dts-mode csharp-mode counsel-projectile company-jedi company-irony-c-headers company-irony cmake-mode bitbake anaconda-mode))
 '(safe-local-variable-values
   '((projectile-project-root . "~/work/duke/")
     (projectile-project-root . "/home/benjamin/work/ppuck")
     (projectile-project-root . "/home/benjamin/work/duke")
     (projectile-project-root . "/home/benjamin/work/aquarobur")
     (projectile-project-root . "/home/benjamin/notes/blippa/west")
     (projectile-project-root . "/home/benjamin/work/ez")
     (projectile-project-root . "/home/benjamin/work/voi")
     (projectile-project-root . "~/work/careofsweden")
     (projectile-project-root . "/home/benjamin/work/sandvik"))))
