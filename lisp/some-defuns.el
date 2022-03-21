
(require 'expand-region)

;;;###autoload
(defun paste-shell-stdout (cmd)
  (interactive "sCommand: ")
  (insert (shell-command-to-string cmd))
  (backward-delete-char 1))

;;;###autoload
(defun rotate-windows ()
  "Rotate your windows, courtesy of Magnar Sveen."
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* ((w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))
                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))
                  (s1 (window-start w1))
                  (s2 (window-start w2)))
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun open-file-existing-other-window ()
  "Like title say."
  (interactive)
  (let ((split-height-threshold 1000)
        (split-width-threshold 10000))
    (call-interactively 'find-file-other-window)))

;;;###autoload
(defun fake-C-c ()
  "Fakes the user typing Ctrl-c."
  (interactive)
  (setq unread-command-events (nconc (listify-key-sequence (kbd "C-c"))
                                     unread-command-events)))
;;;###autoload
(defun fake-C-x ()
  "Fakes the user typing Ctrl-x."
  (interactive)
  (setq unread-command-events (nconc (listify-key-sequence (kbd "C-x"))
                                     unread-command-events)))

(defvar benjamin/rec-grep-command "grep --color -nHRi -e ")
(setq benjamin/rec-grep-command "grep --color -nHriI --max-count=1200 --include \\*.\\* ")
(defvar benjamin/rec-grep-with-case-command "grep --color -nHRi -e ")
(setq benjamin/rec-grep-with-case-command "grep --color -nHrI --include \\*.\\* ")

;;;###autoload
(defun benjamin/rec-grep ()
  "Recursively grep, ignore case."
  (interactive)
  (grep (read-from-minibuffer "grep: " benjamin/rec-grep-command)))

;;;###autoload
(defun benjamin/rec-grep-with-case ()
  "Recursively grep, match case."
  (interactive)
  "Recursively grep, ignore case."
  (grep (read-from-minibuffer "grep: " benjamin/rec-grep-with-case-command)))

;;;###autoload
(defun benjamin/previous-buffer ()
  (interactive)
  ;; FIXME: Skip buffers according to regexp
  (previous-buffer)
  )

;;;###autoload
(defun benjamin/next-buffer ()
  (interactive)
  (next-buffer)
  )

;;;###autoload
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

;;;###autoload
(defun unfill-paragraph ()
  "Take a multi-line paragraph and make it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;;;###autoload
(defun benjamin/notify (arg)
  "Notify user of ARG using shell cmd notify-send."
  (shell-command (format "notify-send -t 1000 '%s'" arg)))

;;;###autoload
(defun crux-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%S" value))))

;;;###autoload
(defun ediff-current-buffer (buffer-A buffer-B &optional startup-hooks job-name)
  "Run Ediff on a pair of buffers, BUFFER-A and BUFFER-B."
  (interactive
   (let (bf)
     (list (setq bf (current-buffer))
	   (read-buffer "Buffer B to compare: "
			(progn
			  ;; realign buffers so that two visible bufs will be
			  ;; at the top
			  (save-window-excursion (other-window 1))
			  (ediff-other-buffer bf))
			t))))
  (or job-name (setq job-name 'ediff-buffers))
  (ediff-buffers-internal buffer-A buffer-B nil startup-hooks job-name))

;;;###autoload
(defun delete-window-or-frame (&optional window frame force)
  "Delete WINDOW, or FRAME if only window.  FORCE feed me to the ducks."
  (interactive)
  (if (= 1 (length (window-list frame)))
      (delete-frame frame force)
    (delete-window window)))

;;;###autoload
(defun volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))))

;;;###autoload
(defun murder-buffer-with-window ()
  "Kill buffer, kill window, don't prompt, just do it.  Unless buffer modified."
  (interactive)
  (volatile-kill-buffer)
  (delete-window-or-frame))

;;;###autoload
(defun kill-region-or-line ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-line)))

;;;###autoload
(defun benjamin/mark-inside-pairs ()
  "Go fuck yourself."
  (interactive)
  (if (equal last-command 'benjamin/mark-inside-pairs)
      (call-interactively 'er/expand-region)
    (if (er--point-inside-string-p)
        (er/mark-inside-quotes)
      (if (er--point-inside-pairs-p)
          (er/mark-inside-pairs)
        (er/mark-outside-pairs)))))

;;;###autoload
(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

;;;###autoload
(defun clear-text-properties-from-buffer ()
  "Remove all text properties from the buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (set-text-properties (point-min) (point-max) nil))
  )

;;;###autoload
(defun open-line-indent (n)
  "Insert a new line and leave point before it.

With arg N insert N newlines."
  (interactive "*p")
  (save-excursion
    (newline n)
    (indent-according-to-mode)))

;;;###autoload
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;;;###autoload
(defun copy-keep-highlight (beg end)
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))

;;;###autoload
(defun benjamin/pop-to-mark-command ()
  "Pop mark ring, unless empty, pop global mark ring if so."
  (interactive)
  (if (null (mark t))
      (pop-global-mark)
    (if (= (point) (mark t))
	    (message "Mark popped"))
    (goto-char (mark t))
    (pop-mark)))

;;;###autoload
(defun benjamin/find-file-other-frame ()
  "Open file in new frame, but do it optimally."
  (interactive)
  (shell-command "/bin/bash ~/.config/split_optimal.sh")
  (call-interactively 'find-file-other-frame)
  )

;;;###autoload
(defun benjamin/set-mark-command ()
  (interactive)
  (if (region-active-p) ()
    (set-mark-command nil))
  (exchange-point-and-mark))

;;;###autoload
(defun benjamin/indent-buffer ()
  "Indent entire buffer according to mode."
  (interactive)
  (indent-region (point-min) (point-max)))

;;;###autoload
(defun benjamin/indent-a-bit-around-point ()
  "Indent some suitably large area around point according to mode."
  (interactive)
  (indent-region (- (point) 800) (+ (point) 400))
  (message nil))

;;;###autoload
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;;;###autoload
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (unless (region-active-p)
      (forward-line 1))))

;;;###autoload
(defadvice comment-or-uncomment-region-or-line (after deactivate-mark-nil
                                                      activate)
  "Don't deactivate mark when commenting."
      (setq deactivate-mark nil))

;;;###autoload
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

;;;###autoload
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
      (beginning-of-line)))

