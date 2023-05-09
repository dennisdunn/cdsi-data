(in-package :cdsi.data)

(defun ->list (node)
  (case (node-type node)
    ('stringnode (list (->keyword (xmls:node-name node)) (xmls:xmlrep-string-child node)))
    ('emptynode (list (->keyword (xmls:node-name node)) nil))
    ('nodelist (list (->keyword (xmls:node-name node)) (combine-values (reduce #'append (mapcar #'->list (xmls:xmlrep-children node))))))))

(defun node-type (node)
  (let ((c (car (xmls:xmlrep-children node))))
    (cond ((xmls:node-p c) 'nodelist)
          ((or (null c) (and (stringp c) (string="" c))) 'emptynode)
          (t 'stringnode))))

(defun ->keyword (name &optional (plural 1))
  "Intern a symbol named by the argument into the KEYWORD package."
  (intern (format nil "~:@(~a~p~)" (kebab:to-kebab-case (string name)) plural) :keyword))

(defun get-keys (plist)
  "Return all of the distinct keys in the plist."
  (remove-duplicates (loop for (k) on plist by #'cddr collect k)))

(defun get-values-by-key (key plist)
  "Get all of the values for a specified key."
  (loop for (k v) on plist by #'cddr
          when (eq k key) collect v))

(defun combine-values (plist)
  "Combine values for duplicate keys under one key."
  (let ((result '()))
    (dolist (k (get-keys plist))
      (let* ((v (get-values-by-key k plist))
             (plural (if (< (length v) 2) 1 2)))
        (push (->keyword k plural) result)
        (push (if (eq 1 plural) (car v) v) result)))
    (reverse result)))
