;;; package --- summary
;;; feebleline.el

;; Copyright 2018 Benjamin Lindqvist

;; Author: Benjamin Lindqvist <benjamin.lindqvist@gmail.com>
;; Maintainer: Benjamin Lindqvist <benjamin.lindqvist@gmail.com>
;; URL: https://github.com/tautologyclub/feeblel
;; Package-Version:
;; Version: 1.0

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; For hardline Luddite editing!

;; Feebleline removes the modeline and replaces it with a slimmer proxy
;; version, which displays some basic information in the echo area
;; instead.  This information is only displayed if the echo area is not used
;; for anything else.

;;; Code:

(defvar feebleline/default-log-max)
(setq feebleline/default-log-max message-log-max)
(defun message-buffer-file-name-or-nothing ()
  "Mode line proxy."
  (unwind-protect
      (progn
        (setq message-log-max nil)
        (if buffer-file-name
            (message "[%s] (%s:%s) %s"
                     (format-time-string "%H:%M:%S")
                     (string-to-number (format-mode-line "%l"))
                     (current-column)
                     (buffer-file-name)
                     )))
    (setq message-log-max feebleline/default-log-max)))

(defun mode-line-proxy-fn ()
  "Put a mode-line proxy in the echo area if echo area is empty."
  (if (not (current-message))
      (message-buffer-file-name-or-nothing)))

(run-with-timer 0 0.1 'mode-line-proxy-fn)

(defadvice handle-switch-frame (after switch-frame-message-name)
  "Get the modeline proxy to work with i3 switch focus."
  (message-buffer-file-name-or-nothing)
  ad-do-it
  (message-buffer-file-name-or-nothing))
(ad-activate 'handle-switch-frame)

(add-hook 'focus-in-hook 'mode-line-proxy-fn)

(provide 'feebleline)

;;; feebleline.el ends here
