(declare-rel Inv (Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int))
(declare-rel RelBad (Int Int Int))
(declare-var hp Int)
(declare-var h Int)
(declare-var xp Int)
(declare-var x Int)
(declare-var count Int)
(declare-var countp Int)

(declare-fun rel (Int Int) Int)

(rule (=> (and (= (rel x 0) (rel x 1)) (= (rel h 0) 1) (= (rel h 1) 0)) (RelInit  x h count)))
(rule (=> (and (= 0 count)) (Inv  x h count)))
(rule (=> (and (Inv  x h count)
            (ite (= 1 h)
                (ite (= 0 count)
                      (and (= xp (- 42 x)) (= h hp) (= countp 1))
                      (and (= x xp)(= h hp)(= count countp))
                )
                (ite (= count 0)
                  (ite (= x 0)
                    (and (= xp 42)(= h hp)(= countp 1))
                    (ite (= x 42)
                      (and (= xp 0)(= h hp)(= countp 1))
                      (and (= xp 0)(= h hp)(= countp 1))
                    )
                  )
                  (and (= x xp)(= h hp)(= count countp))
                )
          ))
 (Inv xp hp countp)))
(rule (=> (and (Inv  x h count)
         (= 1 count) )
    End))
(rule (=> (distinct (rel x 0) (rel x 1)) (RelBad  x h count)))

; predicates
;stage 1- pre-post
(declare-rel x0_eq_x1 (Int Int Int))
 (rule (=> (= (rel x 0) (rel x 1)) (x0_eq_x1  x h count)))
(declare-rel abs_h (Int Int Int))
 (rule (=> (= 1 h) (abs_h x h count)))
(declare-rel count_0 (Int Int Int))
 (rule (=> (= count 0) (count_0 x h count)))
(declare-rel count_1 (Int Int Int))
 (rule (=> (= count 1) (count_1 x h count)))






(declare-rel p_synth_1 (Int Int Int))
 (rule (=>   (and  (not  (=  (*  (- 1 ) (rel x 0) )  (+  (- 42 ) (rel x 1) ) ) )  (not  (= (rel x 0) (rel x 1) ) ) ) (p_synth_1 x h count)))
(declare-rel p_synth_2 (Int Int Int))
 (rule (=>   (and  (not  (= (rel x 1) 42 ) )  (= (rel x 0) (rel x 1) )  (not  (= (rel x 1) 0 ) ) )  (p_synth_2 x h count)))
(query End)
