(in-package :cdsi.data)

(defparameter *data-path* (asdf:system-relative-pathname
                               "cdsi.data"
                               "data/")) ; don't forget the trailing slash!

(defparameter *schedule-name* "ScheduleSupportingData.xml")

(defparameter *antigen-name-re* "AntigenSupportingData- (.*)-508")
