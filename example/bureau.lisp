; Methods implementations
(defun addV(vehicule)
  (push vehicule (getprop this 'vehicules)))

;; Add garage to |this| bureau
;; @param garage Garage to be added
(defun addG(garage)
  (let (
    (list (getprop this 'garages))
    (number (getprop this 'garageNumber))
  )
    (when (not list)
      (setf list (list garage))
    )
    (when list
      (setf list (push list garage)))


    (setprop this 'garages list)
    (setprop this 'garageNumber (+ number 1))    
  )
)

(defun removeV(vehicule)
  (remove vehicule this :test #'equal))

;; Remove from |this| bureau
;; @param garage Garage to be removed
(defun removeG(garage)
  (print (remove garage this :test #'equal))
  (setprop this 'garageNumber (- (getprop this 'garageNumber) 1))
)

(defun giveV(vehicule garage)
  (invoke garage 'addGarage (invoke this 'removeVehicule vehicule)))

(defun tailleP()
  (+ (invoke super 'taillerPersonnel) (getprop this 'commercial)))

(defun nbG()
  (getprop this 'garageNumber))

(defun nbM()
  (let (
    (meca 0))
    (dolist (item '(getprop this 'garages))
      (+ meca (invoke item 'nbMeca)))
    (eval meca)))

(defun bureauToString()
  (concatenate 'string (invoke super 'toString) 
  	":Bureau[]"))

;; Constructor / prototype definition
(defun Bureau()
  (copy-tree '(ancestor 'Agence
 	  	; Properties
	  	commercial 0
		garageNumber 0
		garages ()
		vehicules ()
		; Methods
		addVehicule addV
		removeVehicule removeV
		giveVehicule giveV
		findVolume findVol
		toString bureauToString
		taillePersonnel tailleP
		addGarage addG
		removeGarage removeG
		nbGarages nbG
		nbMeca nbM))
)
