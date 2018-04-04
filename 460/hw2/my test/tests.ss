#lang racket
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
      (s-list-conv1 (equal?? (s-list->scheme-list (scheme-list->s-list '(can i pass)))
                             (can i pass)))
      (s-list-conv2 (equal?? (s-list->scheme-list (scheme-list->s-list '(can i go (home))))
                             (can i go (home))))
      (s-list-conv3 (equal?? (s-list->scheme-list (scheme-list->s-list '(T (ake) me (home) (tonight))))
                             (T (ake) me (home) (tonight))))
      (s-list-conv4 (equal?? (s-list->scheme-list (scheme-list->s-list '(Master gave Dobby A Dobby is free)))
                             (Master gave Dobby A Dobby is free)))
      (s-list-conv5 (equal?? (s-list->scheme-list (scheme-list->s-list '(Please let me graduate))) (Please let me graduate)))
      (s-list-conv6 (equal?? (s-list->scheme-list (scheme-list->s-list '(I really just want to pass)))
                             (I really just want to pass)))
      (s-list-conv7 (equal?? (s-list->scheme-list (scheme-list->s-list '(These (assignments) actually make me cry)))
                             (These (assignments) actually make me cry)))
      (s-list-conv8 (equal?? (s-list->scheme-list (scheme-list->s-list '(Done (done) cry (whimper) (want to die))))
                             (Done (done) cry (whimper) (want to die))))
      (s-list-conv9 (equal?? (s-list->scheme-list (scheme-list->s-list '((we(belong)) way down below)))
                             ((we (belong)) way down below)))
      (s-list-convo10 (equal?? (s-list->scheme-list (scheme-list->s-list '(I want to die)))
                               (I want to die)))
      
      
      ;; subst
      (subst1 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'b)
                               (scheme-exp->s-exp 'c)
                               (scheme-list->s-list '())))
                       ()))
      (subst2 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'cookie)
                               (scheme-exp->s-exp 'mexican)
                               (scheme-list->s-list '(I want cookie))))
                       (I want mexican)))
      (subst3 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'fail)
                               (scheme-exp->s-exp 'graduate)
                               (scheme-list->s-list '(i will fail))))
                       (I will graduate)))
      (subst4 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'b)
                               (scheme-exp->s-exp 'taco)
                               (scheme-list->s-list '(a b a c a))))
                       (a taco a c a)))
     (subst5 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'burrito)
                               (scheme-exp->s-exp 'taco)
                               (scheme-list->s-list '(a b a c a))))
                       (a b a c a)))
     
     (subst6 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'life)
                               (scheme-exp->s-exp 'death)
                               (scheme-list->s-list '(i am life destroyer of worlds))))
                       (i am death destroyer of worlds)))
     
     (subst7 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'here)
                               (scheme-exp->s-exp 'not)
                               (scheme-list->s-list '(i am life destroyer of worlds))))
                       (i am life destroyer of worlds)))
     (subst8 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'live)
                               (scheme-exp->s-exp 'die)
                               (scheme-list->s-list '(i want to live))))
                       (i want to die)))
     (subst9 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'home)
                               (scheme-exp->s-exp 'hell)
                               (scheme-list->s-list '(i am in home))))
                       (i am in hell)))

    (subst10 (equal?? (s-list->scheme-list
                        (subst (scheme-exp->s-exp 'do)
                               (scheme-exp->s-exp 'dont)
                               (scheme-list->s-list '(i do matter))))
                       (i dont matter)))
      ;; lc-exp->scheme-exp  and  scheme-exp->lc-exp
      (exp-conv1 (equal?? (lc-exp->scheme-exp (scheme-exp->lc-exp 'b)) a))
      (exp-conv2 (equal?? (lc-exp->scheme-exp (scheme-exp->lc-exp '(be you))) (be you)))
      (exp-conv3 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(lambda (you) me)))
                  (lambda (you) me)))
      (exp-conv3 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '((lambda (try) me) (lambda (try) me))))
                  ((lambda (try) me) (lambda (try) me))))
      (exp-conv4 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (no)
                       (lambda (no)
                         (((f a) ((b c) (d e))) ((((f g) (h i)) ((j k) (l m))) ((n o) (p q))))))))
                  (lambda (no)
                    (lambda (no)
                      (((f a) ((b c) (d e))) ((((f g) (h i)) ((j k) (l m))) ((n o) (p q))))))))
      (exp-conv5 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(selene)))
                  (selene)))
      (exp-conv6 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '(lambda (c) b)))
                  (lambda (c) b)))
      (exp-conv7 (equal??
                  (lc-exp->scheme-exp (scheme-exp->lc-exp '((lambda (scream) silent) (lambda (a) a))))
                  ((lambda (scream) silent) (lambda (a) a))))
      (exp-conv8 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (no)
                       (lambda (more)
                         (lambda (tears)
                           (lambda (only)
                             (lambda (silent)
                               (lambda (screams) (drown)))))))))
                  (lambda (no)
                    (lambda (more)
                      (lambda (tears) (lambda (only) (lambda (silent) (lambda (screams) (drown)))))))))
      (exp-conv9 (equal??
                  (lc-exp->scheme-exp
                   (scheme-exp->lc-exp
                    '(lambda (the end is coming)
                       (lambda (living was for nothing)
                         (f o r g i v e m e)))))
                  (lambda (the end is coming)
                    (lambda (living was for nothing)
                      (f o r g i v e m e)))))
      (exp-conv10 (equal??
                   (lc-exp->scheme-exp
                    (scheme-exp->lc-exp
                     '((lambda (b)
                         ((lambda (b)
                            ((lambda (c)
                               ((lambda (death) (c o m e)) (f o r))) (m e))) (a)))
                       (lambda (s)
                         ((lambda (w)
                            ((lambda (e)
                               ((lambda (e) (t e s c)) (a p e))) (y e))) (s))))))
                   ((lambda (b)
                      ((lambda (b) ((lambda (c) ((lambda (death) (c o m e)) (f o r))) (m e))) (a)))
                    (lambda (s)
                      ((lambda (w) ((lambda (e) ((lambda (e) (t e s c)) (a p e))) (y e))) (s))))))


      

      
      ;; free-vars
      (free-vars1 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda () b))) (b)))
      (free-vars2 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (ab) ab))) ()))
      (free-vars3 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (tru) tru))) ()))
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
                     '(lambda (true)
                        (lambda (true) (true life)))))
                   (life)))
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
      (free-vars7 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (tru blood) tru))) (blood)))
      (free-vars8 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (goop truth) truth))) (goop)))
      (free-vars9 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (truth hurts) truth))) (hurts)))
      (free-vars10 (set-equal?? (free-vars (scheme-exp->lc-exp '(lambda (make me) make))) (me)))
      ;; bound-vars
      (bound-vars1 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda () true))) ()))
      (bound-vars2 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda (bleed) bleed))) (bleed)))
      (bound-vars3 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda (cookie d) d))) (d)))
      (bound-vars4 (set-equal?? (bound-vars
                                 (scheme-exp->lc-exp
                                  '(lambda (c)
                                     (lambda (o)
                                       (lambda (o)
                                         (lambda (k)
                                           (lambda (i)
                                             (lambda (e) (c o o k i e)))))))))
                                (c o k i e)))
      (bound-vars5 (set-equal?? (bound-vars
                                 (scheme-exp->lc-exp
                                  '(lambda (make)
                                     (lambda (money)
                                       (make money scrub)))))
                                (make money)))
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
      (bound-vars7 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda () monkey))) ()))
      (bound-vars8 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda () turkey))) ()))
      (bound-vars9 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda (hate the true lies) true))) (true)))
      (bound-vars10 (set-equal?? (bound-vars (scheme-exp->lc-exp '(lambda () country))) ()))

      )
    )
  )
