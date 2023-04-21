(defsystem "cl-cdsi-support"
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :serial t
           :components ((:module "src"
                                 :components ((:file "package")
                                              (:file "config")
                                              (:file "antigen")
                                              (:file "schedule"))))
           :description ""
           :in-order-to ((test-op (test-op "cl-cdsi-support/tests"))))

(defsystem "cl-cdsi-support/tests"
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :serial t
           :depends-on ("cl-cdsi-support"
                        "rove")
           :components ((:module "tests"
                                 :components
                                 ((:file "packages")
                                  (:file "supporting-data"))))
           :description "Test system for cl-cdsi-support"
           :perform (test-op (op c) (symbol-call :rove :run c)))
