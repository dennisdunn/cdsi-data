(in-package :cl-user)

(defpackage :cdsi-data/schedule
  (:use :cl
        :cdsi-data/config)
  (:export :list-schedules
           :get-schedule))

(in-package :cdsi-data/schedule)

(defun list-schedules ()
  (mapcar #'xmls:node-name (xmls:xmlrep-children (load-schedule))))

(defun get-schedule (id)
  (xmls:xmlrep-children (find-if #'(lambda (node)
                                     (string= id (xmls:node-name node)))
                          (xmls:xmlrep-children (load-schedule)))))

(defun load-schedule ()
  "Load the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))
