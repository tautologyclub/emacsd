(require 'hideshow)
(require 'vimish-fold)
(require 'some-defuns)

;; 32 candidates:
;; C-c C-n         gud-next
;; C-c C-p         gud-print
;; C-c C-r         gud-cont
;; C-c <           gud-up
;; C-c >           gud-down
;; C-t C-a C-b     gud-break
;; C-t C-a C-d     gud-remove
;; C-t C-a C-e     gud-statement
;; C-t C-a C-f     gud-finish
;; C-t C-a C-l     gud-refresh
;; C-t C-a C-n     gud-next
;; C-t C-a C-p     gud-print
;; C-t C-a C-r     gud-cont
;; C-t C-a C-s     gud-step
;; C-t C-a <       gud-up
;; C-t C-a >       gud-down
;; C-x C-a C-b     gud-break
;; C-x C-a C-d     gud-remove
;; C-x C-a C-e     gud-statement
;; C-x C-a C-f     gud-finish
;; C-x C-a C-l     gud-refresh
;; C-x C-a C-n     gud-next
;; C-x C-a C-p     gud-print
;; C-x C-a C-r     gud-cont
;; C-x C-a C-s     gud-step
;; C-x C-a <       gud-up
;; C-x C-a >       gud-down

(defun next-lines-indentation ()
  "Next line, then back to indentation."
  (interactive)
  (forward-line 1)
  (back-to-indentation))

(defun previous-lines-indentation ()
  "Next line, then back to indentation."
  (interactive)
  (forward-line -1)
  (back-to-indentation))

(defhydra hydra-gdb (:columns 6     :color pink
                     :pre (auto-dim-other-buffers-mode -1)
                     :post (auto-dim-other-buffers-mode +1))
  "-"
  ("q"  nil :color blue)
  ("y"  gud-statement "send py-line")
  ("o"  other-window "other win")

  ("F"  gud-finish "finish")
  ("s"  gud-step "step")
  ("j"  next-lines-indentation)
  ("k"  previous-lines-indentation)
  ("L"  gud-refresh)

  ("c"  gud-continue)
  ("n"  gud-next "next")

  ("DEL"    gud-remove)
  ("SPC"    gud-break "break")
  )

(defun get-term-and-git-log ()
  "Fuck off."
  (interactive)
  (call-interactively 'multi-term)
  (term-send-raw-string " git log "))

(defhydra hydra-git (:body-pre (git-gutter+-mode 1)
                     :columns 4
                     :color red)
  "
--- git -------------------------------------------------------------------------"
  ("h"   (progn (goto-char (point-min)) (git-gutter+-next-hunk 1)) "first hunk")

  ("s"   git-gutter+-stage-hunks    "stage hunk")
  ("S"   git-gutter+-stage-whole-buffer "stage buf" :color blue)
  ("f"   magit-find-file        "find file"     :color blue)
  ("t"   git-timemachine        "timemach"      :color blue)
  ("j"   git-gutter+-next-hunk      "next hunk")
  ("e"   vc-ediff               "ediff"         :color blue)
  ("TAB" git-gutter+-popup-hunk "popup hunk")

  ("o"   (progn (magit-log-buffer-file) (delete-other-windows))
                                "log file"      :color blue)
  ("b"   magit-blame            "blame"         :color blue)
  ("k"   git-gutter+-previous-hunk "prev hunk")
  ("g"   magit-status           "status"        :color blue)

  ("cg"  counsel-git-grep       "grep files"    :color blue)
  ("cl"  counsel-git-log        "grep log"      :color blue)

  ("G"  (lambda () (interactive)
          (progn (multi-term)
                 (term-send-raw-string " git log --grep ")))
                             "grep log (shell)" :color blue)

  ("d"   magit-diff             "diff range")
  ("l"   (progn (goto-char (point-max)) (git-gutter+-previous-hunk 1)) "last hunk")
  ("L"   get-term-and-git-log   "log in term" :color blue)
  ("H"   vc-region-history      "region hist"   :color blue)
  ("r"   git-gutter+-revert-hunks "revert")
  ("SPC" git-gutter+-show-hunk-inline-at-point "overlay hunk")

  ("q" nil                      "quit"          :color blue))

(defhydra hydra-ediff (:color blue :columns 2)
  "-- ediff ------------------------------------------------------------------------"
  ("e"  ediff-current-file      "unsaved")
  ("f"  ediff-files             "files")
  ("b"  ediff-buffers           "buffers A and B")
  ("c"  ediff-current-buffer    "this and buffer B")
  ("mf" ediff-merge-files       "merge files")
  ("mb" ediff-merge-buffers     "merge buffers")

  ("q"  nil                     "quit")
  ("RET" nil                    "quit"))

(defhydra hydra-eval (:color blue :columns 2)
  "-- eval -------------------------------------------------------------------------"
  ("b" eval-buffer              "buffer")
  ("r" eval-region              "region")
  ("d" eval-defun               "defun")
  ("e" eval-expression          "expression")
  ("w" crux-eval-and-replace    "eval+replace")

  ("RET" nil                    "quit")
  ("q" nil                      "quit"))

(defhydra helm-like-unite (:hint nil
                           :color pink)
  "
Nav ^^^^^^^^^        Mark ^^          Other ^^       Quit
^^^^^^^^^^------------^^----------------^^----------------------
_K_ ^  ^ _k_ ^ ^     _m_ark           _v_iew         _i_: cancel
^↕^ _h_ ^✜^ _l_ ^ ^   _t_oggle mark    _H_elp         _o_: quit
_J_ ^  ^ _j_ ^ ^     _U_nmark all     _d_elete       _s_: swoop-edit (broken)
^^^^^^^^^^                           _f_ollow: %(helm-attr 'follow)
"
  ;; arrows
  ("h" helm-beginning-of-buffer)
  ("j" helm-next-line)
  ("k" helm-previous-line)
  ("l" helm-end-of-buffer)

  ;; beginning/end
  ("g" helm-beginning-of-buffer)
  ("G" helm-end-of-buffer)

  ;; scroll
  ("K" helm-scroll-other-window-down)
  ("J" helm-scroll-other-window)

  ;; mark
  ("SPC" helm-toggle-visible-mark)
  ("m" helm-toggle-visible-mark)
  ("t" helm-toggle-all-marks)
  ("U" helm-unmark-all)

  ;; exit
  ("<escape>" keyboard-escape-quit "" :exit t)
  ("o" keyboard-escape-quit :exit t)
  ("i" nil)

  ;; sources
  ("}" helm-next-source)
  ("{" helm-previous-source)

  ;; rest
  ("H" helm-help)
  ("v" helm-execute-persistent-action)
  ("d" benjamin/helm-buffer-run-kill-persistent)

  ("f" helm-follow-mode)
  ("<f9>" nil)
  ("s" (progn
         (hydra-keyboard-quit)
         (helm-swoop-edit))
   :exit t))

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
  ("j"  flycheck-next-error                                       "Next")
  ("k"  flycheck-previous-error                                   "Previous")
  ("h" flycheck-first-error                                      "First")
  ("l"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("<down>"  flycheck-next-error)
  ("<up>"  flycheck-previous-error)
  ("RET" nil)
  ("q"  nil                                                       "Quit"))

;;;###autoload
(defun benjamin/flycheck-list-errors ()
  "List errors in a separate window, decrease the size."
  (interactive)
  (flycheck-list-errors)
  (hydra-flycheck/body))

(defhydra hydra-vimish-fold (:color blue
                             :columns 3)
  "folder"
  ("h" hs-hide-all "hs-hide all")
  ("s" hs-show-all "hs-show all")
  ("a" vimish-fold-avy "avy")
  ("d" vimish-fold-delete "del")
  ("D" vimish-fold-delete-all "del-all")
  ("u" vimish-fold-unfold "unfold")
  ("U" vimish-fold-unfold-all "unfold-all")
  ("f" vimish-fold "fold")
  ("r" vimish-fold-refold "refold")
  ("R" vimish-fold-refold-all "refold-all")
  ("t" vimish-fold-toggle "toggle" :exit nil)
  ("T" vimish-fold-toggle-all "toggle-all" :exit nil)
  ("j" vimish-fold-next-fold "down" :exit nil)
  ("k" vimish-fold-previous-fold "up" :exit nil)
  ("q" nil "quit"))

(defhydra hydra-errgo (:hint nil)
  ("q" nil              "quit")
  ("h" first-error      "first")
  ("j" next-error       "next")
  ("k" previous-error   "prev")
  ("l" last-error       "last")
  ("n" next-error       "next")
  ("p" previous-error   "prev")
  ("l" last-error       "last"))

(defvar prev-max-mini-window-height max-mini-window-height)
(defhydra hydra-toggle
  (:color red
   :hint nil
   :pre  (progn (setq prev-max-mini-window-height max-mini-window-height)
                (setq max-mini-window-height (max max-mini-window-height 30)))
   :post (setq max-mini-window-height prev-max-mini-window-height))
  "
  _a_ abbrev:           %`abbrev-mode
  _s_ semantic:         %`semantic-mode
  _T_    stickyfunc:    %`semantic-stickyfunc-mode
  _S_ flyspell:         %`flyspell-mode
  _e_ feebleline:       %`feebleline-mode
  _f_ auto-fill:        %`auto-fill-function
  _h_ hl-line:          %`hl-line-mode
  _d_ debug-on-error:   %`debug-on-error
  _D_ diff-mode:        %`diff-auto-refine-mode
  _t_ truncate-lines:   %`truncate-lines
  _y_ flycheck:         %`flycheck-mode
  _w_ whitespace:       %`whitespace-mode
  _l_ linum:            %`display-line-numbers
  _i_ fci:              %`fci-mode
  _I_ auto-dim:         %`auto-dim-other-buffers-mode
  _o_ overwrite:        %`overwrite-mode
  _r_ rec-minibuf       %`enable-recursive-minibuffers
  _R_ read-only         %`buffer-read-only
"
  ("a" abbrev-mode)
  ("s" semantic-mode)
  ("S" flyspell-mode)
  ("T" semantic-stickyfunc-mode)
  ("d" toggle-debug-on-error)
  ("D" diff-mode)
  ("f" auto-fill-mode)
  ("h" (setq highlight-nonselected-windows (not highlight-nonselected-windows)))
  ("e" feebleline-mode)
  ("t" toggle-truncate-lines)
  ("y" flycheck-mode)
  ("h" hl-line-mode)
  ("L" global-hl-line-mode)
  ("H" helm-gtags-mode)
  ("w" whitespace-mode)
  ("l" benjamin/toggle-linum)
  ("i" fci-mode                                     :color blue)
  ("I" auto-dim-other-buffers-mode)
  ("o" overwrite-mode)
  ("r" (setq enable-recursive-minibuffers
             (not enable-recursive-minibuffers))    :color blue)
  ("R" read-only-mode)
  ("RET" nil "quit")
  ("q" nil "quit"))

(defun benjamin/toggle-linum ()
  (interactive)
  ;; (set (make-local-variable 'display-line-numbers) (not display-line-numbers)))
  (setq display-line-numbers (not display-line-numbers)))

;; todo
(defhydra hydra-timestamp (:color blue :columns 2)
  " timestamp
--------------------------------------------------------------------------------
"
  ("tf" (paste-shell-stdout "date +'%d/%m/%y -- %H:%M:%S'")
   "DD/MM/YY -- HH:MM:SS")
  ("tt" (paste-shell-stdout "date +'%H:%M:%S '")
   "HH:MM:SS")
  ("td" (paste-shell-stdout "date +'%d/%m/%y '")
   "DD/MM/YY")
  ("td" (paste-shell-stdout "date +'%d/%m/%y '")
   "DD/MM/YY")
  ("ts" (paste-shell-stdout "date +'%A %d %B %Y '")
   "DD/MM/YY")
  ("RET" nil "quit")
  ("q" nil "quit"))

(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal :columns 3 :hint nil)
  "
-- PROJECTILE ------------------------------------------------------------------"
  ("A"   projectile-run-async-shell-command-in-root "async cmd")
  ("C"   projectile-invalidate-cache "invalidate")
  ("C-f" projectile-find-file-in-known-projects "file global")
  ("C-p" counsel-projectile)
  ("G"   ggtags-update-tags "update ggtags")
  ("T"   projectile-test-project "test")
  ("b"  projectile-switch-to-buffer-other-window "buffer o/w")
  ("c"   projectile-compile-project "compile")
  ("d"   counsel-projectile-find-dir "dir")
  ("D"   projectile-find-dir-other-window         "dir o/w")
  ("e"   projectile-recentf "recentf")
  ("E"   projectile-edit-dir-locals "dir-locals")
  ("f"   projectile-find-file-other-window "file o/w")
  ("g"   counsel-projectile-git-grep "git grep")
  ("i"   projectile-ibuffer "ibuffer")
  ("j"   projectile-find-tag "find tag")
  ("k"   projectile-kill-buffers "killall")
  ("m"   projectile-multi-occur "multi-occur")
  ("o"   projectile-find-other-file "otherf")
  ("p"   counsel-projectile "counsel")
  ("R"   projectile-replace "replace")
  ;; ("r"   counsel-projectile-rg "rg")
  ("r"   counsel-projectile-ag "rg") ;; tmp, counsel-rg kinda broken...?
  ("s"   counsel-projectile-switch-project "switch")
  ("t"   projectile-get-term "get-term")
  ("u"   projectile-run-project "run")
  ("x"   projectile-remove-known-project "remove a project")
  ("X"   projectile-cleanup-known-projects "cleanup projects")
  ("z"   projectile-cache-current-file "cache this file")
  ("C-g" nil :color blue)
  ("RET" nil :color blue)
  ("q"   nil "cancel" :color blue))

(global-unset-key (kbd "<f9>"))
(global-set-key (kbd "<f9>") 'hydra-nav/body)

(defun kill-ring-save-keep-selection ()
    "Just like `kill-ring-save' with arguments ARGS but keep selection."
    (interactive)
    (let (deactivate-mark)
      (call-interactively 'kill-ring-save)
      (message "Saved to kill ring")
      (run-at-time 0.5 nil (lambda () (message nil)))
      ))

(defhydra hydra-nav
  (:color red :pre (set-mark-if-inactive) :hint nil)
"--- navigate yo ----------------------------------------------------------------"
  ("q"      nil                         :color blue)
  ("w"      kill-ring-save-keep-selection)
  ("e"      end-of-line-or-block)
  ("r"      kill-region)
  ("t"      mc/mark-next-like-this)
  ("u"      undo-tree-undo)
  ("U"      undo-tree-redo)
  ("o"      other-window) ;; no
  ("p"      benjamin/pop-to-mark-command) ;; doesnt work

  ("a"      beginning-of-line-or-block)
  ("s"      swiper)
  ("d"      mark-defun)
  ("f"      forward-to-word)
  ("g"      avy-goto-word-or-subword-1)
  ("h"      backward-char)  ;; nah
  ("j"      next-line)
  ("k"      previous-line)
  ("l"      avy-goto-char-in-line)

  ("b"      left-word)

  ("E"      simplified-end-of-buffer)
  ("U"      scroll-down-command)

  ("A"      simplified-beginning-of-buffer)
  ("D"      scroll-up-command)
  ("G"      goto-line-with-feedback)
  ("L"      avy-goto-line)

  ("1"      (lambda () (interactive) (execute-kbd-macro (kbd "C-1"))))
  ("2"      (lambda () (interactive) (execute-kbd-macro (kbd "C-2"))))
  ("3"      (lambda () (interactive) (execute-kbd-macro (kbd "C-3"))))
  ("4"      (lambda () (interactive) (execute-kbd-macro (kbd "C-4"))))
  ("5"      (lambda () (interactive) (execute-kbd-macro (kbd "C-5"))))
  ("6"      (lambda () (interactive) (execute-kbd-macro (kbd "C-6"))))
  ("7"      (lambda () (interactive) (execute-kbd-macro (kbd "C-7"))))
  ("8"      (lambda () (interactive) (execute-kbd-macro (kbd "C-8"))))
  ("9"      (lambda () (interactive) (execute-kbd-macro (kbd "C-9"))))

  ("<f9>"   exchange-point-and-mark)
  ("<f10>"  er/expand-region)
  ("-"      er/contract-region)
  ("SPC"    (lambda () (interactive) (deactivate-mark)))
  )


(defvar nav-mode-map (make-sparse-keymap)
  "Map for `nav-mode'.")

(global-set-key (kbd "<f9>") 'nav-mode)

(defun benjamin/nav-mode-toggle-hl-line ()
  (if nav-mode
      (progn (hl-line-mode)
             ;; (set (make-local-variable 'hl-line) '((t :background "gray"))))
             (setq hl-line '((t :background "gray"))))
    (hl-line-mode -1)))

(setq nav-mode-hook nil)
(add-hook 'nav-mode-hook 'benjamin/nav-mode-toggle-hl-line)

(defvar nav-mode--prev-cursor-type t)
(setq nav-mode--prev-cursor-type t)
(define-minor-mode nav-mode
  "Toggle Counsel mode on or off.
Turn Counsel mode on if ARG is positive, off otherwise. Counsel
mode remaps built-in emacs functions that have counsel
replacements. "
  :group 'nav-mode
  :global nil
  :keymap nav-mode-map
  :lighter " nav"
  (if nav-mode
      (progn (let ((inhibit-message t))
               (set-mark-if-inactive))
             (setq nav-mode--prev-cursor-type cursor-type)
             (setq-local cursor-type '(hbar . 7)))
    ;; (hl-line-mode -1)
    (setq-local cursor-type nav-mode--prev-cursor-type)
    ;; (when hl-line-mode (hl-line-mode -1))
    ))

(define-key nav-mode-map (kbd "q") 'left-word)
(define-key nav-mode-map (kbd "w") 'kill-ring-save-keep-selection) ;;
(define-key nav-mode-map (kbd "e") 'end-of-line-or-block)
(define-key nav-mode-map (kbd "r") 'recenter-top-bottom)
(define-key nav-mode-map (kbd "t") 'exchange-point-and-mark);;
;; (define-key nav-mode-map (kbd "y") (lambi (let ((deactivate-mark)) (yank))))
(define-key nav-mode-map (kbd "u") 'scroll-down-command)
(define-key nav-mode-map (kbd "i") 'benjamin/mark-inside-pairs)
(define-key nav-mode-map (kbd "o") (lambi (minibuffer-with-setup-hook 'nav-mode
                                            (swiper (thing-at-point 'word)))))
(define-key nav-mode-map (kbd "p") (lambi (minibuffer-with-setup-hook 'nav-mode
                                            (swiper (thing-at-point 'symbol)))))
(define-key nav-mode-map (kbd "<f9>") 'exchange-point-and-mark) ;; [

(define-key nav-mode-map (kbd "a") 'beginning-of-line-or-block)
(define-key nav-mode-map (kbd "s") 'counsel-grep-or-swiper)
(define-key nav-mode-map (kbd "d") 'beginning-of-defun)
(define-key nav-mode-map (kbd "f") 'forward-to-word)
(define-key nav-mode-map (kbd "g") (lambi (push-mark-no-activate)
                                          (avy-goto-word-or-subword-1)))
(define-key nav-mode-map (kbd "h") 'backward-char)
(define-key nav-mode-map (kbd "j") 'next-line)
(define-key nav-mode-map (kbd "k") 'previous-line)
(define-key nav-mode-map (kbd "l") 'forward-char)
;; (define-key nav-mode-map (kbd ";") 'forward-char)
;; (define-key nav-mode-map (kbd "'") 'forward-char)

(define-key nav-mode-map (kbd "z") 'copy-symbol-at-point)
(define-key nav-mode-map (kbd "x")  ctl-x-map)
(define-key nav-mode-map (kbd "c") 'goto-last-change)
(define-key nav-mode-map (kbd "v") 'scroll-up-command)
;; (define-key nav-mode-map (kbd "b") 'switch-to-buffer)
(define-key nav-mode-map (kbd "n") 'avy-goto-char-in-line)
(define-key nav-mode-map (kbd "m") 'mark-line) ;;
;; (define-key nav-mode-map (kbd ",") 'mark-line) ;;
;; (define-key nav-mode-map (kbd ".") 'mark-line) ;;
;; (define-key nav-mode-map (kbd "/") 'mark-line) ;;

(define-key nav-mode-map (kbd "Q") (lambi (forward-whitespace -1)))
(define-key nav-mode-map (kbd "W") 'widen)
(define-key nav-mode-map (kbd "E") 'simplified-end-of-buffer)
(define-key nav-mode-map (kbd "I") (lambi (nav-mode -1)(iedit-mode)))
(define-key nav-mode-map (kbd "O") 'narrow-to-region)
(define-key nav-mode-map (kbd "P") 'previous-error)

(define-key nav-mode-map (kbd "A") 'simplified-beginning-of-buffer)
(define-key nav-mode-map (kbd "S") (lambi (swiper (thing-at-point 'symbol))))
(define-key nav-mode-map (kbd "D") 'scroll-up-command)
(define-key nav-mode-map (kbd "F") (lambi (forward-whitespace 1)))
(define-key nav-mode-map (kbd "G") 'goto-line-with-feedback)
(define-key nav-mode-map (kbd "H") (lambi (let ((deactivate-mark)))
                                          (mark-paragraph)))
(define-key nav-mode-map (kbd "K") 'kill-line)
(define-key nav-mode-map (kbd "L") 'avy-goto-line)

(define-key nav-mode-map (kbd "Z") 'copy-word-at-point)
(define-key nav-mode-map (kbd "C") 'goto-last-change-reverse)
(define-key nav-mode-map (kbd "N") 'next-error)

(define-key nav-mode-map (kbd "1") (lambi (execute-kbd-macro (kbd "C-1"))))
(define-key nav-mode-map (kbd "2") (lambi (execute-kbd-macro (kbd "C-2"))))
(define-key nav-mode-map (kbd "3") (lambi (execute-kbd-macro (kbd "C-3"))))
(define-key nav-mode-map (kbd "4") (lambi (execute-kbd-macro (kbd "C-4"))))
(define-key nav-mode-map (kbd "5") (lambi (execute-kbd-macro (kbd "C-5"))))
(define-key nav-mode-map (kbd "6") (lambi (execute-kbd-macro (kbd "C-6"))))
(define-key nav-mode-map (kbd "7") (lambi (execute-kbd-macro (kbd "C-7"))))
(define-key nav-mode-map (kbd "8") (lambi (execute-kbd-macro (kbd "C-8"))))
(define-key nav-mode-map (kbd "9") (lambi (execute-kbd-macro (kbd "C-9"))))

(define-key nav-mode-map (kbd "?") help-map)
(define-key nav-mode-map (kbd "<f10>") 'er/expand-region)
(define-key nav-mode-map (kbd "SPC")   'set-mark-command)
(define-key nav-mode-map (kbd "RET") (lambi (deactivate-mark) (nav-mode -1)))

;; (add-hook 'find-file-hook 'nav-mode)

(provide 'some-hydras)
;;; some-hydras.el ends here
