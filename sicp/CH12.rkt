#lang racket

;;;; Procedures and the Processes They Generate

;; Linear Recursion and Iteration
;;
;; n!

(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))

(fact 6)
(* 6 (fact 5))
(* 6 (* 5 (fact 4)))
(* 6 (* 5 (* 4 (fact 3))))
(* 6 (* 5 (* 4 (* 3 (fact 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (fact 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720

(define (fact- n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max)
  (if (> counter max)
      product
      (fact-iter (* product counter) (+ 1 counter) max)))

(fact- 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)

;; Tree Recursion

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (fib- n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) b (- count 1))))

;; Counting change
;;
;; M0 Recursion
;; 1. the number of ways to change amount a using all but the first kind of coin
;; 2. the number of ways to change amount a-d using all n kinds of coins, where d is the denoination of the first kind of coin
;;
;; if a is exactly 0, we should count that as 1 way to make change
;; if a is less than 0, we should count that as 0 ways to make change
;; if n is 0, we should count that as 0 ways to make change

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)
                            