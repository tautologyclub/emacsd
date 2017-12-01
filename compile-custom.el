;;;; commenting out because there's too many fringe cases
;;;; that are deal breaking...
;; (setq compilation-finish-functions 'compile-autoclose)

(defun compile-autoclose (buffer string)
   (cond ((string-match "finished" string)
          (message "Build maybe successful: closing window.")
          (run-with-timer 2 nil
                          'delete-window
                          (get-buffer-window buffer t)))
         (t
          (message "Compilation exited abnormally: %s" string))))
