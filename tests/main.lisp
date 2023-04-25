(in-package :cl-user)

(defpackage :cdsi.data/tests
  (:use :cl
        :rove))

(in-package :cdsi.data/tests)

(deftest test-the-antigen-data-access
  (testing "fetch the antigen ids"
    (ok (= (length (cdsi.data:list-antigens)) 25)))
  (testing "load a apecific antigen supporting data"
    (let ((data (cdsi.data:get-antigen "Diphtheria")))
      (ok (not (null data))))))

(deftest test-the-schedule-data-access
  (testing "fetch the schedule ids"
    (ok (= (length (cdsi.data:list-schedules)) 5)))
  (testing "load a apecific antigen supporting data"
    (let ((data (cdsi.data:get-schedule "cvxToAntigenMap")))
      (ok (not (null data))))))
