(in-package :cdsi.data)

(defparameter *schedules* (lazy (load-schedule)))
(defparameter *antigens* (lazy (load-antigens)))

(defun list-antigens ()
  "Return a list of antigen identifiers."
  (loop for (k) on (force *antigens*) by #'cddr collect k))

(defun get-antigen (id)
  "Get the antigen data for the specified antigen identifier."
  (getf (force *antigens*) id))

(defun list-schedules ()
  "Return a list of schedule identifiers."
  (loop for (k) on (force *schedules*) by #'cddr collect k))

(defun get-schedule (id)
  "Get the schedule data for the specified schedule identifier."
  (getf (force *schedules*) id))

(defun load-schedule ()
  "Load the schedule supporting data."
  (with-open-file (stream (merge-pathnames *data-path* *schedule-name*))
    (second (->list (xmls:parse stream)))))

(defun load-antigens ()
  "Load the antigen supporting data."
  (reduce #'append (mapcar #'(lambda (path)
                               (with-open-file (stream path)
                                 (list (path->keyword path) (second (->list (xmls:parse stream))))))
                     (remove-if #'(lambda (path) (string= (file-namestring path) *schedule-name*))
                       (uiop:directory-files *data-path*)))))

(defun ->keyword (name &optional (plural 1))
  "Intern a symbol named by the argument into the KEYWORD package."
  (intern (format nil "~:@(~a~p~)" (kebab:to-kebab-case (string name)) plural) :keyword))

(defun path->keyword (path)
  "Return the antigens name as a keyword."
  (->keyword (cl-ppcre:register-groups-bind (key) (*antigen-name-re* (pathname-name path))
               key)))
