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
(declare-fun rel2 (Int Int) Int)
(rule (=> (and (= (rel x 0) (rel x 1)) (= (rel2 h 0) 1) (= (rel2 h 1) 0)) (RelInit  x h count)))
(rule (=>  (= 0 count) (Inv  x h count)))
(rule (=> (and (Inv  x h count) (= h hp)
            (ite (= 1 h)
                (ite  ( = 0 (mod x 7))
                        (and (= xp 8)(= countp 1))
                        (ite (= x 1009)
                            (and (= xp 1)(= countp 1))
                            (and (= xp x)(= countp 1))
                        )
                  )
                (ite  (= 0 (mod x 7))
                        (and (= xp 8)(= countp 1))
                        (and (= xp (mod x 7))(= countp 1))
                )
              )
            )
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
 (rule (=>   (and  (= (rel x 0)  (mod (rel x 1) 7 ) )  (= (rel x 0) (rel x 1) )  (not  (= 0  (mod (rel x 1) 7 ) ) ) ) (p_synth_1 x h count)))
(declare-rel p_synth_2 (Int Int Int))
 (rule (=>   (and  (or  (not  (= 1 (rel x 1) ) )  (not  (= (rel x 0) 1009 ) ) )  (not  (= (rel x 0) (rel x 1) ) )  (or  (not  (= 0  (mod (rel x 0) 7 ) ) )  (not  (= 8 (rel x 1) ) ) ) ) (p_synth_2 x h count)))
(declare-rel p_synth_3 (Int Int Int))
 (rule (=>   (and  (= (rel x 0) (rel x 1) ) (not  (= (rel x 0)  (mod (rel x 1) 7 ) ) ) (not  (= 0  (mod (rel x 1) 7 ) ) ) (or  (= 0  (mod (rel x 1) 7 ) )  (not  (= (rel x 1) 1009 ) ) ) ) (p_synth_3 x h count)))
(query End)