(load "example/agence.lisp")

(defun nombreMeca()
  (getprop this meca))

(defun garageToString()
  (concatenate 'string (invoke super 'toString)
	":Garage[]"))

(defun retraitBureau(bureau)
	(invoke bureau 'removeGarage this))

(defun ajoutBureau(bureau)
	(invoke bureau 'addGarage this))

(defun garageTaillePersonnel()
	(+ (invoke super 'taillePersonnel) (getprop this 'meca)))

; Constructor / class definition
(defun Garage()
  (copy-tree '(ancestor 'Agence
   		; Properties
		meca 0
		; Methods
		nbMeca nombreMeca
		toString garageToString
		ajoutBureau ajoutBureau
		retraitBureau retraitBureau
		taillePersonnel garageTaillePersonnel))
)
