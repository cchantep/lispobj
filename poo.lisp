;; Declare OOP extension
;; @author Cedric Chantepie

; Language intrinsic imports
(load "object-class.lisp")

; Object call (invokation) context
(setq this nil)
(setq ctx ())
(setq ancestors ())

;; Constructor
;; !!! TODO !!! Implicitly push Object as ancestor for class where ancestor is not defined
;; @param class Class according which create instance
;; @return New |class| instance
(defun new (class &rest arguments)
  (let (
    (inst (apply class arguments))
    (tmp nil)
    )
    (setf tmp (getf inst 'ancestor))
    (when tmp
      ;(setf (getf inst 'ancestor) (eval tmp)))
      (setf (getf inst 'ancestor) (new (eval tmp))))

    inst
  )
)

;; Invoke 
;; @param instance on which invoke the method
;; @param methodName Name of method to be invoked
;; @param arguments Arguments to be passed to the method
(defun invoke (instance methodName &rest arguments)
  (let (
    (res nil) 
    (method nil)
    )

    ; walk accross class hierarchy to find method
    (let (
      (proto instance)
      )
      (loop while (and proto (not method))
        do (setf method (getf proto methodName))
	do (setf proto (getf proto 'ancestor))
      )
    )

    ; invalid object, no prototype
    (when (not method)
      (print (concatenate 'string 
        "Invalid object has no valid prototype for method "
	(string methodName)))
      (eval nil))

    ; has method so invoke it
    (when method ; call method |methodName| and get result
      ; push new invokation context
      (push (setq this instance) ctx)
      (push (setq super (getf this 'ancestor)) ancestors)

      (setq res (apply method arguments))

      ; go to last invokation context
      (pop ctx)
      (pop ancestors)
      (setq this (car ctx))
      (setq super (car ancestors))

      res
    )
  )
)

;; Assign to |property| of |instance| specified |value|
;; @param instance
;; @param property Name of property
;; @param value Value to be set
(defun setprop(instance property value)
  (let (
      (res nil)
      (prop nil)
     )

     ; walk accross class hierarchy to find property
     (let ((proto instance))
        (loop while (and proto (not (member property proto)))
              do (setq proto (getf proto 'ancestor))
        )

	(when proto
	  (setf (getf proto property) value))
      )
   )
)

;; Return |property| from specified |instance|
;; @param instance
;; @param property Name of property
(defun getprop(instance property)
  (let (
        (res nil)
        (prop nil)
        )

    (let ((proto instance))
             ; walk accross class hierarchy to find property
      (loop while (and proto (not (member property proto)))
	     do (setq proto (getf proto 'ancestor))
      )

      ; invalid object, no prototype
      (when (not (member property proto))
      	(print (concatenate 'string
			    "Invalid object has no valid prototype for property "
			      (string property)))
      	(eval nil))
                                        ; has method so invoke it
      (when (member property proto)
	(getf proto property))
      
    )
  )
)
