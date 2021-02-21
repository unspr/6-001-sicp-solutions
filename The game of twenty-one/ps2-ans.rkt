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

; te1

(define (make-hand up-card card-set)
  (cons up-card card-set))
(define first-card cadr)
(define (hand-total hand)
  (for/sum ([i (cdr hand)]) i))

(define (hand-add-card hand new-card)
  (make-hand (hand-up-card hand)
             (cons new-card (cdr hand))))

(define (make-new-hand first-card)
  (make-hand first-card (list first-card)))

;(display (test-strategy louis (stop-at 17) 10))

; te2

(define (fresh-deck)
  (build-list (* 13 4)
              (lambda (x)
                (min (quotient (+ x 4) 4) 10))))

(define (shuffle deck)
  (let ([half (/ (length deck) 2)])
    (let ([a (take deck half)]
          [b (drop deck half)])
      (define (combine-list lst l r)
         (if (null? l)
             lst
             (combine-list (cons (car l)
                                 (cons (car r)
                                       lst))
                           (cdr l)
                           (cdr r))))
      (combine-list '() a b))))

(define (random-shuffle deck)
  (define (my-take lst n)
    (if (< (length lst) n)
        lst
        (take lst n)))
  (define (my-drop lst n)
    (if (< (length lst) n)
        '()
        (drop lst n)))
  (let ([half (floor (/ (length deck) 2))])
    (let ([a (take deck half)]
          [b (drop deck half)]
          [x (+ 1 (random 5))]
          [y (+ 1 (random 5))])
      (define (combine-list lst l r)
         (if (and (null? l) (null? r))
             lst
             (combine-list (append (my-take l x) (my-take r y) lst)
                           (my-drop l x)
                           (my-drop r y))))
      (combine-list '() a b))))


(define (repeat n f data)
  (if (= n 0)
      data
      (repeat (- n 1) f (f data))))

(define (cards)
  (define deck '())
  (lambda ()
    (cond [(null? deck) (set! deck (fresh-deck))])
    (let ([new-deck (repeat 5 random-shuffle deck)])
      (set! deck (cdr new-deck))
      (car new-deck))))

(define get-card (cards))

(define (deal) (get-card))

(display (test-strategy louis (stop-at 17) 10))
