(declare-rel Inv (Int Int Int Int Int))
(declare-rel End ())
(declare-rel RelInit (Int Int Int Int Int))
(declare-rel RelBad (Int Int Int Int Int))
(declare-var lrg Int)
(declare-var lrgp Int)
(declare-var y Int)
(declare-var yp Int)
(declare-var x Int)
(declare-var xp Int)
(declare-var h Int)
(declare-var hp Int)
(declare-var end Int)
(declare-var endp Int)
(declare-fun rel (Int Int) Int)

(rule (=> (and 
         	(= x 0)
         	(= y (* 2 lrg))
         	(> lrg 0)
         	(= 0 end))
    (Inv lrg y x h end)))

(rule (=> (and (= (rel h 1) 1) (= (rel h 0) 0) (= (rel lrg 0) (rel lrg 1))) (RelInit lrg y x h end)))


(rule (=> (and (Inv lrg y x h end) (= h hp) (= lrg lrgp)
            (or (and
            	      (ite  (= h 1)
                               (  ite  (= end 0)
                                    (ite  (< x (* 4 lrg))   
                                    	    (ite (< x (* 2 lrg))                             
                                          	(and (= endp 0) (= yp (+ y 1)) (= xp (+ x 1)))
                                          	(and (= endp 0) (= yp y) (= xp (+ x 1)))
                                    	    )
                                    	   (and (= endp 1) (= yp y) (= xp x))
                                    )
                                    (and (= endp 1) (= yp y) (= xp x))  
                             	 )
                       
                      		(ite (= end 0) 
                                  (ite   (< x (* 4 lrg))
                                         (ite (< x (* 2 lrg))
                                              (and (= yp (+ y 1)) (= xp (+ x 1)) (= endp 0))
                                              (and (= yp y) (= xp x) (= endp 1))
                                         )
                                         (and (= yp y) (= xp x) (= endp 1))
                                  )
                                  (and (= endp 1) (= yp y) (= xp x))
                             	)
                       )))) (Inv lrgp yp xp hp endp)))
(rule (=> (and (Inv lrg y x h end)
         (= 1 end) )
    End))
(rule (=> (distinct (rel y 0) (rel y 1)) (RelBad lrg y x h end)))

; predicates
(declare-rel lrg1_eq_lrg0 (Int Int Int Int Int))
 (rule (=> (= (rel lrg 0) (rel lrg 1)) (lrg1_eq_lrg0 lrg y x h end)))
(declare-rel lrg_gt_0 (Int Int Int Int Int))
 (rule (=> (> lrg 0) (lrg_gt_0 lrg y x h end)))
(declare-rel end_eq_0 (Int Int Int Int Int))
 (rule (=> (= end 0) (end_eq_0 lrg y x h end))) 
(declare-rel end_eq_1 (Int Int Int Int Int))
 (rule (=> (= end 1) (end_eq_1 lrg y x h end))) 
(declare-rel x_eq_0 (Int Int Int Int Int))
 (rule (=> (= x 0) (x_eq_0 lrg y x h end)))
(declare-rel y_eq_2_lrg (Int Int Int Int Int))
 (rule (=> (= y (* 2 lrg)) (y_eq_2_lrg lrg y x h end)))

(declare-rel y0_eq_y1 (Int Int Int Int Int))
 (rule (=> (= (rel y 0) (rel y 1)) (y0_eq_y1 lrg y x h end)))
(declare-rel abs_h (Int Int Int Int Int))
 (rule (=> (= 1 h) (abs_h lrg y x h end)))
(declare-rel abs_h_0 (Int Int Int Int Int))
 (rule (=> (= 0 h) (abs_h_0 lrg y x h end)))  
(declare-rel x0_eq_x1 (Int Int Int Int Int))
 (rule (=> (= (rel x 0) (rel x 1)) (x0_eq_x1 lrg y x h end)))

















(declare-rel p_synth_1 (Int Int Int Int Int))
 (rule (=>   (and  (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 0 )  (>= (rel lrg 0) 1 ) ) (p_synth_1 lrg y x h end)))
(declare-rel p_synth_2 (Int Int Int Int Int))
 (rule (=>   (and  (<=  (+  (* 2 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 0 ) (<=  (+  (*  (- 4 ) (rel lrg 0) ) (rel x 1) )  (- 1 ) ) (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 1 ) ) (p_synth_2 lrg y x h end)))
(declare-rel p_synth_3 (Int Int Int Int Int))
 (rule (=>   (and  (not  (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 1 ) )  (not  (<= (rel lrg 0) 0 ) )  (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 2 ) ) (p_synth_3 lrg y x h end)))
(declare-rel p_synth_4 (Int Int Int Int Int))
 (rule (=>   (and  (= (rel lrg 0) (rel lrg 1) ) (<=  (+  (* 2 (rel lrg 0) )  (*  (- 1 ) (rel lrg 1) ) ) 1 ) (not  (<= (rel lrg 1) 0 ) ) ) (p_synth_4 lrg y x h end)))
(declare-rel p_synth_5 (Int Int Int Int Int))
 (rule (=>   (and  (<=  (+  (* 2 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 0 ) (not  (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 2 ) ) (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 3 ) ) (p_synth_5 lrg y x h end)))
(declare-rel p_synth_6 (Int Int Int Int Int))
 (rule (=>   (and  (not  (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 3 ) ) (<=  (+  (* 4 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 4 ) (<=  (+  (* 2 (rel lrg 0) )  (*  (- 1 ) (rel x 1) ) ) 0 ) ) (p_synth_6 lrg y x h end)))
;(query End)
