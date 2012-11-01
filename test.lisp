(load "poo.lisp")
(load "example/agence.lisp")
(load "example/garage.lisp")
(load "example/bureau.lisp")

; Test generic agence
(setq agence (new 'Agence))

(setprop agence 'admin 9)
(setprop agence 'name "Agence Angers (49)")
(setprop agence 'phone "0234567890")
(setprop agence 'comment "no")

(print (invoke agence 'toString))
(print (invoke agence 'taillePersonnel))

; Garage "Chez roger"
(setq g1 (new 'Garage))
(setprop g1 'meca 2)
(setprop g1 'name "Chez roger")
(setprop g1 'phone "0123456789")
(setprop g1 'comment "A droite derriere la gare")

(print (getprop g1 'meca))
(print (invoke g1 'toString))

; Garage "Jule o-mobil"
(setq g2 (new 'Garage))
(setprop g2 'admin 3)
(setprop g2 'meca 7)
(setprop g2 'name "Jule o-mobil")
(setprop g2 'phone "0123456788")
(setprop g2 'comment "Joli garage rouge")

(print (invoke g2 'toString))
(print (invoke g2 'taillePersonnel)) ;; Should be 10 : admin + meca

; Bureau
(setq b1 (new 'Bureau))
(setprop b1 'name "Angers centre")
(setprop b1 'phone "9753796474")
(setprop b1 'comment "Blvd du roi rene")
(print (invoke b1 'toString))

(invoke b1 'addGarage g1)
(invoke b1 'addGarage g2)
(print "garages:")
(print (getprop b1 'garages)) ;; Should contains garages |g1| and |g2|

(invoke b1 'removeGarage g1)
(print (invoke b1 'nbGarages))
