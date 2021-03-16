;e3
(define (comb n k)
        (/  (! n)
            (*  (! k)
                (! (- n k)))))

(define (! n)
        (if [<= n 1]
            1
            (* n (! (- n 1)))))
        
(display (comb 243 90))

;e11
;I have not get what it means.