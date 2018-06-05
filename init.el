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
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(load-file "~/.emacs.d/ample-theme/ample-light-theme.el")
(package-initialize)
(if (not (fboundp 'use-package))
    (progn (package-refresh-contents) (package-install 'use-package)))
;; -- end of formalities -------------------------------------------------------

(setq custom-file "~/.emacs.d/customizations.el")
(load-file custom-file)

(defmacro csetq (variable value)
  "Macro stolen from abo-abo, custom set VARIABLE to VALUE etc."
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))

(defmacro lambi (&rest b)
  "B lazy yo."
  `(lambda () (interactive),@b))


; -- my own stuff (mostly) -----------------------------------------------------
(use-package    kill-at-point)
(use-package    ivy-addons)
(use-package    some-defuns)
(use-package    some-hydras)
(use-package    pdf-custom)
(use-package    zoom-frm)
(use-package    company-flyspell) ;; raw download

(use-package    term-addons
  :config       (add-hook 'sh-mode-hook 'benjamin/sh-hook))

(use-package    counsel-term
  :custom       (counsel-term-ff-initial-input          "")
                (counsel-term-history-initial-input     "")
  :load-path    "~/repos/counsel-term")

(use-package    ample-light-theme  ;; forked
  :ensure       nil
  :after        (feebleline)
  :config       (ample-light-theme)
  :load-path    "~/.emacs.d/ample-theme")

(use-package    feebleline
  :load-path    "~/repos/feebleline"
  :after        (esh-ext)
  :ensure       nil
  :custom       (feebleline-show-git-branch             t)
                (feebleline-show-dir                    t)
                (feebleline-show-time                   nil)
                (feebleline-show-previous-buffer        nil)
  :config       (feebleline-mode 1))


; -- others stuff --------------------------------------------------------------
(use-package    gdscript-mode
  :disabled
  :ensure       t
  :load-path    "~/repos/gdscript-mode")

(use-package    undo-tree
  :config       (global-undo-tree-mode 1)
  :bind         (:map undo-tree-map ("C-x r" . nil)
                                    ("C-_"   . nil)))

(use-package    multi-term
  :bind
  (:map term-raw-map
     ("C-g"     . (lambda () (interactive) (term-send-raw-string "")))
     ("H-w"     . counsel-term-ff)
     ("H-c"     . counsel-term-cd)
     ("M-r"     . counsel-term-history)
     ("H-f"     . avy-goto-word-or-subword-1)
     ("H-k"     . (lambda () (interactive) (term-send-raw-string "")))
     ("C-d"     . term-send-raw)
     ("C-p"     . projectile-command-map)
     ("C-j"     . next-line)
     ("C-k"     . previous-line)
     ("C-l"     . forward-char)
     ("C-h"     . backward-char)
     ("C-j"     . next-line)
     ("C-k"     . previous-line)
     ("C-n"     . term-downdir)
     ("C-S-n"   . term-updir)
     ("C-s"     . swiper)
     ("C-t"     . nil)
     ("C-r"     . term-send-backspace)
     ("<f9>"    . term-send-backspace) ; == [
     ("C-m"     . term-send-return)
     ("C-y"     . term-paste)
     ("H-i"     . term-paste)
     ("C-q"     . backward-word)
     ("M-q"     . term-send-backward-word)
     ("M-f"     . term-send-forward-word)
     ("M-p"     . term-send-up)
     ("M-n"     . term-send-down)
     ("M-d"     . term-send-delete-word)
     ("M-,"     . term-send-raw)
     ("H-M-f"   . (lambda () (interactive)
                    (term-send-raw-string " fuck")
                    (sleep-for 0.2) (term-send-raw-string "")))
     ("C-c C-c" . term-interrupt-subjob)
     ("C-c C-e" . term-send-esc)
     ("C-c C-z" . (lambda () (interactive) (term-send-raw-string "")))
     ("C-c C-x" . (lambda () (interactive) (term-send-raw-string "")))
     ("H-M-u"   . (lambda () (interactive)
                    (term-send-raw-string "sudo ")))
     ("C-c C-l" . (lambda () (interactive) (term-send-raw-string "")))
     ("<C-backspace>" . term-send-backward-kill-word)
     ("<C-return>"    . term-cd-input))
  (:map term-mode-map
        ("C-p"   . nil)
        ("C-x t" . term-toggle-mode-w/warning))
  :ensure       t
  :custom       (multi-term-program     "/bin/bash")
                (term-prompt-regexp     "^$\\ ")
                (multi-term-switch-after-close nil)
                (term-buffer-maximum-size 16384))

(use-package    ace-window
  :disabled     t
  :ensure       t)

(use-package    hideshow
  :config       (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package    fancy-narrow
  ;; unusable with jit-lock-stealth-fontify it seems
  :disabled     t
  :config       (defun fancy-narrow-dwim ()
                  (interactive)
                  (if fancy-narrow--beginning
                      (fancy-widen)
                    (unless (region-active-p)
                      (mark-paragraph -1))
                    (call-interactively 'fancy-narrow-to-region)))
  :ensure       t)

(use-package    fill-column-indicator
  ;; really glitchy but sometimes so nice to have
  :ensure       t
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
              ("t"      . projectile-get-term)
              ("T"      . projectile-test-project)
              ("u"      . projectile-run-project)
              ("r"      . counsel-projectile-rg)
              ("o"      . projectile-find-other-file)
              ("e"      . projectile-recentf)
              ("j"      . projectile-find-tag)
              ("O"      . projectile-find-other-file-other-window)
              ("p"      . counsel-projectile)
              ("C-p"    . counsel-projectile)
              ("s"      . counsel-projectile-switch-project)
              ("d"      . counsel-projectile-find-dir)
              ("g"      . counsel-projectile-git-grep)
              ("q"      . projectile-replace)
              ("c"      . projectile-compile-project)
              ("C-f"    . projectile-find-file-in-known-projects)
              ("A"      . projectile-run-async-shell-command-in-root)))

(use-package    counsel-projectile
  :ensure       t
  :config
  (defun counsel-projectile-switch-project-action-run-term (project)
    "Overridden!"
    (let ((projectile-switch-project-action
           (lambda () (projectile-get-term))))
      (counsel-projectile-switch-project-by-name project)))
  :custom
  ;; set the default switch-project-action index to that of run-term (18)
  ;; todo: just make it a key binding
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

(use-package    helm
  :ensure       t
  :config
  (defun helm-display-mode-line (source &optional force) "")
  (defun helm-toggle-header-line ()
    (if (= (length helm-sources) 1)
        (set-face-attribute 'helm-source-header nil :height 0.1)
      (set-face-attribute 'helm-source-header nil :height 1.0)))
  (add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)
  (defun benjamin/helm-buffers-list () (interactive)
         (unless helm-source-buffers-list
           (setq helm-source-buffers-list
                 (helm-make-source "Buffers" 'helm-source-buffers)))
         (let ((helm-split-window-default-side 'right)
               (helm-display-buffer-default-width 38)
               (helm-display-header-line nil))
           (helm :sources              '(helm-source-buffers-list)
                 :buffer               "*helm buffers*"
                 :keymap               helm-buffer-map
                 :input                "\!\\* "
                 :truncate-lines       helm-buffers-truncate-lines)))
  (defun benjamin/helm-buffers-persistent-kill (_buffer)
    (let ((marked (helm-marked-candidates)))
      (unwind-protect
          (cl-loop for b in marked
                   do
                   (progn (helm-preselect
                           (format "^%s"
                                   (helm-buffers--quote-truncated-buffer b)))
                          (helm-buffers-persistent-kill-1 b)
                          (message nil)
                          (helm--remove-marked-and-update-mode-line b)))
        (with-helm-buffer
          (setq helm-marked-candidates nil
                helm-visible-mark-overlays nil))
        (helm-force-update (helm-buffers--quote-truncated-buffer
                            (helm-get-selection))))))
  (defun benjamin/helm-kill-buffer () (interactive)
         (with-helm-alive-p
           (helm-attrset 'kill-action
                         '(benjamin/helm-buffers-persistent-kill . never-split))
           (helm-execute-persistent-action 'kill-action)))
  (defun helm-backspace () (interactive)
         (condition-case nil (backward-delete-char 1)
           (error (helm-keyboard-quit))))
  (put 'benjamin/helm-kill-buffer 'helm-only t)
  (define-key helm-map (kbd "M-k")   'benjamin/helm-kill-buffer)
  (define-key helm-map (kbd "C-j")   'helm-next-line)
  (define-key helm-map (kbd "C-k")   'helm-previous-line)
  (define-key helm-map (kbd "C-S-j") 'helm-follow-action-forward)
  (define-key helm-map (kbd "C-S-k") 'helm-follow-action-backward)
  (define-key helm-map (kbd "<f9>")  'helm-backspace)
  :custom       (helm-mode-line-string ""))

(use-package    ivy-rich
  :disabled     t
  :ensure       t)

(use-package    bookmark
  :defer        t
  :config       (setq bookmark-save-flag 1))

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
                (ivy-ignore-buffers             '("\\` "))
                (add-to-list 'ivy-ignore-buffers "\\*Flycheck")
                (add-to-list 'ivy-ignore-buffers "\\*CEDET")
                (add-to-list 'ivy-ignore-buffers "\\*BACK")
                (add-to-list 'ivy-ignore-buffers "\\*Help\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Messages\\*")
                (add-to-list 'ivy-ignore-buffers "\\*Compile-Log\\*")
                (add-to-list 'ivy-ignore-buffers "\\*helm")
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
                (setq ivy-virtual-abbreviate 'name)
                (define-key ivy-occur-grep-mode-map
                  (kbd "C-c w") 'ivy-wgrep-change-to-wgrep-mode)
                (define-key ivy-switch-buffer-map (kbd "M-o") nil)
                (ivy-set-display-transformer
                 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
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
  :custom       (magit-completing-read-function 'ivy-completing-read))

(use-package    swiper
  :ensure       t
  )

(use-package    counsel
  :ensure       t
  :config       (define-key counsel-mode-map (kbd "H-f") nil)
  :custom       (counsel-grep-swiper-limit      120000)
                (define-key counsel-find-file-map
                  (kbd "H-r") 'counsel-up-directory)
                (counsel-rg-base-command
                 (concat "rg -i --no-heading --line-number --max-columns 120 "
                         "--max-count 200 --max-filesize 100M "
                         "--color never %s . 2>/dev/null")))

(use-package	company
  :ensure       t
  :custom       (company-auto-complete-chars '(?. ?>))    ;; ???
                (company-backends
                 '(company-semantic company-clang company-cmake
                                    company-capf company-files
                                    (company-dabbrev-code
                                     company-gtags company-etags
                                     company-keywords)
                                    company-oddmuse company-dabbrev))
                (company-idle-delay 0.5)
                (company-minimum-prefix-length 3)
                (company-tooltip-idle-delay 1)
                (company-show-numbers t)
                (company-tooltip-limit 10)
  :config       (counsel-mode 1)
                (add-hook 'after-init-hook 'global-company-mode)
                (define-key company-active-map (kbd ";") 'company-complete-selection)
                (define-key company-active-map (kbd "\"") 'company-select-next)
                (define-key company-active-map (kbd "C-n") 'company-select-next)
                (define-key company-active-map (kbd "C-p") 'company-select-previous)
  ;; abo-abo awesome company use-digit hack below
  (let ((map company-active-map))
    (mapc
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
        (company-complete-number (string-to-number k))))))

(use-package    edit-server
  :ensure       t
  :config       (edit-server-start))

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
  :custom       (wgrep-auto-save-buffer t)
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
                (setenv "GTAGSLIBPATH" "~/.gtags") ;; todo bad
  :hook         (prog-mode-hook . helm-gtags-mode))

(use-package    flycheck
  :custom       (flycheck-check-syntax-automatically '(mode-enabled idle-change save))
                (flycheck-idle-change-delay 0.5)
                (flycheck-display-errors-delay 0.2)
  :config       (add-hook 'after-init-hook 'global-flycheck-mode)
                (define-key flycheck-mode-map
                  (kbd "C-x f") 'benjamin/flycheck-list-errors))

(use-package    flycheck-pos-tip
  :ensure       t
  :after        (flycheck)
  :custom       (flycheck-pos-tip-timeout 20)
  :config       (with-eval-after-load 'flycheck
                  (flycheck-pos-tip-mode)))

(use-package    irony
  :ensure       t
  :config       (defun my-irony-mode-hook ()
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
  :ensure       nil
  :config       (add-to-list 'auto-mode-alist '("\\.dts$" . dts-mode))
                (add-hook 'dts-mode-hook 'subword-mode)
                (add-hook 'dts-mode-hook 'helm-gtags-mode))

(use-package    bitbake
  :ensure       t
  :config       (add-to-list 'auto-mode-alist '("\\.bb$" . bitbake-mode))
                (add-to-list 'auto-mode-alist '("\\.bbappend$" . bitbake-mode))
                (add-hook 'bitbake-mode-hook 'subword-mode)
                (add-hook 'bitbake-mode-hook 'helm-gtags-mode))

(use-package    linum
  :ensure       nil
  :custom       (global-linum-mode nil))

(use-package    flyspell
  :custom       (flyspell-issue-message-flag nil)
                (flyspell-issue-welcome-flag nil))

(use-package    flyspell-correct-ivy
  :ensure       t)

(use-package    org
  :custom       (org-hide-leading-stars t)
                (org-agenda-files '("~/work/agenda.org"))
  :config       (add-hook 'org-mode-hook 'turn-on-auto-fill)
                (add-hook 'org-mode-hook (lambda () (flyspell-mode +1)))
                (add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
                (define-key org-mode-map (kbd "C-o")
                  (lambi (beginning-of-line) (newline)
                         (forward-line -1)))
  :bind         (:map org-mode-map
                      ("C-a"        . nil)
                      ("C-e"        . nil)
                      ("M-a"        . nil)
                      ("M-e"        . nil)
                      ("σ"          . company-flyspell)
                      ("C-;"        . flyspell-correct-word-before-point)
                      ("M-<f11>"    . flyspell-correct-word-before-point)
                      ("C-S-a"      . outline-previous-visible-heading)
                      ("C-S-e"      . outline-next-visible-heading)
                      ("C-j"        . next-line)
                      ("C-k"        . previous-line)))

(use-package    markdown-mode
  :config       (add-hook 'markdown-mode-hook 'fci-mode)
                (add-hook 'markdown-mode-hook 'turn-on-auto-fill))

(use-package    git-gutter+
  :ensure       t
  :config       (global-git-gutter+-mode))
                ;; (fringe-mode 0))

(use-package    goto-last-change
  :disabled     t  ;; deprecated for goto-chg
  :ensure       t)

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

(use-package    helm-pydoc
  :disabled     t   ;; bugs out outside venv
  :ensure       t
  :config       (with-eval-after-load "python-mode"
                  (define-key python-mode-map (kbd "C-c d") 'helm-pydoc)))

(use-package    elpy
  :ensure       t
  :custom       (elpy-rpc-backend "jedi")
                (python-indent-guess-indent-offset t)
                (python-shell-interpreter "ipython")
                (python-shell-interpreter-args "-i --simple-prompt")
                (python-indent-guess-indent-offset-verbose nil)
                (python-skeleton-autoinsert t)
  :config       (remove-hook 'elpy-modules 'elpy-module-flymake)
                (add-to-list 'elpy-modules 'flycheck-mode)
                (semantic-add-system-include "/usr/lib/python3.6" 'python-mode)
                (semantic-add-system-include "/usr/lib/python2.7" 'python-mode)
                (elpy-enable)
                (add-hook 'python-mode-hook
                          (lambi (setq flycheck-checker 'python-flake8))))

(use-package    jedi
  :ensure       t
  :init         (add-hook 'python-mode-hook 'jedi:setup)
                (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package    company-jedi
  :ensure       t
  :after        (company jedi))

(use-package    frame
  :config       (window-divider-mode t)
  :custom       (window-divider-default-bottom-width 1)
                (window-divider-default-places 'bottom-only))

(use-package    yasnippet
  :ensure       t
  :config       (yas-global-mode 1))

(use-package    semantic
  :config       (semantic-mode 1)
                (defun my-inhibit-semantic-p ()
                  (not (equal major-mode 'org-mode)))
                (with-eval-after-load 'semantic
                  (add-to-list 'semantic-inhibit-functions #'my-inhibit-semantic-p))
                (global-semantic-idle-scheduler-mode t)
                (add-to-list 'semantic-default-submodes
                             'global-semantic-idle-scheduler-mode)
                (add-to-list 'semantic-default-submodes
                             'global-semanticdb-minor-mode))

(use-package    cc-mode
  :after        (semantic)
  :custom       (c-default-style        "linux")
                (c-basic-offset         8)
  :bind         (:map c-mode-base-map
                      ("M-q"    . nil)
                      ("M-e"    . nil)
                      ("M-a"    . nil)
                      ("M-j"    . nil)
                      ("C-M-a"  . nil)
                      ("C-M-e"  . nil)
                      ("C-M-j"  . nil)
                      ("C-M-k"  . nil)
                      ("C-c o"  . c-occur-overview)
                      ("M-c"    . hydra-gdb/body)       ;; todo
                      ("C-i"    . indent-or-complete))
  :config       (semanticdb-enable-gnu-global-databases 'c-mode)
                (semanticdb-enable-gnu-global-databases 'c++-mode)
                (use-package semantic/bovine/c)
                (add-to-list 'semantic-lex-c-preprocessor-symbol-file
                             "/usr/lib/clang/5.0.0/include/stddef.h")
                (defun c-occur-overview () (interactive)
                       (let ((list-matching-lines-face nil))
                         (occur "^[a-z].*("))
                       (enlarge-window 25)
                       (hydra-errgo/body))
                (defun benjamin/c-hook ()
                  (subword-mode 1)
                  (flycheck-mode 1)
                  (helm-gtags-mode 1)
                  (fci-mode -1) ;; destroys company
                  (irony-mode 1)
                  (company-mode 1)
                  (semantic-mode 1)
                  (semantic-stickyfunc-mode -1)
                  (setenv "GTAGSLIBPATH" "/home/benjamin/.gtags/")
                  (when (boundp 'company-backends)
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
                            )))))
                (add-hook 'c-mode-hook 'benjamin/c-hook)
                (add-hook 'c++-mode-hook 'benjamin/c-hook)
)

(use-package    pdf-tools
  :ensure       t
  :config       (with-eval-after-load 'pdf-view
                  (progn (define-key pdf-view-mode-map
                           (kbd "M-g g") 'pdf-view-goto-page)
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

(use-package    realgud
  :ensure       t
  :custom       (realgud:pdb-command-name "python -m pdb")
  :config       (defun realgud:eval-dotsymbol-at-point ()
                  "The eval-at-point stuff included in realgud are baaad."
                  (interactive)
                  (with-syntax-table (make-syntax-table (syntax-table))
                    (modify-syntax-entry ?. "_")
                    (let ((bounds (bounds-of-thing-at-point 'symbol)))
                      (realgud:cmd-eval-region (car bounds) (cdr bounds)))))
  :bind         (:map realgud:shortkey-mode-map
                      ("J" . realgud:cmd-jump)
                      ("K" . realgud:cmd-kill)
                      ("j" . next-line)
                      ("p" . realgud:eval-dotsymbol-at-point)
                      ("k" . previous-line)))

(use-package    make-mode
  :config       (add-hook 'makefile-mode-hook 'indent-tabs-mode))

(use-package    py-autopep8             :ensure t)
(use-package    stickyfunc-enhance      :ensure t)
(use-package    hydra                   :ensure t)
(use-package    vimish-fold             :ensure t)
(use-package    expand-region           :ensure t)
(use-package    switch-buffer-functions :ensure t)
(use-package    multiple-cursors        :ensure t)
(use-package    hungry-delete           :ensure t)
(use-package    iedit                   :ensure t)
(use-package    move-text               :ensure t)
(use-package    git-timemachine         :ensure t)
(use-package    ace-jump-buffer         :ensure t)      ;; meh
(use-package    goto-chg                :ensure t)
(use-package    function-args           :ensure nil)
(use-package    lispy                   :ensure t)
(use-package    helm-chrome             :ensure t)
(use-package    helm-google             :ensure t)
(use-package    highlight               :ensure t)


;;-- Random general stuff ------------------------------------------------------
(menu-bar-mode      -1)
(tool-bar-mode      -1)
(toggle-scroll-bar  -1)

(csetq enable-recursive-minibuffers nil)
(customize-set-variable 'tab-width 4)
(csetq tab-always-indent t)
(csetq indent-tabs-mode nil)
(csetq auto-hscroll-mode nil)

(setq mouse-autoselect-window           t
      shift-select-mode                 nil
      echo-keystrokes                   0.1
      scroll-margin                     2
      scroll-preserve-screen-position   nil
      scroll-error-top-bottom           t
      fill-column                       80
      sentence-end-double-space         nil
      inhibit-splash-screen             t
      initial-major-mode                'org-mode
      gc-cons-threshold                 20000000)

(setq backup-by-copying                 t
      delete-old-versions               t
      kept-new-versions                 10
      kept-old-versions                 5
      delete-by-moving-to-trash         t
      version-control                   t
      auto-save-file-name-transforms    `((".*" ,temporary-file-directory t))
      backup-directory-alist            '(("."  . "~/.saves")))

(setq save-interprogram-paste-before-kill   t
      select-enable-clipboard               t)

(setq kill-buffer-query-functions
      (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(fset 'yes-or-no-p  'y-or-n-p)

(delete-selection-mode 1)
(electric-pair-mode 1)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(auto-compression-mode t)
(ansi-color-for-comint-mode-on)

(put 'scroll-left 'disabled nil)

(add-to-list 'auto-mode-alist '("defconfig$"    . conf-mode))
(add-to-list 'auto-mode-alist '("\\.conf$"      . conf-mode))
(add-to-list 'auto-mode-alist '("\\.scr$"       . sh-mode))
(add-to-list 'auto-mode-alist '("\\.sch$"       . text-mode))

(add-hook 'before-save-hook     'delete-trailing-whitespace)
(add-hook 'find-file-hook       'find-file-root-header-warning)
(add-hook 'occur-hook           'occur-rename-buffer)
(add-hook 'prog-mode-hook
          (lambi
           (set (make-local-variable 'comment-auto-fill-only-comments) t)
           (local-set-key (kbd "RET") 'newline-and-indent)))

;; Open some defaults
(find-file "~/.emacs.d/bindings2.el")
(find-file "~/.emacs.d/init.el")

(load "~/.emacs.d/face-by-mode.el")             ;; useless
(load "~/.emacs.d/gdb-custom.el")               ;; really in need of revision
(load "~/.emacs.d/git-custom.el")               ;; really in need of revision
(load "~/.emacs.d/ora-ediff.el")                ;; really in need of revision
(load "~/.emacs.d/indicate-cursor.el")          ;; useless

;; This hack ensures bindings gets loaded last
(add-hook 'after-init-hook (lambi (load "~/.emacs.d/bindings2.el")))
(load "~/.emacs.d/bindings2.el")

;; I don't always need a *scratch*
(condition-case nil (kill-buffer "*scratch*") (error nil))

(provide 'init)
;;; init.el ends here
