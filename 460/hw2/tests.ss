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


;;;; Use the following test cases for initial testing.
;;;; Once you are done, remove the provided test cases
;;;;   and add at least 10 test cases of your own for
;;;;   each procedure


(module tests mzscheme
  
  (provide test-list)

  (define test-list
    '(
      ;; s-list->scheme-list  and  scheme-list->s-list
      (s-list-conv1 (equal?? (s-list->scheme-list (scheme-list->s-list '(a b c)))
                             (a b c)))
      (s-list-conv2 (equal?? (s-list->scheme-list
                              (scheme-list->s-list
                               '(an (((s-list)) (with () lots) ((of) nesting)))))
                             (an (((s-list)) (with () lots) ((of) nesting)))))

      ;; subst
      (subst1 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'a)
                               (scheme-exp->s-exp 'd)
                               (scheme-list->s-list '())))
                       ()))
      (subst2 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'a)
                               (scheme-exp->s-exp 'd)
                               (scheme-list->s-list '(a b c))))
                       (d b c)))
      (subst3 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'a)
                               (scheme-exp->s-exp 'd)
                               (scheme-list->s-list '(a b a c a))))
                       (d b d c d)))
      (subst4 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'z)
                               (scheme-exp->s-exp 'd)
                               (scheme-list->s-list '(a b a c a))))
                       (a b a c a)))

      ;; lc-exp->scheme-exp  and  scheme-exp->lc-exp
      (exp-conv1 (equal?? (lc-exp->scheme-exp (scheme-exp->lc-exp 'a)) a))
      (exp-conv2 (equal?? (lc-exp->scheme-exp (scheme-exp->lc-exp '(x y))) (x y)))
      (exp-conv3 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(lambda (a) b)))
                  (lambda (a) b)))
      (exp-conv3 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '((lambda (a) a) (lambda (a) a))))
                  ((lambda (a) a) (lambda (a) a))))
      (exp-conv4 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (a b c d e f g h i)
                       (lambda (h i j k l m n o p)
                         (((f a) ((b c) (d e))) ((((f g) (h i)) ((j k) (l m))) ((n o) (p q))))))))
                  (lambda (a b c d e f g h i)
                    (lambda (h i j k l m n o p)
                      (((f a) ((b c) (d e))) ((((f g) (h i)) ((j k) (l m))) ((n o) (p q))))))))
      (exp-conv5 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(v w x y z)))
                  (v w x y z)))
      (exp-conv6 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(lambda (a) b)))
                  (lambda (a) b)))
      (exp-conv7 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '((lambda (a) a) (lambda (a) a))))
                  ((lambda (a) a) (lambda (a) a))))
      (exp-conv8 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (a)
                       (lambda (b)
                         (lambda (c)
                           (lambda (d)
                             (lambda (e)
                               (lambda (f) (f a b c d e f)))))))))
                  (lambda (a)
                    (lambda (b)
                      (lambda (c) (lambda (d) (lambda (e) (lambda (f) (f a b c d e f)))))))))
      (exp-conv9 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (a b c d e f g h i)
                       (lambda (h i j k l m n o p)
                         (f a b c d e f g h i j k l m n o p q)))))
                  (lambda (a b c d e f g h i)
                    (lambda (h i j k l m n o p)
                      (f a b c d e f g h i j k l m n o p q)))))
      (exp-conv10 (equal??
                   (lc-exp->scheme-exp
                    (scheme-exp->lc-exp
                     '((lambda (a)
                         ((lambda (b)
                            ((lambda (c)
                               ((lambda (d) (a b c d)) (b c d))) (a d))) (c)))
                       (lambda (a)
                         ((lambda (b)
                            ((lambda (c)
                               ((lambda (d) (a b c d)) (b c d))) (a d))) (c))))))
                   ((lambda (a)
                      ((lambda (b) ((lambda (c) ((lambda (d) (a b c d)) (b c d))) (a d))) (c)))
                    (lambda (a)
                      ((lambda (b) ((lambda (c) ((lambda (d) (a b c d)) (b c d))) (a d))) (c))))))


      

      
      ;; free-vars
      (free-vars1 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda () a))) (a)))
      (free-vars2 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (a) a))) ()))
      (free-vars3 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (a b c d) d))) ()))
      (free-vars4 (set-equal?? (free-vars
                                (scheme-exp->lc-exp
                                 '(lambda (a)
                                    (lambda (b)
                                      (lambda (c)
                                        (lambda (d)
                                          (lambda (e)
                                            (lambda (f) (f a b c d e f))))))))) ()))
      (free-vars5 (set-equal??
                   (free-vars
                    (scheme-exp->lc-exp
                     '(lambda (a b c d e f g h i)
                        (lambda (h i j k l m n o p) (f a b c d e f g h i j k l m n o p q)))))
                   (q)))
      (free-vars6 (set-equal??
                   (free-vars
                    (scheme-exp->lc-exp
                     '((lambda (a)
                         ((lambda (b)
                            ((lambda (c)
                               ((lambda (d) (a b c d)) (b c d))) (a d))) (c)))
                       (lambda (a)
                         ((lambda (b)
                            ((lambda (c)
                               ((lambda (d) (a b c d)) (b c d))) (a d))) (c))))))
                   (d c)))

      ;; bound-vars
      (bound-vars1 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda () a))) ()))
      (bound-vars2 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda (a) a))) (a)))
      (bound-vars3 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda (a b c d) d))) (d)))
      (bound-vars4 (set-equal?? (bound-vars
                                 (scheme-exp->lc-exp
                                  '(lambda (a)
                                     (lambda (b)
                                       (lambda (c)
                                         (lambda (d)
                                           (lambda (e)
                                             (lambda (f) (f a b c d e f)))))))))
                                (a b c d e f)))
      (bound-vars5 (set-equal?? (bound-vars
                                 (scheme-exp->lc-exp
                                  '(lambda (a b c d e f g h i)
                                     (lambda (h i j k l m n o p)
                                       (f a b c d e f g h i j k l m n o p q)))))
                                (a b c d e f g h i j k l m n o p)))
      (bound-vars6 (set-equal?? (bound-vars
                                 (scheme-exp->lc-exp
                                  '((lambda (a)
                                      ((lambda (b)
                                         ((lambda (c)
                                            ((lambda (d) (a b c d))
                                             (b c d)))
                                          (a d)))
                                       (c)))
                                    (lambda (a)
                                      ((lambda (b)
                                         ((lambda (c)
                                            ((lambda (d)
                                               (a b c d))
                                             (b c d)))
                                          (a d)))
                                       (c))))))
                                (d b c a)))

      )
    )
  )
