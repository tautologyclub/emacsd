(require 'helm)
(require 'helm-config)
(require 'helm-ring)
(helm-mode 1)
(helm-descbinds-mode 1)

(defun helm-toggle-header-line ()
  (if (= (length helm-sources) 1)
      (set-face-attribute 'helm-source-header nil :height 0.1)
    (set-face-attribute 'helm-source-header nil :height 1.0)))
(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)

;(setq helm-find-files-after-init-hook nil)
