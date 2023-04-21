(in-package :cl-cdsi-support/tests)

(deftest test-the-antigen-schedules
         (testing "fetch the antigen ids"
                  (ok (= (length (cl-cdsi-support:antigen-ids)) 25)))
         (testing "load a apecific antigen"
                  (let ((data (cl-cdsi-support:antigen "Diphtheria")))
                    (ok (not (null data))))))

(deftest test-the-supporting-data
         (testing "load supporting data"
                  (let ((data (cl-cdsi-support:get-data)))
                    (ok (not (null data))))))
