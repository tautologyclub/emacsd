;;; package --- Summary
;; I like python.

;;; Commentary:
;; I like pancakes.

;;; Code:
(require 'elpy)
(require 'anaconda-mode)
(require 'semantic)

(with-eval-after-load "anaconda-mode"
  (define-key anaconda-mode-map (kbd "M-r") nil))

(with-eval-after-load "python-mode"
  (define-key python-mode-map (kbd "C-c d") 'helm-pydoc)
  )


(semantic-add-system-include "/usr/lib/python3.6" 'python-mode)
(semantic-add-system-include "/usr/lib/python2.7" 'python-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

(elpy-enable)
(setq elpy-rpc-backend "jedi")

    (define-key elpy-mode-map (kbd "C-x C-a C-b C-c") nil)

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i")

(provide 'python-custom)
;;; python-custom ends here
