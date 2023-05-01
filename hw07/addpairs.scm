#lang scheme
;
; Millard A. Arnold V
; 2023-04-30
; 
; For CS 331 Spring 2023
; Solution to Assignment 7 Exercise 3

(define (addpairs . vals)
  (cond
    ((null? vals) vals)
    ((null? (cdr vals)) vals)
    (else (cons(+ (car vals) (cadr vals)) (apply addpairs (cddr vals))))
  )
)