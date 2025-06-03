(defun mdc (a b)
  (cond 
    ((zerop b) a)
    (t (mdc b (mod a b)))))

(defun numero-valido (n)
  (cond
    ((not (atom n)) nil)
    ((not (> n 0)) nil)
    (t t)))

(defun mmc (a b)
  (cond
    ((not (numero-valido a)) nil)
    ((not (numero-valido b)) nil)
    (t (/ (* a b) (mdc a b)))))

; Exemplos de teste
(print "Testando a função MMC:")
(print (mmc 0 3))    ; NIL (zero não é positivo)
(print (mmc 2 -3))   ; NIL (número negativo)
(print (mmc 2 3))    ; 6
(print (mmc 12 45))  ; 180