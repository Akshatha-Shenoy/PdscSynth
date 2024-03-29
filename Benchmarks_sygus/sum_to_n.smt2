(declare-rel Inv (Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int))
(declare-rel RelBad (Int Int Int))
(declare-var sump Int)
(declare-var ip Int)
(declare-var np Int)
(declare-var sum Int)
(declare-var i Int)
(declare-var n Int)
(declare-fun rel (Int Int) Int)
(rule (=> (= (rel n 0) (rel n 1)) (RelInit i n sum)))
(rule (=> (and (> n 0)(= sum 0) (= i 0)) (Inv i n sum)))
(rule (=> (and (Inv i n sum)
            (= np n)
            (ite (< i n)
                (and (= sump (+ sum i)) (= ip (+ i 1)))
                (and (= sump sum) (= ip i))
              )
            )(Inv ip np sump)))
(rule (=> (and (Inv i n sum)
         (= i n))
    End))
(rule (=> (distinct (rel sum 0) (rel sum 1)) (RelBad i n sum)))

; predicates
;stage 1- pre-post
(declare-rel i0_eq_0 (Int Int Int))
 (rule (=> (= 0 (rel i 0)) (i0_eq_0 i n sum)))
(declare-rel i1_eq_0 (Int Int Int))
 (rule (=> (= 0 (rel i 1)) (i1_eq_0 i n sum)))
(declare-rel i_eq_n (Int Int Int))
 (rule (=> (= i n) (i_eq_n i n sum)))
(declare-rel i_lt_n (Int Int Int))
 (rule (=> (< i n) (i_lt_n i n sum)))
(declare-rel sum0_eq_sum1 (Int Int Int))
 (rule (=> (= (rel sum 0) (rel sum 1)) (sum0_eq_sum1 i n sum)))
(declare-rel n_gt_0 (Int Int Int))
 (rule (=> (> n 0) (n_gt_0 i n sum)))
(declare-rel n0_eq_n1 (Int Int Int))
 (rule (=> (= (rel n 0) (rel n 1)) (n0_eq_n1 i n sum)))





(declare-rel p_synth_1 (Int Int Int))
 (rule (=>  (= (rel n 0) 1 ) (p_synth_1 i n sum)))
(declare-rel p_synth_2 (Int Int Int))
 (rule (=>  (= (rel sum 0)  (- (rel sum 1) (rel i 0))) (p_synth_2 i n sum)))
(declare-rel p_synth_3 (Int Int Int))
 (rule (=>  (= (rel sum 0)  (- (rel sum 1) 1 )) (p_synth_3 i n sum)))
(declare-rel p_synth_4 (Int Int Int))
 (rule (=>  (= (rel n 0) 2 ) (p_synth_4 i n sum)))
(declare-rel p_synth_5 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 3 (rel i 1))) (p_synth_5 i n sum)))
(declare-rel p_synth_6 (Int Int Int))
 (rule (=>  (= (rel n 0) 3 ) (p_synth_6 i n sum)))
(declare-rel p_synth_7 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 4 (rel i 1))) (p_synth_7 i n sum)))
(declare-rel p_synth_8 (Int Int Int))
 (rule (=>  (= (rel n 0) 4 ) (p_synth_8 i n sum)))
(declare-rel p_synth_9 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 5 (rel i 1))) (p_synth_9 i n sum)))
(declare-rel p_synth_10 (Int Int Int))
 (rule (=>  (= (rel n 0) 5 ) (p_synth_10 i n sum)))
(declare-rel p_synth_11 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 6 (rel i 1))) (p_synth_11 i n sum)))
(declare-rel p_synth_12 (Int Int Int))
 (rule (=>  (= (rel n 0) 6 ) (p_synth_12 i n sum)))
(declare-rel p_synth_13 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 7 (rel i 1))) (p_synth_13 i n sum)))
(declare-rel p_synth_14 (Int Int Int))
 (rule (=>  (= (rel n 0) 7 ) (p_synth_14 i n sum)))
(declare-rel p_synth_15 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 8 (rel i 1))) (p_synth_15 i n sum)))
(declare-rel p_synth_16 (Int Int Int))
 (rule (=>  (= (rel n 0) 8 ) (p_synth_16 i n sum)))
(declare-rel p_synth_17 (Int Int Int))
 (rule (=>  (= (rel i 1) 1 ) (p_synth_17 i n sum)))
(declare-rel p_synth_18 (Int Int Int))
 (rule (=>  (= (rel n 0)  (* 2 (rel i 1))) (p_synth_18 i n sum)))
(declare-rel p_synth_19 (Int Int Int))
 (rule (=>  (= (rel i 1) 2 ) (p_synth_19 i n sum)))
(query End)
