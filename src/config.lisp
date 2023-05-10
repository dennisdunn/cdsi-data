(in-package :cdsi.data)

(defparameter *antigen-path* (asdf:system-relative-pathname
                               "cdsi.data"
                               "data/antigens/")) ; don't forget the trailing slash!

(defparameter *schedule-path* (asdf:system-relative-pathname
                                "cdsi.data"
                                "data/ScheduleSupportingData.xml"))

(defparameter *antigen-name-re* "AntigenSupportingData- (.*)-508")
