(in-package :cl-user)

(defpackage :cdsi-data/config
  (:nicknames :config)
  (:use :cl)
  (:export :*data-path*
           :*antigen-file-re*
           :*schedule-file-name*))

(in-package :cdsi-data/config)

(defparameter *data-path* (asdf:system-relative-pathname
                            "cdsi-data"
                            "data/"))


(defparameter *antigen-file-re* "AntigenSupportingData- (.*)-508.xml")

(defparameter *schedule-file-name* #P"ScheduleSupportingData.xml")
