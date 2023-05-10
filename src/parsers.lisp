(in-package :cdsi.data)

(defun ->keyword (name &optional (plural 1))
  "Intern a symbol named by the argument into the KEYWORD package."
  (intern (format nil "~:@(~a~p~)" (kebab:to-kebab-case (string name)) plural) :keyword))
