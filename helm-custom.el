
(require 'helm)
(require 'helm-config)
(require 'helm-ring)
(require 'helm-swoop)

(setq helm-mode-line-string " ")
(defun helm-display-mode-line (source &optional force)
"Does nothing cuz we roll Luddite."
)

(defun benjamin/helm-buffers-list ()
  "Preconfigured `helm' to list buffers."
  (interactive)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
  (setq helm-split-window-default-side 'right)
  (helm :sources '(helm-source-buffers-list
                   helm-source-ido-virtual-buffers
                   helm-source-buffer-not-found)
        :buffer "*helm buffers*"
        :keymap helm-buffer-map
        :input "\!\\* "
        :truncate-lines helm-buffers-truncate-lines)
  (setq helm-split-window-default-side 'below))

(require 'helm-projectile)
(defun benjamin/helm-projectile ()
  "helm buffers filtering away star-buffers as default"
  (interactive)
  (setq helm-split-window-default-side 'right)
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources helm-projectile-sources-list
          :buffer "*helm projectile*"
          :truncate-lines helm-projectile-truncate-lines
          :prompt (projectile-prepend-project-name (if (projectile-project-p)
                                                       "pattern: "
                                                     "Switch to project: "))))
  (setq helm-split-window-default-side 'below))


(defhydra helm-like-unite (:hint nil
                           :color pink)
  "
Nav ^^^^^^^^^        Mark ^^          Other ^^       Quit
^^^^^^^^^^------------^^----------------^^----------------------
_K_ ^  ^ _k_ ^ ^     _m_ark           _v_iew         _i_: cancel
^↕^ _h_ ^✜^ _l_ ^ ^   _t_oggle mark    _H_elp         _o_: quit
_J_ ^  ^ _j_ ^ ^     _U_nmark all     _d_elete       _s_: swoop-edit (broken)
^^^^^^^^^^                           _f_ollow: %(helm-attr 'follow)
"
  ;; arrows
  ("h" helm-beginning-of-buffer)
  ("j" helm-next-line)
  ("k" helm-previous-line)
  ("l" helm-end-of-buffer)

  ;; beginning/end
  ("g" helm-beginning-of-buffer)
  ("G" helm-end-of-buffer)

  ;; scroll
  ("K" helm-scroll-other-window-down)
  ("J" helm-scroll-other-window)

  ;; mark
  ("m" helm-toggle-visible-mark)
  ("t" helm-toggle-all-marks)
  ("U" helm-unmark-all)

  ;; exit
  ("<escape>" keyboard-escape-quit "" :exit t)
  ("o" keyboard-escape-quit :exit t)
  ("i" nil)

  ;; sources
  ("}" helm-next-source)
  ("{" helm-previous-source)

  ;; rest
  ("H" helm-help)
  ("v" helm-execute-persistent-action)
  ("d" helm-persistent-delete-marked)
  ("f" helm-follow-mode)
  ("<f9>" nil)
  ("s" (progn
         (hydra-keyboard-quit)
         (helm-swoop-edit))
   :exit t))
(helm-descbinds-mode 1)

(defun helm-toggle-header-line ()
  (if (= (length helm-sources) 1)
      (set-face-attribute 'helm-source-header nil :height 0.1)
    (set-face-attribute 'helm-source-header nil :height 1.0)))
(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)

(defun benjamin/helm-buffers-persistent-kill (_buffer)
  (let ((marked (helm-marked-candidates)))
    (unwind-protect
         (cl-loop for b in marked
               do (progn (helm-preselect
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

(defun benjamin/helm-buffer-run-kill-persistent ()
  "Kill buffer without prompt and without quitting helm."
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'kill-action '(benjamin/helm-buffers-persistent-kill . never-split))
    (helm-execute-persistent-action 'kill-action)))
(put 'benjamin/helm-buffer-run-kill-persistent 'helm-only t)

(define-key helm-map (kbd "<f9>") 'helm-like-unite/body)
(define-key helm-map (kbd "C-o") 'helm-buffer-switch-other-frame)
(define-key helm-map (kbd "C-h b") 'helm-descbinds)
(define-key helm-map (kbd "M-d") 'benjamin/helm-buffer-run-kill-persistent)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-S-j") 'helm-follow-action-forward)
(define-key helm-map (kbd "C-S-k") 'helm-follow-action-backward)

(define-key helm-map (kbd "C-p") 'helm-previous-line)
(define-key helm-map (kbd "C-n") 'helm-previous-line)

;; (define-key map (kbd "C-n")        'helm-next-line)
;;     (define-key map (kbd "C-p")        'helm-previous-line)
;;     (define-key map (kbd "C-j")        'helm-execute-persistent-action)
;;     (define-key map (kbd "C-k")        'helm-delete-minibuffer-contents)
