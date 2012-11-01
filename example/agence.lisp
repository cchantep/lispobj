(defun agenceToString()
  (concatenate 'string "Agence[name=" (getf this 'name) 
  	", phone=" (getf this 'phone) 
;;	", admin=" (number-string (getf this 'admin))
	", comment=" (getf this 'comment) "]"))

(defun agenceTaillePersonnel()
  (getf this 'admin))

(defun Agence()
  (copy-tree '(ancestor 'Object ; super class
	       ; Properties
	       name nil
	       phone nil
	       admin 0
	       comment nil
	       ; Method
	       toString agenceToString
	       taillePersonnel agenceTaillePersonnel
	      )
  )
)
