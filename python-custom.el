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
  (define-key python-mode-map (kbd "C-c d") 'helm-pydoc))

(semantic-add-system-include "/usr/lib/python3.6" 'python-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(setq elpy-rpc-backend "jedi")
(elpy-enable)

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i")

(provide 'python-custom)
;;; python-custom ends here
