
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
                            (message-buffer-file-name-or-nothing))
                     :post (progn
                             (delete-selection-mode t)
                             (set-cursor-color "#16A085")
                             (hl-line-mode t)
                             )
                     :columns 5
                     )
  "--- nav -----------------------------------------------------------------------"

  ("a"      xah-beginning-of-line-or-block      "bol")
  ("u"      undo-tree-undo                      "undo")
  ("t"      (transpose-chars -1)                "flip char")
  ("z"      (transpose-words -1)                "flip word")
  ("y"      yank                                "yank")
  ("e"      xah-end-of-line-or-block            "eol")
  ("U"      undo-tree-redo                      "redo")
  ("T"      (transpose-chars 1)                 "rflip char")
  ("Z"      (transpose-words 1)                 "rflip word")
  ("P"      transpose-params                    "flip param")
  ("o"      smart-open-line-above               "open above")
  ("s"      swiper                              "swipe")

  ("f"      benjamin/jump-char-fwd              "jump fwd")
  ("g"      avy-goto-char                       "avy-char")
  ("v"      scroll-down-half)
  ("h"      backward-char)
  ("j"      next-line)
  ("k"      previous-line)
  ("l"      forward-char)

  ("p"      exchange-point-and-mark             "xch p/m")
  ("w"      kill-region                         "kill")

  ("d"      duplicate-current-line-or-region    "dupl")
  ("c"      comment-or-uncomment-region-or-line "comment")  ;; todo
  ;; ("r"   nil)  ;; todo
  ;; ("i"   nil)  ;; todo
  ;; ("x"   nil)
  ;; ("n"   left-word)

  ("H"      mark-paragraph)
  ("L"      recenter-top-bottom                 "recenter")
  ("C-h"    elpy-nav-indent-shift-left)
  ("C-j"    elpy-nav-move-line-or-region-down)
  ("C-k"    elpy-nav-move-line-or-region-up)
  ("C-l"    elpy-nav-indent-shift-right)
  ("b"      benjamin/jump-char-bwd             "jump bwd")
  ("m"      (lambda () (interactive)
              (keyboard-quit)
              (hydra-nav/body))                 "new mark")
  ;; ("."      exchange-point-and-mark)
  ;; ("]"      exchange-point-and-mark)

  ("q"      (lambda () (interactive)
              (deactivate-mark)
              (keyboard-quit))                  "quit" :color blue)
  ("C-g"    (lambda () (interactive)
              (deactivate-mark)
              (keyboard-quit)) :color blue)
  (","      highlight-region)
  ("<"      highlight-clear)

  ("="      er/expand-region)
  ("-"      er/contract-region)

  ("("      (fastnav-search-char-forward 1 ?())  ;; cool
  (")"      (fastnav-search-char-forward 1 ?)))
  ("SPC"    forward-to-char-after-ws)
  ("C-x a"  simplified-beginning-of-buffer)
  ("C-x e"  simplified-end-of-buffer)

  ("<f9>"   nil))











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
