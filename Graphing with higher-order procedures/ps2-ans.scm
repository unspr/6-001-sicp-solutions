(load "utils")

; e1
(((thrice thrice) 1+) 6)
(((thrice thrice) identity) compose)
(((thrice thrice) square) 1)

; e2
(load "curves")
(define (vertical-line-at x)
    (lambda (t) (make-point x t)))

(define (vertical-line point length)
    (let ((y (vertical-line-at (x-of point))))
        (lambda (t)
                (y  (+  (* t length)
                        (y-of point))))))

; e3
(define (reflect-through-y-axis curve)
    (lambda (t)
            (let  ((ct (curve t)))
                  (make-point
                      (- (x-of ct))
                      (y-of ct)))))

; e4
(define (connect-ends c1 c2)
    (lambda (t)
        (let ((xend (x-of (c1 1)))
              (yend (y-of (c1 1))))
            (let ((newCurve
                  ((translate  (- xend (x-of (c2 0)))
                               (- yend (y-of (c2 0))))
                          c2)))
                (if (< t (/ 1 2))
                    (c1 (* 2 t))
                    (newCurve (- (* 2 t) 1)))))))                  
; ((draw-connected g2 200) (connect-ends unit-circle (vertical-line-at 0.5)))

; e5
(load "drawing")
(load "ps3go")
((draw-connected g1 200) unit-circle)
((draw-connected g2 200) alternative-unit-circle)
((draw-points-on g3 200) alternative-unit-circle)
((draw-points-squeezed-to-window g3 200) alternative-unit-circle)



