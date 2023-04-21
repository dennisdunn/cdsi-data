(defpackage :cl-cdsi-support
  (:use :cl
        :xmls
        :cl-csv
        :cl-ppcre)
  (:export :antigen
           :antigen-ids
           :get-data))
