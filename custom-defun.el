(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

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

(defun benjamin/set-mark-command ()
  (interactive)
  (if (region-active-p)
      (deactivate-mark)
    (set-mark-command))
  )

(defun simplified-end-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-max)))
(defun simplified-beginning-of-buffer ()
  "Move point to the beginning of the buffer;
     leave mark at previous position."
  (interactive)
  (push-mark)
  (goto-char (point-min)))


(defun xah-beginning-of-line-or-block ()
  "Move cursor to beginning of line or previous paragraph.

• When called first time, move cursor to beginning of char in current line. (if already, move to beginning of line.)
• When called again, move cursor backward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2017-05-13"
  (interactive)
  (let (($p (point)))
    (if (or (equal (point) (line-beginning-position))
            (equal last-command this-command ))
        (if (backward-paragraph)
            (progn
              (skip-chars-backward "\n\t ")
              (forward-char ))
          (goto-char (point-min)))
      (progn
        (back-to-indentation)
        (when (eq $p (point))
          (beginning-of-line))))))

(defun xah-end-of-line-or-block ()
  "Move cursor to end of line or next paragraph."
  (interactive)
  (if (or (equal (point) (line-end-position))
          (equal last-command this-command ))
      (forward-paragraph)
    (end-of-line)))

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input."
  (interactive)
  (defvar goto/line 0)
  (unwind-protect
      (progn
        (nlinum-mode 1)
        (setq goto/line (read-number "Goto line: "))
        (goto-char (point-min))
        (forward-line (1- goto/line)))
    (nlinum-mode -1)))

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
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun my-i3-make-frame ()
  "i3 integration, create new emacs frames tiled the way we want with i3-msg"
  (interactive)
  (shell-command "/bin/bash ~/.config/split_optimal.sh")
  (make-frame-command))

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(defun modi/revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
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


(defun set-mark-and-deactive ()
  (interactive
  (push-mark)
  (deactive-mark) ;; huh?
  ))

(defun exchange-point-and-mark-and-deactive ()
  (interactive)
  (exchange-point-and-mark)
  (keyboard-quit))

(defun volatile-kill-buffer ()
   "Kill current buffer unconditionally."
   (interactive)
   (let ((buffer-modified-p nil))
     (kill-buffer (current-buffer))))

(defun open-next-line (arg)
      "Move to the next line and then opens a line.
    See also `newline-and-indent'."
      (interactive "p")
      (end-of-line)
      (open-line arg)
      (next-line 1)
      (when newline-and-indent
        (indent-according-to-mode)))

;; todo
(defun benjamin/other-window-or-frame (arg)
  "`other-frame', if `one-window-p'; otherwise, `other-window'."
  (interactive "p")
  (if (one-window-p) (other-frame arg) (other-window arg)))
