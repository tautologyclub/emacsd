
(defun set-mark-if-inactive ()
  (interactive)
  (if (not (region-active-p))
      (set-mark-command nil)))

(defhydra hydra-nav (
                     :color yellow
                     :hint nil
                     :pre (progn
                            (overwrite-mode -1)
                            (delete-selection-mode nil)
                            (set-mark-if-inactive)
                            (hl-line-mode)
                            (message-buffer-file-name-or-nothing))
                     :post (progn
                             (delete-selection-mode t)
                             (hl-line-mode -1))
                     )
  "
--- navigation-hydra ---------------------------------------------
"

  ("q"   keyboard-quit :color blue)
  ("w"   kill-region-or-backward-word)
  ("e"   xah-end-of-line-or-block)
  ;; ("r"   nil)
  ("t"   transpose-chars)
  ("y"   yank)
  ("u"   (up-list -1)) ;; dubious perhaps
  ;; ("i"   nil)  ;; todo
  ;; ("o"   nil)  ;; todo
  ;; ("p"   nil)  ;; todo

  ("a"   xah-beginning-of-line-or-block)
  ("s"   swiper)
  ("d"   (up-list 1))
  ("f"   benjamin/jump-char-fwd)
  ("g"   avy-goto-word-1-below)
  ("h"   backward-char)
  ("j"   next-line)
  ("k"   previous-line)
  ("l"   forward-char)

  ("z"   avy-goto-word-1-above)
  ;; ("x"   nil)
  ;; ("v"   scroll-down-half)
  ("b"   benjamin/jump-char-bwd)
  ("n"   left-word)  ;;
  ("m"   forward-to-word) ;;
  (","   highlight-region)
  ("<"   highlight-clear)
  ("."   exchange-point-and-mark)

  ("A"   back-to-indentation)
  ("="   er/expand-region)
  ("-"   er/contract-region)

  ("("   (fastnav-search-char-forward 1 ?())  ;; fantastic, should bind more of these
  (")"   (fastnav-search-char-backward 1 ?)))
  ("["   (fastnav-search-char-forward 1 ?[))
  ("]"   (fastnav-search-char-backward 1 ?]))
  ("{"   (fastnav-search-char-forward 1 ?{))
  ("}"   (fastnav-search-char-backward 1 ?}))
  ("SPC"   (fastnav-search-char-forward 1 ? ))

  ("C-g" (lambda () (interactive)
           (keyboard-quit)
           (hydra-nav/body)))
  ("C-x a" simplified-beginning-of-buffer)
  ("C-x e" simplified-end-of-buffer)

  ("<f9>" nil))











;; interesting
  ;; ;; c - commands (durrr)
  ;; ("coa" org-agenda :color blue)
  ;; ("coh" (find-file "~/.org/home.org") :color blue)
  ;; ("cow" (find-file "~/.org/work.org") :color blue)
  ;; ("cot" (find-file "~/.org/tracking.org") :color blue)
  ;; ("cp"  hydra-counsel-projectile/body :color blue)
  ;; ("ci"  counsel-imenu)
  ;; ("cl"  counsel-locate)
  ;; ("cc"  compile)
  ;; ("cg"  magit-status :color blue)
  ;; ("cd"  (lambda () (interactive)
  ;;          (dired-jump)
  ;;          (hydra-dired/body)) :color blue)
  ;; ("C"   comment-or-uncomment-region-or-line)
  ;; ("Y"   yank-after-cursor)

(provide 'hydra-nav)
;; hydra-nav.el ends here
