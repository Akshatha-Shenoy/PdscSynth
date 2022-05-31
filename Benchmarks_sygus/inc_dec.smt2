(declare-rel Inv (Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int))
(declare-rel RelBad (Int Int Int))
(declare-var countp Int)
(declare-var hp Int)
(declare-var lp Int)
(declare-var count Int)
(declare-var h Int)
(declare-var l Int)
(declare-fun rel (Int Int) Int)
(rule (=> (= (rel l 0) (rel l 1)) (RelInit l h count)))
(rule (=> (and (= count 0) (> h 0)) (Inv l h count)))
(rule (=> (and (Inv l h count)
            (= hp h)
            (ite (= count 0)
                (and (= lp (+ l h)) (= countp (+ count 1)))
                (ite (= count 1)
                    (and (= lp (- l h)) (= countp (+ count 1)))
                (and (= lp l) (= countp count))
                )
            )
          )
 (Inv lp hp countp)))
(rule (=> (and (Inv l h count)
         (= count 2) )
    End))
(rule (=> (distinct (rel l 0) (rel l 1)) (RelBad l h count)))

; predicates
;stage 1- pre-post
(declare-rel l0_eq_l1 (Int Int Int))
 (rule (=> (= (rel l 0) (rel l 1)) (l0_eq_l1 l h count)))
(declare-rel count0_eq_2 (Int Int Int))
 (rule (=> (= (rel count 0) 2) (count0_eq_2 l h count)))
(declare-rel count1_eq_2 (Int Int Int))
 (rule (=> (= (rel count 1) 2) (count1_eq_2 l h count)))
(declare-rel count_eq_0 (Int Int Int))
 (rule (=> (= count 0) (count_eq_0 l h count)))
(declare-rel h_gt_0 (Int Int Int))
 (rule (=> (> h 0) (h_gt_0 l h count)))








(declare-rel p_synth_1 (Int Int Int))
 (rule (=>  (= (rel h 1)  (- (rel l 1) (rel l 0))) (p_synth_1 l h count)))
(declare-rel p_synth_2 (Int Int Int))
 (rule (=>  (= (rel l 0)  (+ (rel h 0) (rel l 1))) (p_synth_2 l h count)))
(query End)