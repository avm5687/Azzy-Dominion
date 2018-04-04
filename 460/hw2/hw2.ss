;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CMPSC 460-001                        ;;;
;;; Homework 2                           ;;;
;;; Azalee McAlpine                      ;;;
;;; avm5687                              ;;;
;;;                                      ;;;
;;; Note:                                ;;;
;;;   Write whatever you want the grader ;;;
;;;   to know before grading.            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(module hw2 (lib "eopl.ss" "eopl")

  (provide
   s-list->scheme-list
   scheme-list->s-list
   s-exp->scheme-exp
   scheme-exp->s-exp
   subst
   scheme-exp->lc-exp
   lc-exp->scheme-exp
   ;free-vars
   ;bound-vars
  )


  ;; S-List
  ;;
  ;; <s-list> ::= ( {s-exp}* )  <== () | ( <s-exp> . <s-list> )
  ;;              [[ empty-s-list ]]  |  [[ non-empty-s-list (s-exp s-list) ]]
  ;; <s-exp>  ::= <symbol> | <s-list>
  ;;              [[ symbol-s-exp (sym) ]]  |  [[ s-list-s-exp (slist) ]]

  ;; Define the necessary data types and procedures for S-List
  ;; conforming to both concrete as well as abstract syntax above
(define-datatype s-list s-list?
   (empty-s-list)
   (non-empty-s-list (first s-exp?)
                    (rest s-list?)))
  
(define-datatype s-exp s-exp?
   (symbol-s-exp (sym symbol?))
   (s-list-s-exp (slist s-list?)))
  

(define scheme-list->s-list
  (lambda (lst)
    (cond
      ((null? lst) (empty-s-list))
      (else
        (non-empty-s-list (scheme-exp->s-exp (car lst)) ;to follow data encapsulation
                         (scheme-list->s-list (cdr lst)))))))

(define s-list->scheme-list
  (lambda (slst)
    (cases s-list slst
      (empty-s-list () '())
      (non-empty-s-list (first rest)
                        (cons (s-exp->scheme-exp first)
                              (s-list->scheme-list rest))))))

(define s-exp->scheme-exp
  (lambda (sexp)
    (cases s-exp sexp
      (symbol-s-exp (symbol) symbol)
      (s-list-s-exp (slst) (s-list->scheme-list slst)))))

(define scheme-exp->s-exp
  (lambda (schemeexp)
    (cond
      ;((null? schemeexp) (empty-s-list))
      ((symbol? schemeexp) (symbol-s-exp schemeexp))
      (else
       (s-list-s-exp (scheme-list->s-list schemeexp))))))
  
(define subst
  (lambda (symbolsexp symbolsexp2 slst)
    (cases s-list slst
      (empty-s-list () (empty-s-list))
      (non-empty-s-list (first rest)
                        (cond
                          ((equal? first symbolsexp) (non-empty-s-list symbolsexp2 (subst symbolsexp symbolsexp2 rest)))
                          (else
                           (non-empty-s-list first (subst symbolsexp symbolsexp2 rest))))))))
  
(define identifier? symbol?)
  
(define-datatype lc-exp lc-exp?
  (var-exp (var identifier?))
  (lambda-exp (bound-vars lstIdent) (body lc-exp?))
  (app-exp (rator lc-exp?) (rands lstlcexp)))

(define lstIdent ;list of identifiers, checks that each element is an idetifier
  (lambda (var)
    (cond
      ((null? var) #t)
      ((identifier? (car var)) (lstIdent(cdr var)))
      (else #f))))

(define lstlcexp ;goes through a list of lc-exp and checks if each one is an lc-exp
  (lambda (var)
    (cond
      ((null? var) #t)
      ((lc-exp? (car var)) (lstlcexp(cdr var)))
      (else #f))))

(define lc-exp->scheme-exp
  (lambda (var) 
   (cases lc-exp var
     (var-exp (var) var)
     (lambda-exp (lstIdent ph2) (list 'lambda lstIdent (lc-exp->scheme-exp ph2)))
     (app-exp (rator rands) (cons (lc-exp->scheme-exp rator) (map(lambda(explst)
                                                                   (lc-exp->scheme-exp explst)) rands))))))

(define scheme-exp->lc-exp
  (lambda (schemeexp)
    (cond
      ((symbol? schemeexp) (var-exp schemeexp))
      ((eqv? (car schemeexp) 'lambda) (lambda-exp (cadr schemeexp) (scheme-exp->lc-exp(caddr schemeexp))))
      (else
       (app-exp (scheme-exp->lc-exp(car schemeexp)) (helperLC (cdr schemeexp)))))))

(define helperLC  ;helper to go through the rest of list checkign for lc expressions
  (lambda (lst)
    (cond
      ((null? lst) '())
      (else (cons (scheme-exp->lc-exp (car lst)) (helperLC(cdr lst)))))))
  
(define occurs-free?
  (lambda (search-var exp)
    (cases lc-exp exp
      (var-exp (var) (eqv? search-var var))
      (lambda-exp (bound-var body)
                  (and (not (member? search-var bound-var))
                       (occurs-free? search-var body)))
      (app-exp (rator rand)
               (or (occurs-free? search-var rator)
                   (occurs-lstfree? search-var rand))))))
(define member ;checking to see if x is a member of y
  (lambda (x y)
    (cond
      ((list? (member x y)) #t)
      (else #f))))

(define occurs-lstfree ;checks if variable is in the lsit of free variables
  (lambda (var lst)
    (cond
      ((null? lst) #f)
      ((occurs-free? var (car lst)) #t)
      (else
       (occurs-lstfree? var (cdr lst))))))


  
(define free-vars ;returning free variables
  (lambda (lcexp)
    (cases lc-exp exp
      (var-exp (var) (list var))
      (lambda-exp (bound-vars body)
                  (let ((freeVar (getlist body))
                        (Bvar (append bound-vars (getblist body))))
                    (let ((a (map(lambda (x)
                                   (cond
                                     ((occures-free? x lcexp) x)))
                                 (Rduplicates (append freeVar Bvar)))))
                             (remove a))))
      (app-exp (first second)
               (append (free-vars first) (FreeAppEx second))))))
  






  
  
  
  ;;;; DO NOT REMOVE THE FOLLOWING PARENTHESIS
)
