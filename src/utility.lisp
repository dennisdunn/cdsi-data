(in-package :cdsi.data)

(defun ->list (node)
  "Transform a xmls:node into a property list. 
  
  xmls:nodes with the same name will be collected under a single plist key."
  (case (node-type node)
    ('empty (list (->keyword (xmls:node-name node)) nil))
    ('string (list (->keyword (xmls:node-name node)) (xmls:xmlrep-string-child node)))
    ('list (list (->keyword (xmls:node-name node)) (combine-values (reduce #'append (mapcar #'->list (xmls:xmlrep-children node))))))))

(defun node-type (node)
  "Classify the type of node based on its children."
  (let ((c (car (xmls:xmlrep-children node))))
    (cond ((xmls:node-p c) 'list)
          ((or (null c) (and (stringp c) (string="" c))) 'empty)
          (t 'string))))

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
