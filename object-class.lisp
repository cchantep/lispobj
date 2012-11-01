;; Declare Object class, root or hierarchy
;; @author Cedric Chantepie

(defun objClone ()
  (copy-tree this))

(defun objToString()
  (eval "[Object]"))

(defun Object()
      (copy-tree '(clone objClone  ; define clone method as objClone
	           toString objToString))) ; define toString method as objToString

