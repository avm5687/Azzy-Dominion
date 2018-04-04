#lang eopl
(define lists '())

(define duple
  (lambda(n x)
    (cond
      ((eq? n 0) `())
      ((cons x (duple (- n 1) x))))))

(define down
  (lambda(lst)
    (cond
      ((null? lst) '())
      ((cons(cons (car lst) '())
            (down (cdr lst)))))))

(define invert
  (lambda(lst)
    (cond
      ((null? lst) '())
      ((cons (reverse(car lst)) (invert (cdr lst)))))))

(define filter-in
  (lambda(pred lst)
   (cond
    ((null? lst) '())
    ((pred (car lst)) (cons (car lst) (filter-in pred (cdr lst))))
        (else (filter-in pred (cdr lst))))))

(define every?
  (lambda(pred lst)
    (cond
      ((= (length(filter-in pred lst)) (length lst)) #t)
      (else #f))))

(define exists?
  (lambda(pred lst)
    (cond
      ((> (length(filter-in pred lst)) (length lists)) #t)
       (else #f))))

(define merge
  (lambda(1on1 1on2)
    (cond
      ((if (null? 1on1) 1on2
           (if (null? 1on2) 1on1
               (if(< (car 1on1) (car 1on2))
                  (cons(car 1on1) (merge (cdr 1on1) 1on2))
                  (cons(car 1on2) (merge (cdr 1on2) 1on1)))))))))

  
(define rotate
  (lambda(lst)
    (cond
      ((null? lst) '())
      ((cons (car(reverse lst)) (reverse(cdr(reverse lst))))))))

(define up
  (lambda(lst)
    (cond
      ((null? lst) '())
      ((upHelp (car lst) (cdr lst))))))

(define upHelp
  (lambda(lst1 lst2)
    (cond
      ((null? lst1) (up lst2))
      ((pair? lst1) (cons (car lst1)
                          (upHelp (cdr lst1) lst2)))
      (else (cons lst1 (up lst2))))))

(define flatten
  (lambda(slst)
    (cond
      ((null? slst) '())
      ((list? (car slst)) (append (flatten (car slst)) (flatten(cdr slst))))
      (else(cons (car slst) (flatten(cdr slst)))))))


(define count-occurrences
  (lambda(s slst)
    (cond
      ((null? slst) '0)
      ((list? (car slst)) (count-occurrences s (flatten slst))) 
      ((eq? s (car slst)) (+ 1 (count-occurrences s (cdr slst))))
      (else(count-occurrences s (cdr slst))))))

(define swapper
  (lambda(s1 s2 slst)
   (cond
     ((null? slst) '())
     ((eq? s1 (car slst)) (cons s2 (swapper s1 s2 (cdr slst))))
     ((eq? s2 (car slst)) (cons s1 (swapper s1 s2 (cdr slst))))
     ((list? (car slst)) (cons (swapper s1 s2 (car slst)) (swapper s1 s2 (cdr slst))))
     (else (cons (car slst) (swapper s1 s2 (cdr slst)))))))

(define list-index
  (lambda(pred lst)
    (cond
      ((null? lst) #f)
      ((pred (car lst)) 0)
      ((eq? (list-index pred (cdr lst)) #f) #f)
      (else (+ (list-index pred (cdr lst)) 1)))))

(define index
  (lambda(s lst)
    (cond
      ((null? lst) #f)
      ((eq? s (car lst)) 0)
      ((eq? (index s (cdr lst)) #f) #f)
      (else (+ (index s (cdr lst)) 1)))))

(define ribassoc
  (lambda(s los v fail-value)
    (let ((a (index s los)))
      (cond
        ((null? los) fail-value)
        ((eq? a #f) fail-value)
        (else (vector-ref v a))))))

(define product
  (lambda(sos1 sos2)
    (cond
      ((null? sos1) '())
      ((null? sos2) '())
      (else(append (productHelp sos1 sos2) (product (cdr sos1) sos2))))))

(define productHelp
  (lambda (sos1 sos2)
    (cond
      ((null? sos2) '())
      (else(cons (list (car sos1) (car sos2)) (productHelp sos1 (cdr sos2)))))))
      