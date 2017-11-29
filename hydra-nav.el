
(defun set-mark-if-inactive ()
  (interactive)
  (if (not (region-active-p))
      (set-mark-command nil)))

(defhydra hydra-nav (:color yellow
                     :hint nil
                     :pre (progn
                            (overwrite-mode -1)
                            (delete-selection-mode nil)
                            (set-mark-if-inactive)
                            (set-cursor-color "#FF0000")
                            (message-buffer-file-name-or-nothing))
                     :post (progn
                             (delete-selection-mode t)
                             (set-cursor-color "#16A085")
                             )
                     :columns 4
                     )
  "--- nav -----------------------------------------------------------------------"

  ("q"   keyboard-quit                      "quit "     :color blue)
  ("w"   (transpose-words -1)                        "trsp word <")
  ("W"   (transpose-words 1)                        "trsp word >")
  ("e"   xah-end-of-line-or-block           "eol")
  ;; ("r"   nil)  ;; todo
  ("y"   yank                               "yank")
  ("t"   (transpose-chars -1)                    "trsp char <")
  ("T"   (transpose-chars 1)                    "trsp char >")
  ("u"   undo-tree-undo                     "undo")
  ("U"   undo-tree-redo                     "redo")
  ;; ("i"   nil)  ;; todo
  ;; ("o"   nil)  ;; todo
  ("p"   transpose-params                   "trsp param")  ;; todo

  ("a"   xah-beginning-of-line-or-block     "bol")
  ("s"   swiper                             "swipe")
  ("d"   (up-list 1))
  ("f"   benjamin/jump-char-fwd             "jump fwd")
  ("g"   avy-goto-char                      "avy-char")
  ("h"   backward-char)
  ("j"   next-line)
  ("k"   previous-line)
  ("l"   forward-char)

  ;; ("z"   avy-goto-word-1-above)
  ;; ("x"   nil)
  ;; ("v"   scroll-down-half)
  ("b"   benjamin/jump-char-bwd             "jump bwd")
  ("n"   left-word)
  ("m"   forward-to-word)
  (","   highlight-region                   "highlight")
  ("<"   highlight-clear                    "hl clear")
  ("."   exchange-point-and-mark            "flip p/mark")

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
           (hydra-nav/body))                "unmark")
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
