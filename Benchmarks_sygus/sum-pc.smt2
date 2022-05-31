(declare-rel Inv (Int Int Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int Int Int))
(declare-rel RelBad (Int Int Int Int Int Int))
(declare-var vp Int)
(declare-var yp Int)
(declare-var ip Int)
(declare-var hp Int)
(declare-var maxp Int)
(declare-var v Int)
(declare-var y Int)
(declare-var i Int)
(declare-var h Int)
(declare-var pc Int)
(declare-var pcp Int)
(declare-var max Int)
(declare-fun rel (Int Int) Int)
(rule (=> (= (rel max 0) (rel max 1)) (RelInit max h i y v pc)))
(rule (=> (and (> h 0)
         (> max h)
         (= i 0)
         (= pc (ite (<= h i) 1 0))
         (= y 0)
         (= v 0))
    (Inv max h i y v pc)))
(rule (=> (and (Inv max h i y v pc)
            (or (and (= v 0)
                    (= pc 0)
                    (= pcp (ite (<= hp ip) 1 0))
                    (< h max)
                    (= max maxp)
                    (= v vp)
                    (= h hp)
                    (= ip (+ i 1))
                    (= yp (+ y y)))
               (and (= v 0)
                    (= pc 1)
                    (= pcp (ite (<= max i) 3 2))
                    (>= i h)
                    (= max maxp)
                    (= vp 1)
                    (= h hp)
                    (= ip i)
                    (= yp y))
               (and (= v 1)
                    (= pc 2)
                    (= pcp (ite (= maxp ip) 3 2))
                    (< i max)
                    (= max maxp)
                    (= v vp)
                    (= h hp)
                    (= ip (+ i 1))
                    (= yp (+ y y)))
               (and (= pc 3)
                    (= pcp 3)
                    (= v vp)
                    (= max maxp)
                    (= h hp)
                    (= ip i)
                    (= yp y))
                    )) (Inv maxp hp ip yp vp pcp )))
(rule (=> (and (Inv max h i y v pc)
         (= i max))
    End))
    (rule (=> (distinct (rel y 0) (rel y 1)) (RelBad max h i y v pc)))

;predicates
;pc=0 (duplicates to pc0=0, pc1=0)
;pc=1 (duplicates to pc0=1, pc1=1)
;pc=2 (duplicates to pc0=2, pc1=2)
;pc=3 (duplicates to pc0=3, pc1=3)
;y0=y1
;i0=i1
;max0=max1
(declare-rel pc_eq_0 (Int Int Int Int Int Int))
(declare-rel pc_eq_1 (Int Int Int Int Int Int))
;(declare-rel pc_eq_2 (Int Int Int Int Int Int))
;(declare-rel pc_eq_3 (Int Int Int Int Int Int))
(declare-rel y0_eq_y1 (Int Int Int Int Int Int))
(declare-rel i0_eq_i1 (Int Int Int Int Int Int))
(declare-rel max0_eq_max1 (Int Int Int Int Int Int))
(declare-rel i_eq_max (Int Int Int Int Int Int))
 (rule (=> (= pc 0) (pc_eq_0 max h i y v pc)))
 (rule (=> (= pc 1) (pc_eq_1 max h i y v pc)))
;(rule (=> (= pc 2) (pc_eq_2 max h i y v pc)))
; (rule (=> (= pc 3) (pc_eq_3 max h i y v pc)))
 (rule (=> (= (rel y 0) (rel y 1)) (y0_eq_y1 max h i y v pc)))
 (rule (=> (= (rel i 0) (rel i 1)) (i0_eq_i1 max h i y v pc)))
 (rule (=> (= (rel max 0) (rel max 1)) (max0_eq_max1 max h i y v pc)))
(rule (=> (= i max) (i_eq_max max h i y v pc)))








(declare-rel p_synth_1 (Int Int Int Int Int Int))
 (rule (=>  (< (rel i 0) (rel h 1)) (p_synth_1 max h i y v pc)))
(declare-rel p_synth_2 (Int Int Int Int Int Int))
 (rule (=>  (= (rel y 0) (rel v 1)) (p_synth_2 max h i y v pc)))
(declare-rel p_synth_3 (Int Int Int Int Int Int))
 (rule (=>  (= (rel h 1)  (+ (rel i 0) 1 )) (p_synth_3 max h i y v pc)))
(declare-rel p_synth_4 (Int Int Int Int Int Int))
 (rule (=>  (= (rel h 1) (rel h 0)) (p_synth_4 max h i y v pc)))
(declare-rel p_synth_5 (Int Int Int Int Int Int))
 (rule (=>  (= (rel h 1)  (+ (rel h 1) (rel y 0))) (p_synth_5 max h i y v pc)))
(query End)