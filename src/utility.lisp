(in-package :cdsi.data)

(defun node->plist (node &optional (plist nil))
  "Build a plist from an xmlrep object."
  (let* ((c (xmls:xmlrep-children node))
         (k (name->key (xmls:node-name  node))
         (v (cond ((or (null c) (empty-p c)) nil)
                  ((string-p c) (car c))
                  (t (mapcar #'(lambda (n) (node->plist n plist)) c)))))
    (append plist (list k (if (listp v)
                              (reduce #'append v)
                              v)))))

(defun name->key (name)
  (intern (string-upcase (kebab:to-kebab-case (string name))) :keyword))

(defun string-p (children)
  (and (eq 1 (length children))
       (stringp (car children))))

(defun empty-p (children)
  (and (string-p children)
       (string= "" (car children))))

(defun get-keys (plist)
  "Return all of the distinct keys in the plist."
  (remove-duplicates (loop for (k v) on plist by #'cddr collect k) :test #'string=))

(defun get-values-by-key (key plist)
  "Get all of the values for a specified key."
  (loop for (k v) on plist by #'cddr
          if (string= k key)
        collect v))

(defun squash (plist)
  "Combine values for duplicate keys under one key."
  (let ((l '()))
    (dolist (k (get-keys plist))
      (let* ((v (get-values-by-key k plist))
             (v1 (if (eq 1 (length v)) (car v) v)))
        (push k l)
        (push v1 l)))
    (reverse l)))
