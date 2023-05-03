(in-package :cdsi.data)

; (defun nodelist-p (obj)
;   (and (listp obj)
;        (xmls:node-p (car obj))))


(defun node->plist (node &optional (plist nil))
  (let* ((c (xmls:xmlrep-children node))
        (k (name->key node))
        (v (cond ((or (null-p c) (empty-p c)) nil)
                 ((string-p c) (car c))
                 (t (mapcar #'(lambda (n) (node->plist n plist)) c)))))
    (append plist (list k (if (listp v) 
                              (reduce #'append v)
                              v)))))

(defun name->key (node)
  (intern (string-upcase (kebab:to-kebab-case (xmls:node-name node))) :keyword))

(defun null-p (children)
  (null children))

(defun string-p (children)
  (and (eq 1 (length children))
       (stringp (car children))))

(defun empty-p (children)
  (and (string-p children)
       (string= "" (car children))))


; (defun names (node)
;   (remove-duplicates (mapcar #'xmls:node-name (xmls:xmlrep-children node)) :test #'string=))

; (defun group (node)
;   (reduce #'append (mapcar #'(lambda (name)
;                                (list (->keyword name) (xmls:xmlrep-find-child-tags name node)))
;                      (names node))))

; (defun simplify (plist)
;   (reduce #'append (loop for (key value) on plist by #'cddr
;                          collect (list key (->plist value)))))

; (defun ->plist (node)
;   (let ((key (->keyword (xmls:node-name node)))
;         (value (cond ((atomic-node-p node) (car (xmls:xmlrep-children node)))
;                      (t (reduce #'append (mapcar #'->plist (xmls:xmlrep-children node)))))))
;     (list key value)))

; (defun strip (plist)
;   (car (cdr plist)))

; (defun gather (plist)
;   (let ((hash (make-hash-table)))
;     (loop for (key value) on plist by #'cddr
;           do (if (gethash key hash)
;                  (setf (gethash key hash) (append (gethash key hash) value))
;                  (setf (gethash key hash) (list value))))
;     (alexandria:hash-table-plist hash)))

; ; (defun hash->plist (hash)
; ;   )
; ; (defun gather (plist)
; ;   (let (result nil)
; ;     (loop for (key value) on plist by #'cddr
; ;             ))
; ; (if (atomic-node-p node)
; ;     (list (->keyword (xmls:node-name node)) (car (xmls:xmlrep-children node)))
; ;     (list (->keyword (xmls:node-name node)) (mapcar #'->plist (xmls:xmlrep-children node)))))

; (defun atomic-node-p (node)
;   (let ((children (xmls:xmlrep-children node)))
;     (and (<= (length children) 1)
;          (or (null children) (stringp (car children))))))


; ;;;; Types of nodes
; ;;;; child is nil
; ;;;; child is list of string
; ;;;; child is list of node
; (defun ->node (plist tag)
;   (let ((node (xmls:make-xmlrep tag)))
;     (loop for (key value) on plist by #'cddr
;           do (if (= 1 (length value))
;                  (xmls:xmlrep-add-child! node (car value))
;                  (xmls:xmlrep-add-child! (xmls:make-xmlrep (string key) :children value))))
;     node))
