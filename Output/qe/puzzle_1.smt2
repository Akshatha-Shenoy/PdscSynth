(declare-rel Inv (Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int))
(declare-rel RelBad (Int Int Int Int))
(declare-var hp Int)
(declare-var h Int)
(declare-var endp Int)
(declare-var end Int)
(declare-var np Int)
(declare-var n Int)
(declare-var ct Int)
(declare-var ctp Int)

(declare-fun rel (Int Int) Int)

(rule (=> (and (= (rel n 0) (rel n 1)) (= (rel h 0) 1) (= (rel h 1) 0)) (RelInit end n h ct)))
(rule (=> (and (= 0 ct) (= end 0)) (Inv end n h ct)))
(rule (=> (and (Inv end n h ct) (= h hp)
            (ite (= 1 h)
                (ite (not (= n 0))
                     (ite (> (mod n 10) 0)
                             (and (= ctp (+ ct 1)) (= np (div n 10)) (= endp 0))
                             (and (= ctp ct) (= np (div n 10)) (= endp 0))
                      )
                     (and (= ctp ct) (= np n)(= endp 1))
                )
                (ite (not (= 1 end))
                  (and (= ctp (div n 10)) (= np n) (= endp 1))
                  (and (= ctp ct) (= np n) (= endp 1))
                ))) (Inv endp np hp ctp)))
(rule (=> (and (Inv end n h ct)
         (= 1 end))
    End))
(rule (=> (distinct (rel ct 0) (rel ct 1)) (RelBad end n h ct)))

; predicates
;stage 1- pre-post
(declare-rel n0_eq_n1 (Int Int Int Int))
 (rule (=> (= (rel n 0) (rel n 1)) (n0_eq_n1 end n h ct)))
(declare-rel abs_h (Int Int Int Int))
 (rule (=> (= 1 h) (abs_h end n h ct)))
(declare-rel abs_end (Int Int Int Int))
  (rule (=> (= 1 end) (abs_end end n h ct)))
(declare-rel ct_0 (Int Int Int Int))
 (rule (=> (= ct 0) (ct_0 end n h ct)))
(declare-rel ct_1 (Int Int Int Int))
 (rule (=> (= ct 1) (ct_1 end n h ct)))
(declare-rel ct0_eq_ct1 (Int Int Int Int))
  (rule (=> (= (rel ct 0) (rel ct 1)) (ct0_eq_ct1 end n h ct)))

























(declare-rel p_synth_1 (Int Int Int Int))
 (rule (=>   (and  (= (rel n 0) (rel n 1) )  (not  (=  (div (rel n 1) 10 ) 1 ) )  (not  (= 0  (div (rel n 1) 10 ) ) ) ) (p_synth_1 end n h ct)))
(declare-rel p_synth_2 (Int Int Int Int))
 (rule (=>   (and  (= (rel n 0) 0 )  (not  (= (rel n 0) (rel n 1) ) ) )  (p_synth_2 end n h ct)))
(declare-rel p_synth_3 (Int Int Int Int))
 (rule (=>   (and  (=  (div (rel n 1) 10 ) 0 )  (= (rel n 0) (rel n 1) ) )  (p_synth_3 end n h ct)))
(declare-rel p_synth_4 (Int Int Int Int))
 (rule (=>   (and  (= (rel n 0) (rel n 1) )  (=  (div (rel n 1) 10 ) 0 )  (= (rel n 0) 0 ) )  (p_synth_4 end n h ct)))
(query End)
