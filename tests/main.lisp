(in-package :cl-user)

(defpackage :cdsi-data/tests
  (:use :cl
        :rove))

(in-package :cdsi-data/tests)

(deftest test-the-antigen-data-access
         (testing "fetch the antigen ids"
                  (ok (= (length (antigen:catalog)) 25)))
         (testing "load a apecific antigen supporting data"
                  (let ((data (antigen:get-antigen "Diphtheria")))
                    (ok (not (null data))))))

(deftest test-the-schedule-data-access
         (testing "load schedule supporting data"
                  (let ((data (schedule:get-schedule)))
                    (ok (not (null data))))))
