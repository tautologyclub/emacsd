
;;; Code:

;; from wiki, with some modifications
;-------------------------------------------------------------------------------
;;;###autoload
(defun last-term-buffer (l)
  "Return most recently used term buffer L."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

;;;###autoload
(defun get-term ()
  "Switch to the term buffer last used or get a new one."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

;;;###autoload
(defun term-toggle-mode-w/warning ()
  "Toggle term between line mode and char mode (super bad)."
  (interactive)
  (if (term-in-line-mode)
      (progn
        (term-char-mode)
        (setq header-line-format nil)
        )
    (progn
      (term-line-mode)
      (let* ((warning "   *** Line Mode ***   ")
             (space (+ 6 (- (window-width) (length warning))))
             (bracket (make-string (/ space 2) ?-))
             (warning (concat bracket warning bracket)))
        (setq header-line-format
              (propertize
	       warning 'face '(:foreground "white" :background "red3")))))))
;-------------------------------------------------------------------------------

;;;###autoload
(defun term-toggle-mode ()
  "Toggle term between line mode and char mode."
  (interactive)
  (if (term-in-line-mode)
      (progn (set-cursor-color original-cursor-color) ;; fixme don't jox with global stuff...
             (term-char-mode))
    (progn (set-cursor-color "yellow")
           (term-line-mode))))

;;;###autoload
(defun dropdown-multiterm ()
  "Split window below, open a terminal and move focus to it."
  (interactive)
  (split-window-below)
  (windmove-down)
  (multi-term))

;;;###autoload
(defun dropdown-multiterm-right ()
  "Split windowright, open a terminal and move focus to it."
  (interactive)
  (split-window-right)
  (windmove-right)
  (multi-term))


;; shell scripting convenience
;-------------------------------------------------------------------------------
;;;###autoload
(defun dropdown-launch-me ()
  "Run current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (shell-command (concat "chmod a+x " buffer-file-name))
    (dropdown-multiterm)
    (term-send-raw-string (concat "./" tmp-filename ""))))
;;;###autoload
(defun dropdown-source-me ()
  "Source current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (dropdown-multiterm)
    (term-send-raw-string (concat ". " tmp-filename ""))))
;;;###autoload
(defun multiterm-launch-me ()
  "Run current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (shell-command (concat "chmod a+x " buffer-file-name))
    (multi-term)
    (term-send-raw-string (concat "./" tmp-filename ""))))
;;;###autoload
(defun multiterm-source-me ()
  "Source current buffer-file in a dropdown term."
  (interactive)
  (let ((tmp-filename (format "%s" (file-name-nondirectory buffer-file-name))))
    (multi-term)
    (term-send-raw-string (concat ". " tmp-filename ""))))

;;;###autoload
(defun benjamin/sh-hook ()
  "My hook for shell mode."
  (local-set-key (kbd "C-c C-c") 'dropdown-launch-me)
  (local-set-key (kbd "C-c C-.") 'dropdown-source-me)
  (local-set-key (kbd "C-c C-t") 'multiterm-launch-me)
  (local-set-key (kbd "C-c C-,") 'multiterm-source-me)
  )

;-------------------------------------------------------------------------------
;; TODO - script/terminal association


;; Renaming term buffers
;-------------------------------------------------------------------------------
(defvar counsel-term--home-dir (expand-file-name "~"))
(defvar benjamin/term-rename-suffix "]")
(defvar benjamin/term-rename-prefix "")
(setq benjamin/term-rename-prefix ": ")

;;;###autoload
(defun benjamin/term-renamer ()
  "Eat poop."
  (concat benjamin/term-rename-prefix
          (replace-regexp-in-string
           counsel-term--home-dir "~"
           default-directory
           )
          benjamin/term-rename-suffix
))

(require 'switch-buffer-functions)
(add-hook
 'term-mode-hook
 (lambda ()
   (add-hook (make-local-variable 'switch-buffer-functions)
	     (lambda (prev cur) (rename-buffer (benjamin/term-renamer) t)))))
;-------------------------------------------------------------------------------
;; TODO:
;;	- make this a minor-mode
;;	- counsel-switch-term


;; colorize term-mode buffers in counsel
;-------------------------------------------------------------------------------
(defface counsel-buffer-face-term-mode
  '((t :inherit 'font-lock-keyword-face :bold t))
  "Face for term-buffers under counsel buffer switch.")

(add-to-list 'ivy-switch-buffer-faces-alist
             '(term-mode . counsel-buffer-face-term-mode))

;;;###autoload
(defun benjamin/get-term ()
  "Just kind of a better get-term if you want zany renaming."
  (interactive)
  (let ((term-buffer-candidate (benjamin/term-renamer)))
    (if (get-buffer term-buffer-candidate)
        (switch-to-buffer term-buffer-candidate)
      (message (concat "New term-buffer @ " default-directory))
      (multi-term))))

(provide 'term-addons)
;;; term-addons.el ends here
