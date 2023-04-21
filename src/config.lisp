(in-package :cl-cdsi-support)


(defparameter *data-path* (asdf:system-relative-pathname
                            :cl-cdsi-support
                            "data/"))
(defparameter *schedule-file-name* #P"ScheduleSupportingData.xml")
(defparameter *antigen-file-re* "AntigenSupportingData- (.*)-508.xml")
