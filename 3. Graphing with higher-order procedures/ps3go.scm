;;setup PS3, Fall 1997

(define g1 
  (if (lexical-unreferenceable? user-initial-environment 'g1)
     false
     g1))
(define g2 
  (if (lexical-unreferenceable? user-initial-environment 'g2)
     false
     g2))
(define g3 
  (if (lexical-unreferenceable? user-initial-environment 'g3)
     false
     g3))


(define (device) (make-graphics-device (car (enumerate-graphics-types))))

(define (setup-windows)
  (if (and g1 (graphics-device? g1))
      (graphics-close g1))
  (begin (set! g1 (device))
	 (graphics-set-coordinate-limits g1 -1.0 -1.0 1.0 1.0)
	 (graphics-operation g1 'set-window-name "Graphics: g1"))
  (if (and g2 (graphics-device? g2))
      (graphics-close g2))
  (begin (set! g2 (device))
	 (graphics-set-coordinate-limits g2 -2.0 -2.0 2.0 2.0)
	 (graphics-operation g2 'set-window-name "Graphics: g2"))
  (if (and g3 (graphics-device? g3))
      (graphics-close g3))
  (begin (set! g3 (device))
	 (graphics-set-coordinate-limits g3 -1.0 -1.0 1.0 1.0)
	 (graphics-operation g3 'set-window-name "Graphics: g3"))
  )

(begin (setup-windows) "Ready to draw")
