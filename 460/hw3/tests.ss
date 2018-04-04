;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CMPSC 460-001                        ;;;
;;; Homework 3                           ;;;
;;; Azalee McAlpine                      ;;;
;;; avm5687                              ;;;
;;;                                      ;;;
;;; Note:                                ;;;
;;;   Write whatever you want the grader ;;;
;;;   to know before grading.            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; Use the following test cases for initial testing of your basic interpreter.
;;;; Once you are done, extend your interpreter so that it supports
;;;; - integer multiplicaiton
;;;; - integer division
;;;; - dynproc
;;;;
;;;;  Then, uncomment the test cases for the extension at the end of this file
;;;;  and use them to test your interpreter.
;;;;
;;;;  Once you are done, remove the provided test cases for the extensions
;;;;  and add at least 10 test cases of your own.
;;;;
;;;;  DO NOT REMOVE THE TEST CASES FOR THE BASIC INTERPRETER.


(module tests mzscheme
  
  (provide test-list)

  (define test-list
    '(
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;    DO NOT REMOVE THESE TEST CASES    ;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;; const-exp
      (const-exp-1 "100" 100)
      (const-exp-2 "49" 49)
      (const-exp-3 "0" 0)
      (const-exp-4 "-57" -57)
      (const-exp-5 "-111" -111)
      ;; var-exp
      (var-exp-1 "x" 10)
      (var-exp-2 "v" 5)
      (var-exp-3 "i" 1)
      (var-exp-4 "y" error)
      (var-exp-5 "foo" error)
      ;; zero?-exp
      (zero?-exp-1 "zero? (0)" #t)
      (zero?-exp-2 "zero? (1)" #f)
      (zero?-exp-3 "zero? (-(x,x))" #t)
      (zero?-exp-4 "zero? (-(x,v))" #f)
      (zero?-exp-5 "zero? (y)" error)
      ;; diff-exp
      (diff-exp-1 "-(x,x)" 0)
      (diff-exp-2 "-(x,i)" 9)
      (diff-exp-3 "-(i,x)" -9)
      (diff-exp-4 "-(zero(9),x" error)
      (diff-exp-5 "-(10,-(5,-(7,5)))" 7)
      ;; if-exp
      (if-exp-1 "if zero?(0) then 3 else 4" 3)
      (if-exp-2 "if zero?(1) then 3 else 4" 4)
      (if-exp-3 "if zero? (-(x, 11)) then -(v, 2) else -(v, 4)" 1)
      (if-exp-4 "if zero?(-(11, 11)) then 3 else foo" 3)
      (if-exp-5 "if zero?(-(11,12)) then foo else 4" 4)
      ;; let-exp
      (let-exp-1 "let x = 3 in x" 3)
      (let-exp-2 "let x = 3 in -(x,1)" 2)
      (let-exp-3 "let x = -(4,1) in -(x,1)" 2)
      (let-exp-4
        "let x = 33
         in let y = 22
            in if zero? (-(x, 11))
               then -(y, 2)
               else -(y, 4)"
        18)
      (let-exp-5
        "let x = 7
         in let y = 2
            in let y = let x = -(x, 1)
                       in -(x, y)
               in -(-(x, 8), y)"
        -5)
      ;; call-exp
      (call-exp-1 "(proc(x) -(x,1)  30)" 29)
      (call-exp-2 
        "let f = proc(x) -(x, 11)
         in (f (f 7))"
        -15)
      (call-exp-3 
        "(proc (f) (f (f 77))       
          proc (x) -(x, 11))"
        55)
      (call-exp-4 "((proc (x) proc (y) -(x,y)  5) 6)" -1)
      (call-exp-5 
        "let fix =  proc (f)
                      let d = proc (x) proc (z) ((f (x x)) z)
                      in proc (n) ((f (d d)) n)
         in let t4m = proc (f)
                        proc(x)
                          if zero?(x) then 0 else -((f -(x,1)),-4)
            in let times4 = (fix t4m)
               in (times4 3)"
        12)
      (call-exp-4 "let a = 5
                  in let p = proc (x) -(x, a)
                     in let a = 10
                        in -(a, (p 2))"
                 13)
      (call-exp-5 "let a=3
                  in let p = proc (z) a
                     in let f = proc (x) (p 0)
                        in let a = 5
                           in (f 2)"
                 3)
      (call-exp-6 "let a=3
                  in let p = proc (z) a
                     in let f = proc (a) (p 0)
                        in let a = 5
                           in (f 2)"
                 3)
      ;; letrec-exp
      (letrec-exp-1 
        "letrec double(x) = if zero? (x)
                            then 0
                            else -((double -(x,1)), -2)
         in (double 2)"
        4)
      (letrec-exp-2 
        "letrec double(x) = if zero? (x)
                            then 0
                            else -((double -(x,1)), -2)
         in (double 6)"
        12)
      (letrec-exp-3 
        "let m = -5 
         in letrec f(x) = if zero?(x) then 0 else -((f -(x,1)), m)
            in (f 4)"
        20)
      (letrec-exp-4 
        "letrec f(x) = if zero?(x)  then 0 else -((f -(x,1)), -2) in (f 4)"
        8)
      (letrec-exp-5 
        "letrec even(odd)  = proc(x) if zero?(x) then 1 else (odd -(x,1))
         in letrec  odd(x)  = if zero?(x) then 0 else ((even odd) -(x,1))
            in (odd 13)"
        1)



      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;    TEST CASES FOR EXTENSIONS                           ;;;;
      ;;;;                                                        ;;;;
      ;;;;    - Uncomment and Use these test cases for initial    ;;;;
      ;;;;        testing of your extended interpreter            ;;;;
      ;;;;    - Once you are done, remove these test cases        ;;;;
      ;;;;        and add at least 10 test cases for each         ;;;;
      ;;;;        extension                                       ;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
      ;; mult-exp
      (mult-exp-1 "*(1,5)" 5)
      (mult-exp-2 "*(2,3)" 6)
      (mult-exp-3 "*(*(2,2),*(2,2))" 16)
      (mult-exp-4 "*(*(3,2),*(2,2))" 24)
      (mult-exp-5 "*(12,3)" 36)
      (mult-exp-6 "*(2,2)" 4)
      (mult-exp-7 "*(12,12)" 144)
      (mult-exp-8 "*(3,3)" 9)
      (mult-exp-9 "*(4,2)" 8)
      (mult-exp-10 "*(6,2)" 12)

      ;; div-exp
      (div-exp-1 "/(1,2)" 0)
      (div-exp-2 "/(/(10,3),3)" 1)
      (div-exp-3 "/(/(10,3), /(2,1))" 1)
      (div-exp-4 "/(5,0)" error)
      (div-exp-5 "/(11,0)" error)
      (div-exp-6 "/(15,0)" error)
      (div-exp-7 "/(/(11,5), /(7,2))" 0)
      (div-exp-8 "/(10,2)" 5)
      (div-exp-9 "/(15,5)" 3)
      (div-exp-10 "/(24,12)" 2)
      

      ;; dynproc
      (dynproc-1 "let a = 15
                  in let p = dynproc (x) -(x, a)
                     in let a = 12
                        in -(a, (p 2))"
                 22)
      
      (dynproc-2 "let a = 215
                  in let p = dynproc (x) -(x, a)
                     in let a = 212
                        in -(a, (p 5))"
                 419)
      
      (dynproc-3 "let a=317
                  in let p = dynproc (z) a
                     in let f = dynproc (a) (p 5)
                        in let a = 75
                           in (f 4)"
                 4)

      (dynproc-4 "let a = 1215
                  in let p = dynproc (x) -(x, a)
                     in let a = 212
                        in -(a, (p 8))"
                 416)
      (dynproc-5 "let a=589
                  in let p = dynproc (z) a
                     in let f = dynproc (a) (p 5)
                        in let a = 4
                           in (f 7)"
                 7)
      (dynproc-6 "let a = 10
                  in let p = dynproc (x) -(x, a)
                     in let a = 2
                        in -(a, (p 8))"
                 -4)
      (dynproc-7 "let a = 100
                  in let p = dynproc (x) -(x, a)
                     in let a = 45
                        in -(a, (p 8))"
                 82)
      (dynproc-8 "let a = 1004
                  in let p = dynproc (x) -(x, a)
                     in let a = 451
                        in -(a, (p 8))"
                 894)
      (dynproc-9 "let a = 4857
                  in let p = dynproc (x) -(x, a)
                     in let a = 2
                        in -(a, (p 145))"
                 -141)
     (dynproc-10 "let a = 48570000154
                  in let p = dynproc (x) -(x, a)
                     in let a = 245
                        in -(a, (p 12548))"
                 -12058)

      
      )
    )
  )
