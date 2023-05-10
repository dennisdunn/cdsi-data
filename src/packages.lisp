(in-package :cl-user)

(defpackage :cdsi.data
  (:use :cl)
  (:export :list-antigens
           :list-schedules
           :get-antigen
           :get-schedule
           :*data-path*
           :*antigen-file-re*
           :*schedule-file-name*))