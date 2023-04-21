(in-package :cl-cdsi-support)

(defun get-data ()
  "Get the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))
