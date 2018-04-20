
(defun kill-thing-at-point (thing)
  (let ((bounds (bounds-of-thing-at-point thing)))
    bounds (kill-region (car bounds) (cdr bounds))))

(defun kill-word-at-point ()
  (interactive)
  (kill-thing-at-point 'word))

(defun kill-symbol-at-point ()
  (interactive)
  (kill-thing-at-point 'symbol))

(defun kill-sexp-at-point ()
  (interactive)
  (kill-thing-at-point 'sexp))

(defun kill-list-at-point ()
  (interactive)
  (kill-thing-at-point 'list))

(defun kill-string-at-point ()
  (interactive)
  (kill-thing-at-point 'string))

(defun kill-inner ()
  (interactive)
  (if (er--point-inside-string-p)
      (save-excursion (er/mark-inside-quotes)
                      (call-interactively 'kill-region))
  (let ((bounds (bounds-of-thing-at-point 'list))) bounds
       (let ((beg (car bounds)))
         (kill-region (+ 1 beg) (- (cdr bounds) 1))
         (if (equal (point) beg)
             (forward-char 1))))))

(defun crux-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%S" value))))

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


(defun delete-window-or-frame (&optional window frame force)
  "Delete WINDOW, or FRAME if only window.  FORCE feed me to the ducks."
  (interactive)
  (if (= 1 (length (window-list frame)))
      (delete-frame frame force)
    (delete-window window)))

(defun murder-buffer-with-window ()
  "Kill buffer, kill window, don't prompt, just do it.  Unless buffer modified."
  (interactive)
  (volatile-kill-buffer)
  (delete-window-or-frame))

(defun kill-region-or-line ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-line)))

(require 'expand-region)
(defun benjamin/mark-inside-pairs ()
  "Go fuck yourself."
  (interactive)
  (if (er--point-inside-pairs-p)
      (er/mark-inside-pairs)
    (er/mark-outside-pairs)))

(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(defun clear-text-properties-from-buffer ()
  "Remove all text properties from the buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (set-text-properties (point-min) (point-max) nil))
  )

(defun open-line-indent (n)
  "Insert a new line and leave point before it.

With arg N insert N newlines."
  (interactive "*p")
  (save-excursion
    (newline n)
    (indent-according-to-mode)))

(defun open-next-line (arg)
  "Move to the next line and then opens a line.  ARG times or once.

    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (newline-and-indent))

(defun copy-keep-highlight (beg end)
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))

(defun benjamin/pop-to-mark-command ()
  "Pop mark ring, unless empty, pop global mark ring if so."
  (interactive)
  (if (null (mark t))
      (pop-global-mark)
    (if (= (point) (mark t))
	(message "Mark popped"))
    (goto-char (mark t))
    (pop-mark)))

(defun benjamin/find-file-other-frame ()
  "Open file in new frame, but do it optimally."
  (interactive)
  (shell-command "/bin/bash ~/.config/split_optimal.sh")
  (call-interactively 'find-file-other-frame)
  )

(defun benjamin/set-mark-command ()
  (interactive)
  (if (region-active-p) ()
    (set-mark-command nil))
  (exchange-point-and-mark)
  )

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

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
  "Don't deactivate mark when commenting."
      (setq deactivate-mark nil))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
      (beginning-of-line)))

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
(defun blq/brackets ()
  (interactive)
  (cond ((eq major-mode 'term-mode)
         (term-send-raw-string "[]")
         (term-send-raw-string ""))
        ((region-active-p)
         (lispy--surround-region "[" "]"))
        (
         (self-insert-command 1)
         (insert "]")
         (backward-char))))

(defun blq/parens ()
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
         (self-insert-command 1)
         (insert "")
         (backward-char))))

;----- source: oremacs ---------------------------------------------------------

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

(defun kill-to-beginning-of-indentation-or-line ()
  "Kill to beginning of indentation, or line if already at beginning of indentation."
  (interactive)
  (kill-region (save-excursion (back-to-indentation-or-beginning) (point))
               (point)))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

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

(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

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

(defface find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")
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

(add-hook 'find-file-hook 'find-file-root-header-warning)
(add-hook 'dired-mode-hook 'find-file-root-header-warning)


(defun mark-line ()
  (interactive)
  (beginning-of-line)
  (set-mark-if-inactive)
  (end-of-line)
  (forward-char)
  )

(defun goto-next-line-with-same-indentation ()
  (interactive)
  (back-to-indentation)
  (re-search-forward (s-concat "^" (s-repeat (current-column) " ") "[^ \t\r\n\v\f]")
                     nil nil (if (= 0 (current-column)) 2 1))
  (back-to-indentation))

(defun goto-prev-line-with-same-indentation ()
  (interactive)
  (back-to-indentation)
  (re-search-backward (s-concat "^" (s-repeat (current-column) " ") "[^ \t\r\n\v\f]"))
  (back-to-indentation))
