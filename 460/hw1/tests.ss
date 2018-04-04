;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CMPSC 460-001                        ;;;
;;; Homework 1                           ;;;
;;; Azalee McAlpine                      ;;;
;;; avm5687                              ;;;
;;;                                      ;;;
;;; Note:                                ;;;
;;;   Write whatever you want the grader ;;;
;;;   to know before grading.            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; Use the following test cases for initial testing.
;;;; Once you are done, remove the provided test cases
;;;;   and add at least 5 test cases of your own for
;;;;   each procedure


(module tests mzscheme
  
  (provide test-list)

  (define test-list
    '(

      ;; (duple n x)
      (duple1 (equal?? (duple 5 '(Jokes)) ((Jokes) (Jokes) (Jokes) (Jokes) (Jokes))))
      (duple2 (equal?? (duple 3 10) (10 10 10)))
      (duple3 (equal?? (duple 4 4) (4 4 4 4)))
      (duple4 (equal?? (duple 1 123) (123)))
      (duple5 (equal?? (duple 2 458) (458 458)))
      
      ;; (invert lst)
      (invert1 (equal?? (invert '((1 5) (no yes) (so maybe))) ((5 1) (yes no) (maybe so))))
      (invert2 (equal?? (invert '((me why) (strength brute))) ((why me) (brute strength))))
      (invert3 (equal?? (invert '((that play) (loud music) (to time) (down get))) ((play that) (music loud) (time to) (get down))))
      (invert4 (equal?? (invert '((12 34) (patriot last))) ((34 12) (last patriot))))
      (invert5 (equal?? (invert '((prescence your) (lingers still) (my here) (Evanescence immortal))) ((your prescence) (still lingers) (here my) (immortal Evanescence))))

      ;; (down lst)
      (down1 (equal?? (down '(This is not the droid)) ((This) (is) (not) (the) (droid))))
      (down2 (equal?? (down '(Down with the sickness)) ((Down) (with) (the) (sickness))))
      (down3 (equal?? (down '(Merry Christmas Filthy Animals)) ((Merry) (Christmas) (Filthy) (Animals))))
      (down4 (equal?? (down '(RAWR rawr RAWR rawr huh 1526 58)) ((RAWR) (rawr) (RAWR) (rawr) (huh) (1526) (58))))
      (down5 (equal?? (down '(Down the rabbit hole)) ((Down) (the) (rabbit) (hole))))

      ;; (up list)
      (up1 (equal?? (up '((Make my) (day))) (Make my day)))
      (up2 (equal?? (up '((pikachu (I) choose (you)))) (pikachu (I) choose (you))))
      (up3 (equal?? (up '((This) was (the fault of) negligence)) (This was the fault of negligence)))
      (up4 (equal?? (up '((12) 13 (58))) (12 13 58)))
      (up4 (equal?? (up '((cake) 13 (make))) (cake 13 make)))
      
      ;; (swapper s1 s2 slist)
      (swapper1 (equal?? (swapper 'you 'me '(me b you d)) (you b me d)))
      (swapper2 (equal?? (swapper 'be 'my '(my be valentine)) (be my valentine)))
      (swapper3 (equal?? (swapper '3 '4 '(1 2 4 3)) (1 2 3 4)))
      (swapper4 (equal?? (swapper 'ice 'baby '(baby ice)) (ice baby)))
      (swapper5 (equal?? (swapper 'for 'Gondor '(Gondor for)) (for Gondor)))

      ;; (count-occurrences s slst)
      (count-occurences1 (equal?? (count-occurrences 'we '((we we) y (((x we) we)))) 4))
      (count-occurences2 (equal?? (count-occurrences '3 '((f 3) 3 (((x z) (3) x)))) 3))
      (count-occurences3 (equal?? (count-occurrences '123 '((123) y (((x z) 123)))) 2))
      (count-occurences4 (equal?? (count-occurrences 'make '((make) make make ((make (x make) 123)))) 5))
      (count-occurences5 (equal?? (count-occurrences 'add '((add) mad add () (add (add (x mad) () add add addd)))) 6))

      ;; (product sos1 sos2)
      (product1 (set-equal?? (product '(make take break) '(it)) ((make it) (take it) (break it))))
      (product2 (set-equal?? (product '(send) '(cookies milk help sadness)) ((send cookies) (send milk) (send help) (send sadness))))
      (product3 (set-equal?? (product '(FAIL) '()) ()))
      (product4 (set-equal?? (product '(Say 12) '(it Mick 12)) ((Say it) (Say Mick) (Say 12) (12 it) (12 Mick) (12 12))))
      (product5 (set-equal?? (product '(marker throw) '(throw marker)) ((marker throw) (marker marker) (throw throw) (throw marker))))

      ;; (filter-in pred lst)
      (filter-in1 (equal?? (filter-in symbol? '(quitters (1 3) dont smoke (cigar) 7)) (quitters dont smoke)))
      (filter-in2 (equal?? (filter-in symbol? '(war (cookie) 69 what 72 is 13 it 12 good 12 for)) (war what is it good for)))
      (filter-in3 (equal?? (filter-in number? '(82 (15) 69 what 72 is 13 12 this 12 for)) (82 69 72 13 12 12)))
      (filter-in4 (equal?? (filter-in number? '(146 (cookie))) (146)))
      (filter-in5 (equal?? (filter-in symbol? '(Luke (cookie) 69 I am 7234 your 1312 12 father)) (Luke I am your father)))

      ;; (list-index pred lst)
      (list-index1 (equal?? (list-index number? '(bite 16 (1 3) food 7)) 1))
      (list-index2 (equal?? (list-index symbol? '(2 make (b 3) 18 78)) 1))
      (list-index3 (equal?? (list-index symbol? '(1 2 3 4 5)) #f))
      (list-index4 (equal?? (list-index symbol? '(0 1 2 tree)) 3))
      (list-index5 (equal?? (list-index number? '((1 2) fish are friends not food (4 5))) #f))

      ;; (every? pred lst)
      (every?1 (equal?? (every? symbol? '(mexican food is the best)) #t))
      (every?2 (equal?? (every? number? '(12 13 45 68 98 75 12 145 147 1568)) #t))
      (every?3 (equal?? (every? number? '(NO)) #f))
      (every?4 (equal?? (every? symbol? '(I am 22)) #f))
      (every?5 (equal?? (every? symbol? '(I am the awkward child)) #t))
      
      ;; (exist? pred lst)
      (exists?1 (equal?? (exists? number? '(dino go rawr 3)) #t))
      (exists?2 (equal?? (exists? number? '(dino no like the number)) #f))
      (exists?3 (equal?? (exists? symbol? '(Save my soul 4)) #t))
      (exists?4 (equal?? (exists? number? '(Dressed in (lies) beauty that will rot)) #f))
      (exists?5 (equal?? (exists? symbol? '(4 444 44 44 44 44 4 44)) #f))

      ;; (flatten slst)
      (flatten1 (equal?? (flatten '(what is in your (head))) (what is in your head)))
      (flatten2 (equal?? (flatten '(zombie ((zombie)) (zombie (zombie)))) (zombie zombie zombie zombie)))
      (flatten3 (equal?? (flatten '(zombie ((zombie)) (in (2018)))) (zombie zombie in 2018)))
      (flatten4 (equal?? (flatten '(a b (() d 45 (c)))) (a b d 45 c)))
      (flatten5 (equal?? (flatten '(send ((help)) (typical (w(e)) illusion))) (send help typical w e illusion)))

      ;; (merge lon1 lon2)
      (merge1 (equal?? (merge '(12 13 14) '(12 15 18)) (12 12 13 14 15 18)))
      (merge2 (equal?? (merge '(100 102 104 106) '(101 103 105)) (100 101 102 103 104 105 106)))
      (merge3 (equal?? (merge '(10 11 12 13) '(14 15)) (10 11 12 13 14 15)))
      (merge4 (equal?? (merge '() '(101 103 105)) (101 103 105)))
      (merge5 (equal?? (merge '(15 16 17) '()) (15 16 17)))

      ;; (ribassoc s los v fail-value)
      (ribassoc1 (equal?? (ribassoc '4 '(a b c) '#(1 2 3) 'nope) nope))
      (ribassoc2 (equal?? (ribassoc '43 '(a b 43 4) '#(3 blue bar 54) 'fail) bar))
      (ribassoc3 (equal?? (ribassoc 'icky '(icky bic 34 12) '#(sticky (fz) () (fm fe)) 'whatever) sticky))
      (ribassoc4 (equal?? (ribassoc 'droid '(luke leia vader jabba) '#(gross (fz) () (tube)) 'ObiWan) ObiWan))
      (ribassoc5 (equal?? (ribassoc 'jack '(jack sparrow pirate carribean) '#(almostCaught 12 () pearl) 'jail) almostCaught))
      
      ;; (rotate los)
      (rotate1 (equal?? (rotate '(make it take it)) (it make it take)))
      (rotate2 (equal?? (rotate '()) ()))
      (rotate3 (equal?? (rotate '(15 13 14 12)) (12 15 13 14)))
      (rotate4 (equal?? (rotate '(cookie a want)) (want cookie a)))
      (rotate5 (equal?? (rotate '(Mythra Pyra Choose)) (Choose Mythra Pyra)))

      )
    )
  )