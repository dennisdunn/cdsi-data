(in-package :cl-user)

(defpackage :cdsi.data
  (:use :cl)
  (:export :list-antigens
           :list-schedules
           :get-antigen
           :get-schedule
           :*antigen-path*
           :*schedule-path*
           :*antigen-name-re*))