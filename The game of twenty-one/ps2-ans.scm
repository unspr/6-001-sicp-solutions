#lang racket/load
(load "ps2tw1.scm")

; p1
; (twenty-one hit? hit?)

; p2
(define (stop-at n)
        (lambda (your-hand opponent-up-card) 
                 (< (hand-total your-hand)
                    n)))

; (display (twenty-one hit? (stop-at 16)))


; p3
(define (test-strategy playerStrategy houseStrategy n)
        (for/sum ([i (build-list n
                                 (lambda (x)
                                         (twenty-one playerStrategy houseStrategy)))])
                 i))

;(display (test-strategy (stop-at 16) (stop-at 15) 10))

; p4
(define (watch-player strategy)
  (lambda (your-hand opponent-up-card)
    (let ([x (strategy your-hand opponent-up-card)])
      (display x)
      x)))

;(display (test-strategy (watch-player (stop-at 16))
;                        (watch-player (stop-at 15))
;                        2))

; p5
(define (louis your-hand opponent-up-card)
  (cond [(< (hand-total your-hand) 12) #t]
        [(> (hand-total your-hand) 16) #f]
        [(and (= (hand-total your-hand) 12) (< opponent-up-card 4)) #t]
        [(and (= (hand-total your-hand) 16) (= opponent-up-card 10)) #f]
        [(> opponent-up-card 6) #t]
        [else #f]))

;(display (test-strategy louis (stop-at 15) 10))
;(display (test-strategy louis (stop-at 16) 10))
;(display (test-strategy louis (stop-at 17) 10))

; p6
(define (both s1 s2)
  (lambda (your-hand opponent-up-card)
    (and (s1 your-hand opponent-up-card) (s2 your-hand opponent-up-card))))


;(display (twenty-one (both (stop-at 19) hit?) louis))

