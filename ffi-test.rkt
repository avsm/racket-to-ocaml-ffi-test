#lang racket

(require ffi/unsafe ffi/unsafe/define)

(define-ffi-definer define-robot-sim
  (ffi-lib "./aslib"))

(define-robot-sim double_int (_fun _int -> _int))

(double_int 5)
(double_int 100)
(double_int 100000)
