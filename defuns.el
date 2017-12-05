;; helps when you run us keyboard layout without a right bracket :P
(defun set-kblayout-swedish ()
  "Set layout to swedish."
  (interactive)
  (shell-command "setxkbmap -layout se"))
(defun set-kblayout-benjamin ()
  "Set layout to benjaminish."
  (interactive)
  (shell-command "setxkbmap us; xmodmap ~/.Xmodmap"))

(defun forward-to-char-after-ws ()
  "docstring"
  (interactive)
  (fastnav-search-char-forward 1 ? )
  (forward-char)
  (if (looking-at " ")
      (forward-to-word 1))
  )

(defun backward-to-char-before-ws ()
  "docstring"
  (interactive)
  (while (not (looking-at "[[:space:]]"))
    (backward-char))
  (backward-char)
  (if (looking-at "[[:space:]]")
      (backward-to-char-before-ws))
  )

;; kill current line if no region active
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; TOOGLE COMMENT FOR CURRENT LINE OR REGION
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defadvice comment-or-uncomment-region-or-line (after deactivate-mark-nil
                                                      activate)
  "Asdf.  Aaa..."
  (if (called-interactively-p interactive)
      (setq deactivate-mark nil)))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(defun back-to-indentation-or-beginning () (interactive)
       (if (= (point) (progn (back-to-indentation) (point)))
           (beginning-of-line)))

;; Transposing lines up/down
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))


(defun backward-kill-char-or-word ()
  "Not kill entire word if newline or backspace."
  (interactive)
  (cond
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))

(defun kill-line-save (&optional arg)
  "Copy to the kill ring from point to the end of the current line.
    With a prefix argument, copy that many lines from point. Negative
    arguments copy lines backward. With zero argument, copies the
    text before point to the beginning of the current line."
  (interactive "p")
  (save-excursion
    (copy-region-as-kill
     (point)
     (progn (if arg (forward-visible-line arg)
              (end-of-visible-line))
            (point)))))

(defun yank-after-cursor ()
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'yank)
    )
  )

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun copy-current-file-path ()
  "Add current file path to kill ring. Limits the filename to project root if possible."
  (interactive)
  (let ((filename (buffer-file-name)))
    (kill-new (if eproject-mode
                  (s-chop-prefix (eproject-root) filename)
                filename))))

(defun sudo-edit-current ()
  (interactive)
      (find-file (concat "/sudo:root@localhost:" buffer-file-name)))

(defun char-upcasep (letter)
  (eq letter (upcase letter)))

;; todo!!
(defun capitalize-word-toggle ()
  (interactive)
  (let ((start
         (car
          (save-excursion
            (backward-word)
            (bounds-of-thing-at-point 'symbol)))))
    (if start
        (save-excursion
          (goto-char start)
          (funcall
           (if (char-upcasep (char-after))
               'downcase-region
             'upcase-region)
           start (1+ start)))
      (capitalize-word -1))))

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
     (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(defun terminal-with-focus-below () (interactive)
       (split-window-below)
       (windmove-down)
       (multi-term))

(defun kill-region-or-backward-word ()
  "Kill selected region if region is active. Otherwise kill a backward word."
  (interactive)
  (if (region-active-p)
	  (kill-region (region-beginning) (region-end))
	(backward-kill-word 1)))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defvar benjamin/last-char-forward-jumped-to nil)
(defvar benjamin/last-char-backward-jumped-to nil)

(defun benjamin/jump-char-fwd (arg)
  (interactive "p")
  (if (or (equal last-command this-command)
          (eq last-command 'fastnav-jump-to-char-forward))
      (fastnav-search-char-forward 1 benjamin/last-char-forward-jumped-to)
    (progn
      (fastnav-jump-to-char-forward arg)
      (setq benjamin/last-char-forward-jumped-to (char-after (point))))
    )
  )

(defun benjamin/jump-char-bwd (arg)
  (interactive "p")
  (if (or (equal last-command this-command)
          (eq last-command 'fastnav-jump-to-char-forkward))
      (fastnav-search-char-forward -1 benjamin/last-char-backward-jumped-to)
    (progn
      (fastnav-jump-to-char-backward arg)
      (setq benjamin/last-char-backward-jumped-to (char-after (point))))
    )
  )

(defun zap-up-to-char (arg char)
  "Kill up to, but not including ARGth occurrence of CHAR.
Case is ignored if `case-fold-search' is non-nil in the current buffer.
Goes backward if ARG is negative; error if CHAR not found.
Ignores CHAR at point."
  (interactive "p\ncZap up to char: ")
  (let ((direction (if (>= arg 0) 1 -1)))
    (kill-region (point)
		 (progn
		   (forward-char direction)
		   (unwind-protect
		       (search-forward (char-to-string char) nil nil arg)
		     (backward-char direction))
		   (point)))))

(defun forward-to-word (arg)
  "Move forward until encountering the beginning of a word.
With argument, do this that many times."
  (interactive "^p")
  (or (re-search-forward
       (if (> arg 0) "\\W\\b" "\\b\\W") nil t arg)
      (goto-char
       (if (> arg 0) (point-max) (point-min)))))

(defun forward-word-or-eol ()
  (interactive)
  (if (looking-at "\\W+\n")
      (when (search-forward-regexp "\n" nil 'noerror)
        (goto-char (match-beginning 0)))
    (forward-word)))

(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

;;;###autoload
(defun ora-parens ()
  (interactive)
  (cond ((eq major-mode 'term-mode)
         (term-send-raw-string "()")
         (term-send-raw-string ""))
        ((region-active-p)
         (let ((beg (region-beginning))
               (end (region-end)))
           (goto-char end)
           (insert ")")
           (goto-char beg)
           (insert "(")
           (deactivate-mark)))
        ((looking-back "\\\\")
         (insert "(\\)")
         (backward-char 2))
        (t
         (if (or (looking-back "\\(if\\)\\|\\(for\\)\\|\\(switch\\)\\|\\(while\\)")
                 (eq major-mode 'sml-mode))
             (unless (looking-back " \\|\\[\\|(")
               (insert " ")))
         (insert "()")
         (backward-char))))

;;;###autoload
(defun ora-brackets ()
  (interactive)
  (cond ((eq major-mode 'term-mode)
         (term-send-raw-string "[]")
         (term-send-raw-string ""))
        ((region-active-p)
         (lispy--surround-region "[" "]"))
        (t
         (insert "[]")
         (backward-char))))

;;;###autoload
(defun ora-braces ()
  (interactive)
  (if (region-active-p)
      (progn
        (lispy--surround-region "{" "}")
        (backward-char)
        (forward-list))
    (insert "{}")
    (backward-char)))

;; smart nav
(require 'windmove)
(require 'framemove)
(defun benjamin/smart-left ()
  (interactive)
  (condition-case nil
      (windmove-left))
  (error (framemove-left) )
  )

(require 'hungry-delete)
(defun benjamin/kill-word (arg)
  "If point is at word, kill characters forward until encountering the end of a word.
If point not at word, kill until a non-blank char is found.
With argument ARG, do this that many times."
  (interactive "p")
  (if (word-at-point)
      (kill-word arg)
    (hungry-delete-forward arg)))

(defun benjamin/backward-kill-word (arg)
  "Like kill-word but backwards.  Do it ARG many times blabla."
  (interactive "p")
  (if (word-at-point)
      (backward-kill-word arg)
    (hungry-delete-backward arg)))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift return)] 'smart-open-line-above)
