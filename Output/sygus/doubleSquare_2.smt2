(declare-rel Inv (Int Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int Int))
(declare-rel RelBad (Int Int Int Int Int))
(declare-var z Int)
(declare-var zp Int)
(declare-var y Int)
(declare-var yp Int)
(declare-var x Int)
(declare-var xp Int)
(declare-var h Int)
(declare-var hp Int)
(declare-var end Int)
(declare-var endp Int)
(declare-fun rel (Int Int) Int)

(rule (=> (and (= z (ite (= 1 h) (* 2 x) x))
         (> x 0)
         (= y 0)
         (= 0 end))
    (Inv z y x h end)))

(rule (=> (and (= (rel h 1) 1) (= (rel h 0) 0)(= (rel x 0) (rel x 1))) (RelInit z y x h end)))
(rule (=> (and (Inv z y x h end) (= h hp) (= x xp)
            (or (and
                     (> z 0)
                     (= 0 endp)
                     (= 0 end)
                     (= zp (- z 1))
                     (= yp (+ x y)))
               (and
                     (<= z 0)
                     (= 0 end)
                     (= 1 endp)
                     (= zp z)
                     (= yp (ite (= 1 h) y (* 2 y))))
                (and
                     (= zp z)
                     (= 1 end)
                     (= 1 endp)
                     (= yp y))
               )) (Inv zp yp xp hp endp)))
(rule (=> (and (Inv z y x h end)
         (= 1 end) )
    End))
    (rule (=> (distinct (rel y 0) (rel y 1)) (RelBad z y x h end)))

; predicates
(declare-rel z0_eq_z1 (Int Int Int Int Int))
 (rule (=> (= (rel z 0) (rel z 1)) (z0_eq_z1 z y x h end)))
(declare-rel y_gteq_0 (Int Int Int Int Int))
 (rule (=> (>= y 0) (y_gteq_0 z y x h end)))
;(declare-rel z_gt_0 (Int Int Int Int Int))
; (rule (=> (> z 0) (z_gt_0 z y x h end)))
(declare-rel z_gteq_0 (Int Int Int Int Int))
 (rule (=> (>= z 0) (z_gteq_0 z y x h end)))
(declare-rel y0_eq_y1 (Int Int Int Int Int))
 (rule (=> (= (rel y 0) (rel y 1)) (y0_eq_y1 z y x h end)))
(declare-rel x0_eq_x1 (Int Int Int Int Int))
 (rule (=> (= (rel x 0) (rel x 1)) (x0_eq_x1 z y x h end)))
(declare-rel x0_gt_0 (Int Int Int Int Int))
(rule (=> (> (rel x 0) 0) (x0_gt_0 z y x h end)))
(declare-rel abs_end (Int Int Int Int Int))
 (rule (=> (= 1 end) (abs_end z y x h end)))
(declare-rel abs_h (Int Int Int Int Int))
 (rule (=> (= 1 h) (abs_h z y x h end)))
(declare-rel z1_eq_2z0 (Int Int Int Int Int))
 (rule (=> (= (rel z 1) (* 2 (rel z 0))) (z1_eq_2z0 z y x h end)))
;(declare-rel z1_eq_2z0_1 (Int Int Int Int Int))
;(rule (=> (= (rel z 1) (- (* 2 (rel z 0)) 1)) (z1_eq_2z0_1 z y x h end)))
;(declare-rel y1_eq_2y0 (Int Int Int Int Int))
; (rule (=> (= (rel y 1) (* 2 (rel y 0))) (y1_eq_2y0 z y x h end)))
;(declare-rel y1_eq_2y0_x (Int Int Int Int Int))
;(rule (=> (= (rel y 1) (+ (* 2 (rel y 0)) (rel x 0))) (y1_eq_2y0_x z y x h end)))





























(declare-rel p_synth_1 (Int Int Int Int Int))
 (rule (=>  (= (rel h 1) (rel z 0)) (p_synth_1 z y x h end)))
(declare-rel p_synth_2 (Int Int Int Int Int))
 (rule (=>  (< (rel y 0) (rel x 1)) (p_synth_2 z y x h end)))
(declare-rel p_synth_3 (Int Int Int Int Int))
 (rule (=>  (< (rel x 1) (rel z 1)) (p_synth_3 z y x h end)))
(declare-rel p_synth_4 (Int Int Int Int Int))
 (rule (=>  (= (rel x 1) (rel z 0)) (p_synth_4 z y x h end)))
(declare-rel p_synth_5 (Int Int Int Int Int))
 (rule (=>  (= (rel y 0)  (- (rel y 1) (rel y 0))) (p_synth_5 z y x h end)))
(declare-rel p_synth_6 (Int Int Int Int Int))
 (rule (=>  (= (rel x 1)  (- (rel y 1) (rel x 1))) (p_synth_6 z y x h end)))
(declare-rel p_synth_7 (Int Int Int Int Int))
 (rule (=>  (= (rel x 1) (rel y 1)) (p_synth_7 z y x h end)))
(declare-rel p_synth_8 (Int Int Int Int Int))
 (rule (=>  (= (rel h 1) (rel z 1)) (p_synth_8 z y x h end)))
(query End)
