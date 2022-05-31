(declare-rel Inv (Int Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int Int))
(declare-rel RelBad (Int Int Int Int Int))
(declare-var pcp Int)
(declare-var yp Int)
(declare-var ip Int)
(declare-var xp Int)
(declare-var maxp Int)
(declare-var pc Int)
(declare-var y Int)
(declare-var i Int)
(declare-var x Int)
(declare-var max Int)
(declare-fun rel (Int Int) Int)
(rule (=> (= (rel max 0) (rel max 1)) (RelInit max x i y pc)))
(rule (=> (and (> x 0)
         (> max x)
         (= i 0)
         (= y 0)
         (= pc 0))
    (Inv max x i y pc)))
(rule (=> (and (Inv max x i y pc)
            (or (and (= pc 0)
                    (< i x)
                    (= max maxp)
                    (= pc pcp)
                    (= x xp)
                    (= ip (+ i 1))
                    (= yp (+ y i)))
               (and (= pc 0)
                    (>= i x)
                    (= max maxp)
                    (= pcp 1)
                    (= x xp)
                    (= ip i)
                    (= yp y))
               (and (= pc 1)
                    (< i max)
                    (= max maxp)
                    (= pc pcp)
                    (= x xp)
                    (= ip (+ i 1))
                    (= yp (+ y i)))
               (and (>= i max)
                    (= pc pcp)
                    (= max maxp)
                    (= x xp)
                    (= ip i)
                    (= yp y))
                    )) (Inv maxp xp ip yp pcp)))
(rule (=> (and (Inv max x i y pc)
         (>= i max))
    End))
    (rule (=> (distinct (rel y 0) (rel y 1)) (RelBad max x i y pc)))

; predicates
(declare-rel x_gt_0 (Int Int Int Int Int))
(declare-rel max_gt_x (Int Int Int Int Int))
;(declare-rel i_lt_x (Int Int Int Int Int))
(declare-rel i_lt_max (Int Int Int Int Int))
(declare-rel pc_eq_1 (Int Int Int Int Int))
(declare-rel pc_eq_0 (Int Int Int Int Int))
(declare-rel y_eq_0 (Int Int Int Int Int))
(declare-rel i_eq_0 (Int Int Int Int Int))
(declare-rel y0_eq_y1 (Int Int Int Int Int))
(declare-rel i0_eq_i1 (Int Int Int Int Int))
(declare-rel max0_eq_max1 (Int Int Int Int Int))
 (rule (=> (> x 0) (x_gt_0 max x i y pc)))
 (rule (=> (> max x) (max_gt_x max x i y pc)))
 ;(rule (=> (< i x) (i_lt_x max x i y pc)))
 (rule (=> (< i max) (i_lt_max max x i y pc)))
 (rule (=> (= pc 0) (pc_eq_0 max x i y pc)))
 (rule (=> (= pc 1) (pc_eq_1 max x i y pc)))
 (rule (=> (= (rel y 0) (rel y 1)) (y0_eq_y1 max x i y pc)))
(rule (=> (= (rel i 0) (rel i 1)) (i0_eq_i1 max x i y pc)))
 (rule (=> (= (rel max 0) (rel max 1)) (max0_eq_max1 max x i y pc)))
 (rule (=> (= y 0) (y_eq_0 max x i y pc)))
 (rule (=> (= i 0) (i_eq_0 max x i y pc)))












































(declare-rel p_synth_1 (Int Int Int Int Int))
 (rule (=>  (= (rel i 0) (rel x 0)) (p_synth_1 max x i y pc)))
(declare-rel p_synth_2 (Int Int Int Int Int))
 (rule (=>  (= (rel max 0) 2 ) (p_synth_2 max x i y pc)))
(declare-rel p_synth_3 (Int Int Int Int Int))
 (rule (=>  (< (rel x 1)  (- (rel max 0) (rel i 1))) (p_synth_3 max x i y pc)))
(query End)
