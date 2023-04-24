(in-package :cl-user)

(defpackage :cdsi-data/antigen
  (:nicknames :antigen)
  (:use :cl
        :cdsi-data/config)
  (:export :get-antigen
           :catalog))

(in-package :cdsi-data/antigen)

(defun get-antigen (id)
       "Load and parse the antigen file identified by the name."
       (let* ((fname (ppcre:regex-replace "[(.*)]+" *antigen-file-re* id))
              (path (merge-pathnames *data-path* fname)))
             (xmls:parse (uiop:read-file-string path))))

(defun catalog ()
       "Return a list of antigen names."
       (remove-if #'null
                  (mapcar (lambda (fname)
                                  (ppcre:register-groups-bind (antigen)
                                    (*antigen-file-re* (namestring fname))
                                    antigen))
                          (uiop:directory-files *data-path*))))
