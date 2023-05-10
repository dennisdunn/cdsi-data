(defsystem "cdsi.data"
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :depends-on ("asdf"
                        "xmls"
                        "kebab"
                        "cl-ppcre")
           :components ((:module "src"
                                 :components ((:file "packages")
                                              (:file "config")
                                              (:file "lazy")
                                              (:file "xml")
                                              (:file "main"))))
           :description ""
           :in-order-to ((test-op (test-op "cdsi.data/tests"))))

(defsystem "cdsi.data/tests"
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :serial t
           :depends-on ("cdsi.data"
                        "rove")
           :components ((:module "tests"
                                 :components
                                 ((:file "main"))))
           :description "Test system for cdsi.data."
           :perform (test-op (op c) (symbol-call :rove :run c)))
