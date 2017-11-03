(defun yank-after-cursor ()
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'yank)
    )
  )

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
(define-key global-map (kbd "C-w") 'kill-region-or-backward-word)

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun goto-line-with-feedback (&optional line)
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive "P")
  (if line
      (goto-line line)
    (unwind-protect
        (progn
          (linum-mode 1)
          (goto-line (read-number "Goto line: ")))
      (linum-mode -1))))

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
