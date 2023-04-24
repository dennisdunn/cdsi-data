(in-package :cl-user)

(defpackage :cdsi-data/antigen
  (:use :cl
        :cdsi-data/config)
  (:export :list-antigens
           :get-antigen))

(in-package :cdsi-data/antigen)

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
