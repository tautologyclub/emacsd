
(require 'anaconda-mode)
(define-key anaconda-mode-map (kbd "M-r") nil)
(semantic-add-system-include "/usr/lib/python3.6" 'python-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(setq elpy-rpc-backend "jedi")
(elpy-enable)
