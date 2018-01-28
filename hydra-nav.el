
(defun set-mark-if-inactive ()
  (interactive)
  (if (not (region-active-p))
      (set-mark-command nil)))

(hl-line-mode t)

(require 'elpy)
(defhydra hydra-nav (:color yellow
                     :hint nil
                     :pre (progn
                            (set-mark-if-inactive)
                            (delete-selection-mode nil)
                            (set-cursor-color "#FF0000")
                            (hl-line-mode -1)
                            )
                     :post (progn
                             (delete-selection-mode t)
                             (set-cursor-color "#16A085")
                             (hl-line-mode t)
                             )
                     :columns 5
                     )
  "--- nav -----------------------------------------------------------------------"

  ("C-g"    (lambi (deactivate-mark) (keyboard-quit)) :color blue)

  ("q"      left-word)
  ("w"      right-word)
  ("e"      xah-end-of-line-or-block)
  ;; ("r"   nil)  ;; todo
  ;; ("t"   nil)  ;; todo
  ("y"      yank                                "yank")
  ;; ("u"      undo-tree-undo                      "undo")
  ("i"      benjamin/mark-inside-pairs)
  ;; ("o"      smart-open-line-above               "open above")
  ("p"      exchange-point-and-mark             "xch p/m")

  ("Y"   yank-after-cursor)

  ("a"      xah-beginning-of-line-or-block)
  ("s"      swiper                              "swipe")
  ("d"      duplicate-current-line-or-region)
  ("f"      benjamin/jump-char-fwd                          "jump fwd")
  ("g"      avy-goto-char                                   "avy-char")
  ("h"      backward-char)
  ("j"      next-line)
  ("k"      previous-line)
  ("l"      forward-char)

  ("H"      er/mark-paragraph)
  ("L"      recenter-top-bottom                             "recenter")

  ;; ("z"   nil)
  ;; ("x"   nil)
  ("c"      comment-or-uncomment-region-or-line             "comment")
  ("v"      (lambda () (interactive) (forward-line 30))     "scroll down")
  ("b"      benjamin/jump-char-bwd                          "jump bwd")
  ;; ("n"   left-word)
  ("m"      (lambda () (interactive) (deactivate-mark))     "new mark")

  ("V"      (lambi (forward-line -30))                      "scroll up")

  ("="      er/expand-region)
  ("-"      er/contract-region)

  ("("      (fastnav-search-char-forward 1 ?())  ;; cool
  (")"      (fastnav-search-char-forward 1 ?)))
  ("SPC"    forward-to-char-after-ws)

  ("<f9>"   nil))


(provide 'hydra-nav)
;; hydra-nav.el ends here
