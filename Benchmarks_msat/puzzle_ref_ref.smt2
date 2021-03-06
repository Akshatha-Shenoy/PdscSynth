(declare-rel Inv (Int Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int Int))
(declare-rel RelBad (Int Int Int Int Int))
(declare-var hp Int)
(declare-var h Int)
(declare-var endp Int)
(declare-var end Int)
(declare-var np Int)
(declare-var n Int)
(declare-var mp Int)
(declare-var m Int)
(declare-var ct Int)
(declare-var ctp Int)

(declare-fun rel (Int Int) Int)

(rule (=> (and (= (rel n 0) (rel n 1)) (= (rel h 0) 1) (= (rel h 1) 0)) (RelInit end n m h ct)))
(rule (=> (and (= 0 ct)(= m n)(= end 0)) (Inv end n m h ct)))
(rule (=> (and (Inv end n m h ct) (= h hp)
                (ite (not (= n 0))
                     (ite (> (mod n 10) 0)
                             (and (= ctp (+ ct 1)) (= np (div n 10))(= mp m) (= endp 0))
                             (and (= ctp ct) (= np (div n 10))(= mp m) (= endp 0))
                      )
                     (and (= ctp ct)(= mp m)(= np n)(= endp 1))
              )) (Inv endp np mp hp ctp)))
(rule (=> (and (Inv end n m h ct)
         (= 1 end))
    End))
(rule (=> (distinct (rel ct 0) (rel ct 1)) (RelBad end n m h ct)))

; predicates
;stage 1- pre-post
(declare-rel n0_eq_n1 (Int Int Int Int Int))
 (rule (=> (= (rel n 0) (rel n 1)) (n0_eq_n1 end n m h ct)))
(declare-rel m_eq_n (Int Int Int Int Int))
  (rule (=> (= m n) (m_eq_n end n m h ct)))
(declare-rel abs_h (Int Int Int Int Int))
 (rule (=> (= 1 h) (abs_h end n m h ct)))
(declare-rel abs_end (Int Int Int Int Int))
  (rule (=> (= 1 end) (abs_end end n m h ct)))
(declare-rel ct_0 (Int Int Int Int Int))
 (rule (=> (= ct 0) (ct_0 end n m h ct)))
(declare-rel ct_1 (Int Int Int Int Int))
 (rule (=> (= ct 1) (ct_1 end n m h ct)))
(declare-rel ct0_eq_ct1 (Int Int Int Int Int))
  (rule (=> (= (rel ct 0) (rel ct 1)) (ct0_eq_ct1 end n m h ct)))






(query End)
