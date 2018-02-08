
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

  ("C-g"    (lambda () (interactive)
              (deactivate-mark) (hydra-keyboard-quit)) :color blue)

  ("q"      left-word)
  ("w"      right-word)
  ("e"      xah-end-of-line-or-block)
  ;; ("r"   nil)
  ;; ("t"   nil)
  ("y"      yank                                "yank")
  ;; ("u"      nil)
  ("i"      benjamin/mark-inside-pairs  :color blue)
  ("o"      er/mark-outside-pairs       :color blue)
  ("p"      exchange-point-and-mark             "xch p/m")

  ("Y"   yank-after-cursor)

  ("a"      xah-beginning-of-line-or-block)
  ("s"      swiper                              "swipe")
  ("d"      duplicate-current-line-or-region)
  ("f"      benjamin/jump-char-fwd              "jump fwd")
  ("g"      avy-goto-char                       "avy-char")
  ("h"      backward-char)
  ("j"      next-line)
  ("k"      previous-line)
  ("l"      forward-char)

  ("F"      er/mark-defun)
  ("H"      er/mark-paragraph)
  ("L"      recenter-top-bottom)

  ;; ("z"   nil)
  ;; ("x"   nil)
  ("c"      comment-or-uncomment-region-or-line             "comment")
  ("v"      (lambda () (interactive) (forward-line 30))     "scroll down")
  ("b"      benjamin/jump-char-bwd                          "jump bwd")
  ;; ("n"   nil)
  ("m"      (lambda () (interactive) (deactivate-mark))     "new mark")

  ("V"      (lambda () (interactive) (forward-line -30))                      "scroll up")

  ("="      er/expand-region)
  ("-"      er/contract-region)

  ("("      (fastnav-search-char-forward 1 ?( ))  ;; cool
  (")"      (lambda () (interactive)
              (fastnav-search-char-forward 1 ?) )(forward-char)))
  ("SPC"    forward-whitespace)

  ("<f9>"   nil))


(provide 'hydra-nav)
;; hydra-nav.el ends here
