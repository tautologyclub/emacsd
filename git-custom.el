
(defun git-branch-string ()
  "Return current git branch as a string, or the empty string if pwd is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (eshell-search-path "git")
             (locate-dominating-file default-directory ".git"))
    (let ((git-output (shell-command-to-string (concat "cd " default-directory " && git branch | grep '\\*' | sed -e 's/^\\* //'"))))
      (if (> (length git-output) 0)
          (substring git-output 0 -1)
          ;; (concat " :" (substring git-output 0 -1))
        "(no branch)"))))

(defun git-branch-to-kill-ring ()
  (interactive)
  (kill-new (format "%s" (git-branch-string)))
  )


(global-git-gutter+-mode)

(defhydra hydra-git-gutter (:body-pre (git-gutter+-mode 1)
                            :color
                            :hint nil)
  "
Git (gutter and other stuff):
  _j_: next hunk        _s_tage hunk     _f_ind-file     _q_uit
  _k_: previous hunk    _r_evert hunk    _b_lame         _Q_uit hard
  _h_: first hunk    vc-_e_diff          _S_tage buffer  _t_ime-machine
  _l_: last hunk  setStart_R_evision  _p_opup hunk  _cg_rep   _cl_og
"
  ("f" magit-find-file :color blue)
  ("b" magit-blame :color blue)
  ("cg" counsel-git-grep :color blue)
  ("cl" counsel-git-log :color blue)
  ("j" git-gutter+-next-hunk)
  ("k" git-gutter+-previous-hunk)
  ("h" (progn (goto-char (point-min))
              (git-gutter+-next-hunk 1)))
  ("l" (progn (goto-char (point-min))
              (git-gutter+-previous-hunk 1)))

  ("t" git-timemachine :color blue)
  ("e" vc-ediff :color blue)
  ("d" magit-diff)
  ("s" git-gutter+-stage-hunks)
  ("S" git-gutter+-stage-whole-buffer :color blue)
  ("r" git-gutter+-revert-hunks)
  ("p" git-gutter+-popup-hunk)
  ("SPC" git-gutter+-show-hunk-inline-at-point)
  ("R" git-gutter+-set-start-revision)
  ("q" nil :color blue)
  ("Q" (progn (git-gutter+-mode -1)
              ;; git-gutter+-fringe doesn't seem to
              ;; clear the markup right away
              (sit-for 0.1)
              (git-gutter+-clear))
       :color blue))


;; --- magit ------------------------------------------------------------
(require 'magit)

;;* Maps
;;** Status
(define-key magit-status-mode-map "j" 'magit-section-forward)
(define-key magit-status-mode-map "k" 'magit-section-backward)
(define-key magit-status-mode-map "h" 'magit-section-backward)
(define-key magit-status-mode-map "\C-k" nil)
(define-key magit-status-mode-map "\C-d" 'magit-discard)
(define-key magit-status-mode-map "d" 'magit-discard)
(define-key magit-status-mode-map "i" 'magit-section-toggle)
(define-key magit-status-mode-map (kbd "M-m") 'lispy-mark-symbol)
(define-key magit-status-mode-map "C" 'ora-magit-commit-add-log)
(define-key magit-status-mode-map "v" (lambda () (interactive) (magit-visit-thing)))
(define-key magit-status-mode-map "V" 'projectile-find-file)
(define-key magit-status-mode-map "h" 'ora-magit-find-main-file)
(define-key magit-status-mode-map "ox" 'ora-magit-simple-commit)
(define-key magit-status-mode-map "od" 'ora-magit-difftool)

;;** Log
(define-key magit-log-mode-map "j" 'magit-section-forward)
(define-key magit-log-mode-map "k" 'magit-section-backward)
(define-key magit-log-mode-map "v" 'ora-magit-visit)
(define-key magit-log-mode-map "o" 'ora-magit-visit-item-other-window)
;;** Commit
(define-key magit-commit-section-map "i" 'magit-section-toggle)
(define-key magit-commit-section-map "j" 'magit-section-forward)
(define-key magit-commit-section-map "k" 'magit-section-backward)
(define-key magit-commit-section-map "n" 'ora-magit-copy-item-as-kill)
(define-key magit-commit-section-map "C" 'ora-magit-commit-add-log)
(define-key magit-commit-section-map "od" 'ora-magit-difftool)

;;** Diff
(define-key magit-diff-mode-map "i" 'magit-section-toggle)
(define-key magit-diff-mode-map "j" 'magit-section-forward)
(define-key magit-diff-mode-map "k" 'magit-section-backward)
(define-key magit-diff-mode-map "o"
  (lambda () (interactive) (magit-visit-item t)))
;;** Manager
(define-key magit-branch-section-map "j" 'magit-section-forward)
(define-key magit-branch-section-map "k" 'magit-section-backward)
(define-key magit-branch-section-map "d" 'magit-discard-item)
(define-key magit-branch-section-map "u" 'magit-diff-working-tree)
;;* Hooks
;;;###autoload
(defun ora-magit-status-hook ()
  (yas-minor-mode 0))
;;;###autoload
(defun ora-magit-log-hook ())
;;;###autoload
(defun ora-magit-commit-hook ())
;;;###autoload
(defun ora-magit-diff-hook ())
;;;###autoload
(defun ora-magit-branch-manager-hook ())

;;;###autoload
(defun ora-git-commit-hook ()
  (setq fill-column 120))

(add-hook 'git-commit-mode-hook 'ora-git-commit-hook)

;;* Functions
(defun ora-magit-find-main-file ()
  "Open the main file of the repo."
  (interactive)
  (let* ((dirname (car (last (split-string default-directory "/" t))))
         (fname (format "%s.el" dirname)))
    (when (file-exists-p fname)
      (find-file fname))))

(defun endless/add-PR-fetch ()
  "If refs/pull is not defined on a GH repo, define it."
  (interactive)
  (let ((fetch-address "+refs/pull/*/head:refs/pull/origin/*"))
    (unless (member fetch-address
                    (magit-get-all "remote" "origin" "fetch"))
      (when (string-match
             "github" (magit-get "remote" "origin" "url"))
        (magit-git-string
         "config" "--add" "remote.origin.fetch"
         fetch-address)))))

(defun ora-magit-visit-item-other-window ()
  (interactive)
  (magit-visit-item t))

(defun ora-magit-simple-commit ()
  (interactive)
  (save-window-excursion
    (let ((item (magit-section-info (magit-current-section))))
      (ignore-errors (magit-stage-item))
      (search-forward item)
      (ora-magit-commit-add-log)
      (insert "Update")
      (git-commit-commit))))

(defun ora-magit-difftool ()
  (interactive)
  (let ((item (magit-section-info (magit-current-section))))
    (ora-dired-start-process
     "git difftool" (list item))))

;; (add-hook 'magit-mode-hook #'endless/add-PR-fetch)
