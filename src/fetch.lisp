(in-package :cdsi.data)

(defun ->keyword (symbol)
  "Intern the symbol into the KEYWORD package."
  (intern (string-upcase (kebab:to-kebab-case (string symbol))) :keyword))

(defun fetch-data (url &optional (fmt :hash-table))
  (let ((stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (multiple-value-bind (data keys) (yason:parse stream :object-key-fn #'->keyword :object-as fmt)
      data)))
