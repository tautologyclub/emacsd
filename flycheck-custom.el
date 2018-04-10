(require 'flycheck)

(defhydra hydra-flycheck
  (:pre (progn (setq hydra-lv t) (flycheck-list-errors)
               (setq truncate-lines -1)
               (when (flycheck-pos-tip-mode)
                 (call-interactively 'flycheck-pos-tip-mode)))
        :post (progn (setq hydra-lv nil)
                     (quit-windows-on "*Flycheck errors*")
                     (flycheck-pos-tip-mode t))
   :hint nil)
  "Errors"
  ("f"  flycheck-error-list-set-filter                            "Filter")
  ("j"  next-error                                       "Next")
  ("k"  previous-error                                   "Previous")
  ("<down>"  flycheck-next-error)
  ("<up>"  flycheck-previous-error)
  ("h" flycheck-first-error                                      "First")
  ("l"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("q"  nil                                                       "Quit"))

(defun benjamin/flycheck-list-errors ()
  "List errors in a separate window, decrease the size."
  (interactive)
  (flycheck-list-errors)
  (hydra-flycheck/body)
  )

(require 'flycheck)
(require 'flycheck-irony)
(require 'flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))





;;