;;;###autoload
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

;;;###autoload
(defun upcase-word-toggle ()
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol))
        (regionp
         (if (eq this-command last-command)
             (get this-command 'regionp)
           (put this-command 'regionp nil)))
        beg end)
    (cond
      ((or (region-active-p) regionp)
       (setq beg (region-beginning)
             end (region-end))
       (put this-command 'regionp t))
      (bounds
       (setq beg (car bounds)
             end (cdr bounds)))
      (t
       (setq beg (point)
             end (1+ beg))))
    (save-excursion
      (goto-char (1- beg))
      (and (re-search-forward "[A-Za-z]" end t)
           (funcall (if (char-upcasep (char-before))
                        'downcase-region
                      'upcase-region)
                    beg end)))))

;;;###autoload
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
            (point))))
  (message "Kill-saved line"))

;;;###autoload
(defun yank-after-cursor ()
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'yank)
    )
  )

;;;###autoload
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

;;;###autoload
(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

;;;###autoload
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;;###autoload
(defun copy-current-file-path ()
  "Add current file path to kill ring. Limits the filename to project root if possible."
  (interactive)
  (kill-new (buffer-file-name)))

;;;###autoload
(defun copy-current-dir-path ()
  "Add current file path to kill ring. Limits the filename to project root if possible."
  (interactive)
  (let ((filename (file-name-directory (buffer-file-name))))
    (kill-new filename)))

;;;###autoload
(defun sudo-edit-current ()
  (interactive)
  (find-file (concat "/sudo:root@localhost:" buffer-file-name)))

;;;###autoload
(defun char-upcasep (letter)
  (eq letter (upcase letter)))

;;;###autoload
(defun capitalize-word-toggle ()
  "Toggle case on first letter of word at point."
  (interactive)
  (if (looking-at "\\<")
      (progn (forward-char 1)
             (call-interactively 'capitalize-word-toggle)
             (forward-char -1))
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
  )

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

;;;###autoload
(defun scroll-up-half ()
  (interactive)
     (scroll-up (window-half-height)))

;;;###autoload
(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

;;;###autoload
(defun kill-region-or-backward-word ()
  "Kill selected region if region is active. Otherwise kill a backward word."
  (interactive)
  (if (region-active-p)
	  (kill-region (region-beginning) (region-end))
	(backward-kill-word 1)))

;;;###autoload
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))


(defvar benjamin/last-char-jumped-to nil)
(defun benjamin/jump-char-fwd (arg)
  (interactive "p")
  ;; (message "%s" last-command)
  (if (or (equal last-command this-command)
          (equal last-command 'benjamin/jump-char-bwd))
      (fastnav-search-char-forward 1 benjamin/last-char-jumped-to)
    (progn
      (fastnav-jump-to-char-forward arg)
      (setq benjamin/last-char-jumped-to (char-after (point))))
    )
  )
(defun benjamin/jump-char-bwd (arg)
  (interactive "p")
  ;; (message "%s" last-command)
  (if (or (equal last-command this-command)
          (equal last-command 'benjamin/jump-char-fwd))
      (fastnav-search-char-forward -1 benjamin/last-char-jumped-to)
    (progn
      (fastnav-jump-to-char-backward arg)
      (setq benjamin/last-char-jumped-to (char-after (point))))
    )
  )

;;;###autoload
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

;;;###autoload
(defun forward-to-word (arg)
  "Move forward until encountering the beginning of a word.
With argument, do this that many times."
  (interactive "^p")
  (or (re-search-forward
       (if (> arg 0) "\\W\\b" "\\b\\W") nil t arg)
      (goto-char
       (if (> arg 0) (point-max) (point-min)))))

;;;###autoload
(defun forward-word-or-eol ()
  (interactive)
  (if (looking-at "\\W+\n")
      (when (search-forward-regexp "\n" nil 'noerror)
        (goto-char (match-beginning 0)))
    (forward-word)))

;;;###autoload
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

(require 'hungry-delete)

;;;###autoload
(defun benjamin/kill-word (arg)
  "If point is at word, kill characters forward until encountering the end of a word.
If point not at word, kill until a non-blank char is found.
With argument ARG, do this that many times."
  (interactive "p")
  (if (word-at-point)
      (kill-word arg)
    (hungry-delete-forward arg)))

;;;###autoload
(defun benjamin/backward-kill-word (arg)
  "Like kill-word but backwards.  Do it ARG many times blabla."
  (interactive "p")
  (if (word-at-point)
      (backward-kill-word arg)
    (hungry-delete-backward arg)))

;;;###autoload
(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;;;###autoload
(defun kill-to-beginning-of-indentation-or-line ()
  "Kill to beginning of indentation, or line if already at indentation.

If already at beginning of line, do the same for previous line."
  (interactive)
  (if (bolp) (backward-delete-char 1)
    (kill-region
     (save-excursion
       (back-to-indentation-or-beginning) (point))
     (point))))

;;;###autoload
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

;;;###autoload
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

;;;###autoload
(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

;;;###autoload
(defun create-scratch-buffer nil
  "create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)
    ))

;;;###autoload
(defface find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")

;;;###autoload
(defun find-file-root-header-warning ()
  "*Display a warning in header line of the current buffer.
This function is suitable to add to `find-file-hook'."
  (when (string-equal
         (file-remote-p (or buffer-file-name default-directory) 'user)
         "root")
    (let* ((warning "WARNING: EDITING FILE AS ROOT!")
           (space (+ 6 (- (window-width) (length warning))))
           (bracket (make-string (/ space 2) ?-))
           (warning (concat bracket warning bracket)))
      (setq header-line-format
            (propertize  warning 'face 'find-file-root-header-face)))))

;;;###autoload
(defun set-mark-if-inactive ()
  (interactive)
  (if (not (region-active-p))
      (set-mark-command nil)))

;;;###autoload
(defun mark-line ()
  (interactive)
  (beginning-of-line)
  (set-mark-if-inactive)
  (end-of-line)
  (forward-char)
  )

;;;###autoload
(defun goto-next-line-with-same-indentation ()
  (interactive)
  (back-to-indentation)
  (re-search-forward (s-concat "^" (s-repeat (current-column) " ") "[^ \t\r\n\v\f]")
                     nil nil (if (= 0 (current-column)) 2 1))
  (back-to-indentation))

;;;###autoload
(defun goto-prev-line-with-same-indentation ()
  (interactive)
  (back-to-indentation)
  (re-search-backward (s-concat "^" (s-repeat (current-column) " ") "[^ \t\r\n\v\f]"))
  (back-to-indentation))

;;;###autoload
(defun simplified-end-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-max)))

;;;###autoload
(defun simplified-beginning-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-min)))

;;;###autoload
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-back "[a-zA-z0-9]")
      (company-complete)
      ;; (completion-at-point)
    (indent-for-tab-command)
    ))

;;;###autoload
(defun beginning-of-line-or-block ()
  "Move cursor to beginning of line or previous paragraph."
  (interactive)
  (let (($p (point)))
    (if (equal (point) (line-beginning-position))
        (if (backward-paragraph)
            (progn
              (skip-chars-backward "\n\t ")
              (forward-char ))
          (goto-char (point-min)))
      (progn
        (back-to-indentation)
        (when (eq $p (point))
          (beginning-of-line))))))

;;;###autoload
(defun end-of-line-or-block ()
  "Move cursor to end of line or next paragraph."
  (interactive)
  (if (or (equal (point) (line-end-position))
          (equal last-command this-command ))
      (forward-paragraph)
    (end-of-line)))

;;;###autoload
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input."
  (interactive)
  (let ((git-gutter-was-enabled
         (and (fboundp git-gutter+-mode) git-gutter+-mode))
        (old-fringe-mode fringe-mode)
        (goto/line 0))
    (unwind-protect
        (let ((display-line-numbers 1))
          (fringe-mode 0)
          (git-gutter+-mode -1)
          (setq goto/line (read-number "Goto line: "))
          (goto-char (point-min))
          (forward-line (1- goto/line)))
      (if git-gutter-was-enabled (git-gutter+-mode 1))
      (fringe-mode old-fringe-mode))))

;;;###autoload
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (if (and mark-active (bolp))
        (setq end (- (point) 1))
      (setq end (line-end-position)))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (kill-ring-save beg end)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

;;;###autoload
(defun i3-make-frame ()
  "Create new frame tiled the way we want with i3-msg."
  (interactive)
  (shell-command "split_optimal")
  (make-frame-command))

;;;###autoload
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

;;;###autoload
(defun revert-all-file-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))

;;;###autoload
(defun set-mark-and-deactive ()
  (interactive
  (push-mark)
  (deactive-mark) ;; huh?
  ))

;;;###autoload
(defun exchange-point-and-mark-and-deactive ()
  (interactive)
  (exchange-point-and-mark)
  (keyboard-quit))

(require 'highlight)
;;;###autoload
(defun benjamin/highlight ()
  (interactive)
  (let ((old-point (point)))
    (unless (region-active-p)
      ;; use current line instead of whole buffer
      (let (p1 p2)
        (setq p1 (line-beginning-position))
        (setq p2 (line-end-position))
        (goto-char p1)
        (push-mark p2)
        (setq mark-active t)))
    (hlt-highlight)
    (deactivate-mark)
    (goto-char old-point)))

;;;###autoload
(defun benjamin/unhighlight-region ()
  (interactive)
  (if (region-active-p)
      (hlt-unhighlight-region)
    (message "No region!")))

;;;###autoload
(defun benjamin/insert-dashes ()
  (interactive)
  (while (< (current-column) 80)
    (insert "-")))

;;;###autoload
(defun benjamin/insert-c-doc ()
  (interactive)
  (goto-char (line-beginning-position))
  (insert "/** \n"
          " * @brief .\n"
          " *\n"
          " * .\n"
          " *\n"
          " * @param\n"
          " * @return\n"
          " */\n"
          )
  (forward-line -7)
  (forward-whitespace 1)
  )

(provide 'some-defuns)
