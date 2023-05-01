(in-package :cdsi.data)

(defun nodelist-p (obj)
  (and (listp obj)
       (xmls:node-p (car obj))))

(defun ->keyword (str)
  (intern (string-upcase (kebab:to-kebab-case (string str))) :keyword))

(defun names (node)
  (remove-duplicates (mapcar #'xmls:node-name (xmls:xmlrep-children node)) :test #'string=))

(defun group (node)
  (reduce #'append (mapcar #'(lambda (name)
                               (list (->keyword name) (xmls:xmlrep-find-child-tags name node)))
                     (names node))))

(defun simplify (plist)
  (reduce #'append (loop for (key value) on plist by #'cddr
                         collect (list key (->plist value)))))

(defun ->plist (node)
  (let ((key (->keyword (xmls:node-name node)))
        (value (cond ((atomic-node-p node) (car (xmls:xmlrep-children node)))
                     (t (reduce #'append (mapcar #'->plist (xmls:xmlrep-children node)))))))
    (list key value)))

; (if (atomic-node-p node)
;     (list (->keyword (xmls:node-name node)) (car (xmls:xmlrep-children node)))
;     (list (->keyword (xmls:node-name node)) (mapcar #'->plist (xmls:xmlrep-children node)))))

(defun atomic-node-p (node)
  (let ((children (xmls:xmlrep-children node)))
    (or (null children) (stringp (car children)))))
