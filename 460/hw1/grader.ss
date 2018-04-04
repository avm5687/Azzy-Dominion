;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                            ;;;;
;;;;   DO NOT MODIFY ANYTHING IN THIS FILE      ;;;;
;;;;   DO NOT SUBMIT THIS FILE                  ;;;;
;;;;                                            ;;;;
;;;;   To run all the test cases in tests.rkt   ;;;;
;;;;      > (run-tests)                         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#lang mzscheme

(require "hw1.ss")
(require "tests.ss")

(require (lib "pretty.ss"))

(define run
  (lambda (exp)
    (eval exp)))

(define equal??
  (lambda (test-pgm test-ans correct-ans)
    (if (not (equal? test-ans correct-ans))
        (begin
          (printf "~s returned ~s, should have returned ~s~%"
                  test-pgm
                  test-ans
                  correct-ans)
          #f)
        #t)))

(define set-equal??
  (lambda (test-pgm test-ans correct-ans)
    (letrec ((subset?
              (lambda (s1 s2)
                (or (null? s1)
                    (and (element? (car s1) s2)
                         (subset? (cdr s1) s2)))))
             (element?
              (lambda (a set)
                (and (not (null? set))
                     (or (equal? (car set) a)
                         (element? a (cdr set))))))
             (same-set?
              (lambda (s1 s2)
                (and (subset? s1 s2)
                     (subset? s2 s1)))))
      (if (not (same-set? test-ans correct-ans))
          (begin
            (printf "~s returned ~s, should have returned ~s~%"
                    test-pgm
                    test-ans
                    correct-ans)
            #f)
          #t))))
                  

(define stop-after-first-error (make-parameter #f))


(define eval-safely
  (lambda (pgm)
    (with-handlers
        ((exn:fail?
          (lambda (exn)
            (cons #f (if (exn? exn)
                         (exn-message exn)
                         exn)))))
      (let ((actual (eval pgm)))
        (cons #t actual)))))


(define run-a-test
  (lambda (pgm correct-answer)
    (let* ((result (eval-safely pgm))
           (error-thrown? (not (car result)))
           (ans (cdr result)))
      ans)))
      

(define run-tests
  (lambda ()
    (let ((tests-passed '())
          (tests-failed '()))
      (for-each
       (lambda (test-item)
         (let* ((name (car test-item))
                (item (cadr test-item))
                (eq-func?? (car item))
                (pgm (cadr item))
                (correct-answer (caddr item)))
           (printf "test: ~a~%" name)
           (let* ((result (run-a-test pgm correct-answer))
                  (correct? ((eval eq-func??) pgm result correct-answer)))
             (if correct?
                 (begin
                   (printf "correct~%~%")
                   (set! tests-passed
                         (cons name tests-passed)))
                 (begin
                   (printf "incorrect~%~%")
                   (if (stop-after-first-error)
                       (error name "incorrect outcome detected"))
                   (set! tests-failed
                         (cons name tests-failed)))))))
       test-list)
      (begin
        (printf "out of ~a test cases~%" (length test-list))
        (printf " - passed: ~a~%" (length tests-passed))
        (printf " - failed: ~a~%~%" (length tests-failed))
        (if (null? tests-failed)
          (printf "Nice work~%")
          (printf "Failed tests: ~a~%" (reverse tests-failed)))))))

             
                 