;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;      CMPSC 460-001                                         ;;;
;;;      Homework 4                                            ;;;
;;;      Azalee McAlpine                                       ;;;
;;;      avm5687                                               ;;;
;;;                                                            ;;;
;;;      Note:                                                 ;;;
;;;        Write whatever you want the grader                  ;;;
;;;        to know before grading.                             ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(module hw3 (lib "eopl.ss" "eopl")

  (provide
    run
    expval->num
    expval->bool
    expval->proc
    num-val
    bool-val
    )


  ;;;;   Program    ::= Expression
  ;;;;                  [[ a-program (exp1) ]]
  ;;;;   Expression ::= Number
  ;;;;                  [[ const-exp (num) ]]
  ;;;;                ::= Identifier
  ;;;;                  [[ var-exp (var) ]]
  ;;;;                ::= zero? ( Expression )
  ;;;;                  [[ zero?-exp (exp1) ]]
  ;;;;                ::= - ( Expression , Expression )
  ;;;;                  [[ diff-exp (exp1 exp2) ]]
  ;;;;                ::= if Expression then Expression else Expression
  ;;;;                  [[ if-exp (exp1 exp2 exp3) ]]
  ;;;;                ::= let Identifier = Expression in Expresstion
  ;;;;                  [[ let-exp (var exp1 exp2) ]]
  ;;;;                ::= proc ( Identifier ) Expression
  ;;;;                  [[ proc-exp (var body) ]]
  ;;;;                ::= (Expression Expression)
  ;;;;                  [[ call-exp (rator rand) ]]
  ;;;;                ::= letrec Identifier (Identifier) = Expression in Expression
  ;;;;                  [[ letrec-exp (p-name b-var p-body letrec-body) ]]
  
  
  
  ;;;;
  ;;;; Lexical Specification
  ;;;; - DO NOT CHANGE
  (define the-lexical-spec
    '((whitespace (whitespace) skip)
      (comment ("%" (arbno (not #\newline))) skip)
      (identifier
        (letter (arbno (or letter digit "_" "-" "?")))
        symbol)
      (number (digit (arbno digit)) number)
      (number ("-" digit (arbno digit)) number)
      ))


  ;;;;
  ;;;; Grammar
  ;;;;
  (define the-grammar
    '(
      (program (expression) a-program)
      (expression (number) const-exp)
      (expression (identifier) var-exp)
      (expression
       ("let" (arbno identifier "=" expression)
              "in" expression)
       let-exp)
      (expression
        ("zero?" "(" expression ")")
        zero?-exp)
      (expression
        ("-" "(" expression "," expression ")")
        diff-exp)
      (expression
        ("*" "(" expression "," expression ")")
        mult-exp)
      (expression
        ("/" "(" expression "," expression ")")
        div-exp)
      (expression
        ("if" expression "then" expression "else" expression)
        if-exp)
      (expression
        ("proc" "(" identifier ")" expression)
        proc-exp)
      (expression
        ("dynproc" "(" identifier ")" expression)
        dynproc-exp)
      (expression
        ("(" expression expression ")")
        call-exp)
      (expression
        ("letrec" identifier "(" identifier ")" "=" expression "in" expression)
        letrec-exp)
      ))



  ;;;; generate the data types for each production in the grammar
  ;;;; - constructors:
  ;;;;     a-program : Exp -> Program
  ;;;;     const-exp : Int -> Exp
  ;;;;     var-exp   : Var -> Exp
  ;;;;     zero?-exp : Exp -> Exp
  ;;;;     diff-exp  : Exp x Exp -> Exp
  ;;;;     if-exp    : Exp x Exp x Exp -> Exp
  ;;;;     let-exp   : Var x Exp x Exp -> Exp
  ;;;;     proc-exp  : Var x Exp -> Exp
  ;;;;     call-exp  : Exp x Exp -> Exp
  ;;;;     letrec-exp: Var x Var x Exp x Exp -> Exp
  
  (sllgen:make-define-datatypes the-lexical-spec the-grammar)


  ;;;; list the data types generated from lexical spec and grammar
  (define show-the-datatypes
    (lambda ()
      (sllgen:list-define-datatypes the-lexical-spec the-grammar)))


  ;;;; generates a parser that
  ;;;;   scans program text according to the lexical spec and
  ;;;;   parses the generated tokens according to the grammar
  (define scan&parse
    (sllgen:make-string-parser the-lexical-spec the-grammar))

  ;;;; generate the scanner based on lexical spec and grammar
  (define just-scan
    (sllgen:make-string-scanner the-lexical-spec the-grammar))




  ;;;; Values for our language
  ;;;;      ExpVal = Int + Bool + Proc
  ;;;;      DenVal = Int + Bool + Proc


  ;; data type for ExpVal
  ;;
  ;; Expressed value is either a number, a boolean, or a procedure
  (define-datatype expval expval?
    (num-val
      (value number?))
    (bool-val
      (boolean boolean?))
    (proc-val 
      (proc proc?))
    )
  
  ;; The values for number and boolean simply use Scheme's number and boolean
  ;; So, only need to define datatype for proc
  ;;
  ;;
  ;; Data type for Proc
  (define-datatype proc proc?
    (procedure
      (bvar symbol?)
      (body expression?)
      (env environment?))
   (dynproc (var symbol?)
      (body expression?))
    )
  ;; expval extractors
  ;;
  ;; expval->num : ExpVal -> Int
  (define expval->num
        (lambda (v)
      (cases expval v
	(num-val (num) num)
	(else (expval-extractor-error 'num v))))
    )
  
  ;; expval->bool : ExpVal -> Bool 
  (define expval->bool
    (lambda (v)
      (cases expval v
	(bool-val (bool) bool)
	(else (expval-extractor-error 'bool v))))
    )
     
  ;; expval->proc : ExpVal -> Proc
  (define expval->proc
    (lambda (v)
      (cases expval v
	(proc-val (proc) proc)
	(else (expval-extractor-error 'proc v))))
    )
     
  ;; helper for extractors to report error
  (define expval-extractor-error
     (lambda (variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value))
    )
  
  (define symbols?
    (lambda (lst)
      (cond 
      ((null? lst) #t)
      ((symbol? (car lst)) (symbols? (cdr lst)))
      (else #f))))

  (define expvals?
    (lambda (lst)
      (cond
      ((null? lst) #t)
      ((expval? (car lst)) (expvals? (cdr lst)))
      (else #f))))
  
  ;;;; environment
  ;;;; - needed to evaluate expressions containing variables
  ;;;; - keeps the value associated with each variable
  ;;;; - environment is a function
  ;;;;      Env : Var -> DenVal
  
  ;; Data structure for environment
  (define-datatype environment environment?
    (empty-env)
    (extend-env 
      (bvar symbols?)
      (bval expvals?)
      (saved-env environment?))
    (extend-env-rec
      (id symbol?)
      (bvar symbol?)
      (body expression?)
      (saved-env environment?)))

  ;; apply-env : Env x Var -> ExpVal
  (define apply-env
     (lambda (env search-sym)
      (cases environment env
        (empty-env ()
          (eopl:error 'apply-env "No binding for ~s" search-sym))
        (extend-env (var val saved-env) 
	  (let ((var(SL var val search-sym)))
            (cond
              ((null? var) (apply-env saved-env search-sym))
              (else var))))
        (extend-env-rec (p-name b-var p-body saved-env)
          (if (eqv? search-sym p-name)
            (proc-val (procedure b-var p-body env))          
            (apply-env saved-env search-sym))))))

  (define SL
    (lambda (varList valList var)
      (cond
        ((null? varList) '())
        ((eqv? var (car varList)) (car valList))
        (else (SL (cdr varList) (cdr valList) var)))))
       
  ;; initial environment for testing
  ;; init-env : () -> Env
  ;;
  ;; - DO NOT CHANGE
  (define init-env
    (lambda ()
      (extend-env '(i) (list (num-val 1))
        (extend-env '(v) (list (num-val 5))
          (extend-env '(x) (list (num-val 10))
            (empty-env))))))

  
  ;;;;
  ;;;; Interpreter for our language
  ;;;;
  
  
  ;; run : String -> ExpVal
  ;;
  (define run
      (lambda (str)
    (value-of-program (scan&parse str)))
    )

  ;; value-of-program : Program -> ExpVal
  (define value-of-program
    (lambda (prog)
      (cases program prog
        (a-program (exp1)
          (value-of exp1 (init-env))))))

  ;; value-of : Expression x Environment -> ExpVal
  (define value-of
     (lambda (exp env)
      (cases expression exp

        (const-exp (num) (num-val num))

        (var-exp (var) (apply-env env var))

        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (- num1 num2)))))
        
        (div-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (floor(/ num1 num2))))))
        
        (mult-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (* num1 num2)))))

        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))
              
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (value-of exp1 env)))
            (if (expval->bool val1)
              (value-of exp2 env)
              (value-of exp3 env))))

        (let-exp (var exps body)       
          (let ((valList (Evaluate exps env)))
            (value-of body
              (extend-env var valList env))))
        
        (proc-exp (var body)
          (proc-val (procedure var body env)))
        
        (dynproc-exp (var body)
          (proc-val (dynproc var body)))

        (call-exp (rator rand)
          (let ((proc (expval->proc (value-of rator env)))
                (arg (value-of rand env)))
            (apply-procedure proc arg env)))

        (letrec-exp (p-name b-var p-body letrec-body)
          (value-of letrec-body
            (extend-env-rec p-name b-var p-body env)))

        )))


  ;; apply-procedure: Proc x ExpVal -> ExpVal
  (define apply-procedure
    (lambda (proc1 arg env)
      (cases proc proc1
        (procedure (var body saved-env)
          (value-of body (extend-env var arg saved-env)))
        (dynproc (var body)
                 (value-of body (extend-env var arg env))))))


  (define Evaluate
    (lambda (lst env)
      (cond
        ((null? lst) '())
        (else (cons (value-of (car lst)) (Evaluate (cdr lst) env))))))
      
  
  
  ;;;; DO NOT REMOVE THE FOLLOWING PARENTHESIS
)
