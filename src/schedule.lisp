(in-package :cl-user)

(defpackage :cdsi-data/schedule
  (:nicknames :schedule)
  (:use :cl
        :cdsi-data/config)
  (:export :get-schedule))

(in-package :cdsi-data/schedule)


(defun get-schedule ()
  "Get the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))
