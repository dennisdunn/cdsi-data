(in-package :cdsi.data)

(defparameter *data-path* (asdf:system-relative-pathname
                            "cdsi.data"
                            "data/"))

(defparameter *antigen-file-re* "AntigenSupportingData- (.*)-508.xml")

(defparameter *schedule-file-name* #P"ScheduleSupportingData.xml")
