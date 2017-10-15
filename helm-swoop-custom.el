(defun tl/helm-swoop-C-s ()
    (interactive)
    (if (boundp 'helm-swoop-pattern)
            (if (equal helm-swoop-pattern "")
                    (previous-history-element 1)
                (helm-next-line))
    (helm-next-line)
    ))

(with-eval-after-load 'helm-swoop
    (define-key helm-swoop-map (kbd "C-s") 'tl/helm-swoop-C-s))
(setq helm-swoop-pre-input-function (lambda () ""))
