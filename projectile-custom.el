(require 'projectile)
(require 'ivy)

;;;###autoload
(defun projectile-get-term ()
  "Get multi-term in project root."
  (interactive)
  (setq projectile--proj-term-name
        (concat "term:" (projectile-project-name)))
  (if (not (eq nil (get-buffer projectile--proj-term-name)))
      (switch-to-buffer projectile--proj-term-name)
    (projectile-with-default-dir (projectile-project-root)
      (multi-term)
      (rename-buffer projectile--proj-term-name))))

(defhydra hydra-counsel-projectile (:color yellow
                                           :hint nil
                                           )
  "
  _a_: ag  _b_: buffer _c_: compile  _d_: dir _e_: replace
  _f_: file  _g_: ripgrep  _G_: gitgrep  _i_: invalide cache
  _K_: killall    _m_: multi-swoop _r_: run  _s_: save
  _%_  replace-regex

"
  ("%"   projectile-replace-regexp)
  ("a"   counsel-projectile-ag)
  ("b"   counsel-projectile-switch-to-buffer)
  ("c"   projectile-compile-project)
  ("d"   counsel-projectile-find-dir)
  ("e"   projectile-replace)
  ("E"   projectile-edit-dir-locals "dir-locals" :color blue)
  ("f"   counsel-projectile-find-file)
  ("g"   counsel-projectile-rg)
  ("G"   counsel-git-grep)
  ("i"   projectile-invalidate-cache)
  ("K"   projectile-kill-buffers :color blue)
  ("m"   helm-multi-swoop-projectile)
  ("s"   projectile-save-project-buffers)
  ("p"   counsel-projectile "counsel" :color blue)
  ("M-p"   counsel-projectile :color blue)
  ("r"   projectile-run-project)
  ("t"   projectile-get-term "term" :color blue)
  ("u"   ggtags-update-tags)
  ("S"   counsel-projectile-switch-project "switch" :color blue)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("q"   nil "quit" :color blue))

(defun projectile-find-file-other-optimal-frame ()
  (interactive)
  (shell-command "/bin/bash ~/.config/split_optimal.sh")
  (projectile-find-file-other-frame))

(defadvice projectile-find-file-other-frame (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(define-key projectile-command-map (kbd "t")    #'projectile-get-term)
(define-key projectile-command-map (kbd "r")    #'counsel-projectile-rg)
(define-key projectile-command-map (kbd "o")    #'projectile-find-other-file)
(define-key projectile-command-map (kbd "O")    #'projectile-find-other-file-other-window)
(define-key projectile-command-map (kbd "p")    #'counsel-projectile)
(define-key projectile-command-map (kbd "a")    #'counsel-projectile-ag)
(define-key projectile-command-map (kbd "s")    #'counsel-projectile-switch-project)
(define-key projectile-command-map (kbd "d")    #'counsel-projectile-find-dir)
(define-key projectile-command-map (kbd "g")    #'counsel-projectile-git-grep)
(define-key projectile-command-map (kbd "w")    #'projectile-find-file-other-optimal-frame)
(define-key projectile-command-map (kbd "q")    #'projectile-replace)
(define-key projectile-command-map (kbd "C-p")  #'counsel-projectile)
(define-key projectile-command-map (kbd "C-f")    #'projectile-find-file-in-known-projects)
(define-key projectile-command-map (kbd "C-s")  #'projectile-run-shell-command-in-root)
(define-key projectile-command-map (kbd "C-e")  #'projectile-run-eshell)

(define-key projectile-command-map (kbd "C-S-s")
  #'projectile-run-async-shell-command-in-root)

(define-key projectile-command-map (kbd "ESC")  nil)
(define-key projectile-command-map (kbd "SPC")  nil)
(define-key projectile-command-map (kbd "!")    nil)
(define-key projectile-command-map (kbd "&")    nil)
(define-key projectile-command-map (kbd "I")    nil)
(define-key projectile-command-map (kbd "f")    nil)
(define-key projectile-command-map (kbd "h")    nil)
(define-key projectile-command-map (kbd "l")    nil)
(define-key projectile-command-map (kbd "m")    nil)
(define-key projectile-command-map (kbd "4")    nil)
(define-key projectile-command-map (kbd "5")    nil)

    ;; C-c p !         projectile-run-shell-command-in-root
    ;; C-c p &         projectile-run-async-shell-command-in-root
    ;; C-c p C         projectile-configure-project
    ;; C-c p D         projectile-dired
    ;; C-c p F         projectile-find-file-in-known-projects
    ;; C-c p T         projectile-find-test-file
    ;; C-c p c         projectile-compile-project
    ;; C-c p c         projectile-compile-project
    ;; C-c p d         counsel-projectile-find-dir
    ;; C-c p i         projectile-invalidate-cache
    ;; C-c p j         projectile-find-tag
    ;; C-c p x e       projectile-run-eshell
    ;; C-c p 5 D       projectile-dired-other-frame
    ;; C-c p 5 a       projectile-find-other-file-other-frame
    ;; C-c p 5 t       projectile-find-implementation-or-test-other-frame
    ;; s-r             counsel-projectile-rg
