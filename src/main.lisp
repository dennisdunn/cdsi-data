(in-package :cl-user)

(defpackage :cdsi-data
  (:use :cl
        :cdsi-data/config)
  (:export :list-antigens
           :list-schedules
           :get-antigen
           :get-schedule))

(in-package :cdsi-data)

(defun list-antigens ()
  "Return a list of antigen names."
  (remove-if #'null
      (mapcar (lambda (fname)
                (ppcre:register-groups-bind (antigen)
                                            (*antigen-file-re* (namestring fname))
                                            antigen))
          (uiop:directory-files *data-path*))))

(defun get-antigen (id)
  "Load and parse the antigen file identified by the name."
  (let* ((fname (ppcre:regex-replace "[(.*)]+" *antigen-file-re* id))
         (path (merge-pathnames *data-path* fname)))
    (xmls:parse (uiop:read-file-string path))))

(defun list-schedules ()
  (mapcar #'xmls:node-name (xmls:xmlrep-children (load-schedule))))

(defun get-schedule (id)
  (xmls:xmlrep-children (find-if #'(lambda (node)
                                     (string= id (xmls:node-name node)))
                          (xmls:xmlrep-children (load-schedule)))))

(defun load-schedule ()
  "Load the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))
