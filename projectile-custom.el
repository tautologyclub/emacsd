(require 'projectile)

(defun projectile-get-term ()
  "Get dedicated multi-term in project root"
  (interactive)
  (setq projectile--proj-term-name
        (concat (concat (concat (concat "PROJ-" multi-term-buffer-name) "[")
          (projectile-project-name)) "]"))
  (if (not (eq nil (get-buffer projectile--proj-term-name)))
      (switch-to-buffer projectile--proj-term-name)
    (projectile-with-default-dir (projectile-project-root)
      (multi-term)
      (rename-buffer projectile--proj-term-name))))

;; PROJECTILE: %(projectile-project-root)
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
