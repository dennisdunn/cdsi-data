(in-package :cdsi.data)

(defun nodelist-p (obj)
  (and (listp obj)
       (xmls:node-p (car obj))))

(defun ->keyword (str)
  (intern (string-upcase (string str)) :keyword))

(defun names (node)
  (remove-duplicates (mapcar #'xmls:node-name (xmls:xmlrep-children node)) :test #'string=))

(defun group (node)
  (reduce #'append (mapcar #'(lambda (name)
                               (list (->keyword name) (xmls:xmlrep-find-child-tags name node)))
                     (names node))))

(defun simplify (plist)
  (reduce #'append (loop for (key value) on plist by #'cddr
                         collect (list key (if (nodelist-p value)
                                               (mapcar #'->plist value)
                                               (xmls:xmlrep-string-child (car value) nil))))))

(defun ->plist (node)
  (simplify (group node)))
