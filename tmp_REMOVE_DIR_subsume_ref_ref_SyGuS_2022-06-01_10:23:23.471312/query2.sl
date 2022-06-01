;;c_src (and (= 9 x_1) (= 1 h_1) (= 1 h_0) (= 9 x_0) (= 0 count_1) (= 0 count_0))
;;c_tgt (and (= 1 count_1) (= 9 x_1) (= 0 count_0) (= 1 h_0) (= 9 x_0) (= 1 h_1))
;;a_src (and (= x_0 x_1)(not (= x_1 8))(= h_0 1)(= count_0 0)(= h_1 1)(= count_1 0)) 
;;a_tgt (and (not (= x_0 x_1))(not (= x_1 8))(= h_0 1)(= count_0 0)(= h_1 1)(not (= count_1 0))) 
;;tr (and (or (and true (= h_1 hp_1) (ite (= 1 h_1) (ite (= 0 (mod x_1 7)) (and (= xp_1 8) (= countp_1 1)) (ite (= x_1 1009) (and (= xp_1 1) (= countp_1 1)) (ite (= x_1 383)(and (= xp_1 1) (= countp_1 1))(and (= xp_1 x_1) (= countp_1 1))))) (ite (= 0 (mod x_1 7)) (and (= xp_1 8) (= countp_1 1)) (and (= xp_1 (mod x_1 7)) (= countp_1 1)))))(and (= x_1 xp_1) (= h_1 hp_1) (= count_1 countp_1) true (= 1 count_1)))(= x_0 xp_0)(= h_0 hp_0)(= count_0 countp_0))

;;grammar
(set-logic LIA)
(synth-fun p ((x_1 Int)(h_1 Int)(count_0 Int)(h_0 Int)(x_0 Int)(count_1 Int)) Bool 
           ((B Bool) (I Int)(C Int))
           ((B Bool ((and B B) (or B B) (not B) 
                      (= I I) (< I I) (> I I)))
            (I Int (x_1 h_1 count_0 h_0 x_0 count_1 C 
                      (+ I I) (* C I) (- I I)))
						(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))

)

(define-fun c_src ((x_1 Int)(h_1 Int)(count_0 Int)(h_0 Int)(x_0 Int)(count_1 Int)) Bool (and (= 9 x_1) (= 1 h_1) (= 1 h_0) (= 9 x_0) (= 0 count_1) (= 0 count_0)))

(define-fun a_src ((x_1 Int)(h_1 Int)(count_0 Int)(h_0 Int)(x_0 Int)(count_1 Int)) Bool  (and (= x_0 x_1)(not (= x_1 8))(= h_0 1)(= count_0 0)(= h_1 1)(= count_1 0)) )

(define-fun a_tgt ((x_1 Int)(h_1 Int)(count_0 Int)(h_0 Int)(x_0 Int)(count_1 Int)) Bool  (and (not (= x_0 x_1))(not (= x_1 8))(= h_0 1)(= count_0 0)(= h_1 1)(not (= count_1 0))) )

(define-fun trans((x_1 Int )(h_1 Int )(count_0 Int )(h_0 Int )(x_0 Int )(count_1 Int )(xp_1 Int)(hp_1 Int)(countp_0 Int)(hp_0 Int)(xp_0 Int)(countp_1 Int)) Bool  (and (or (and true (= h_1 hp_1) (ite (= 1 h_1) (ite (= 0 (mod x_1 7)) (and (= xp_1 8) (= countp_1 1)) (ite (= x_1 1009) (and (= xp_1 1) (= countp_1 1)) (ite (= x_1 383)(and (= xp_1 1) (= countp_1 1))(and (= xp_1 x_1) (= countp_1 1))))) (ite (= 0 (mod x_1 7)) (and (= xp_1 8) (= countp_1 1)) (and (= xp_1 (mod x_1 7)) (= countp_1 1)))))(and (= x_1 xp_1) (= h_1 hp_1) (= count_1 countp_1) true (= 1 count_1)))(= x_0 xp_0)(= h_0 hp_0)(= count_0 countp_0)))

(declare-var x_1 Int )
(declare-var h_1 Int )
(declare-var count_0 Int )
(declare-var h_0 Int )
(declare-var x_0 Int )
(declare-var count_1 Int )
(declare-var xp_1 Int )
(declare-var hp_1 Int )
(declare-var countp_0 Int )
(declare-var hp_0 Int )
(declare-var xp_0 Int )
(declare-var countp_1 Int )

(constraint (=> (c_src  x_1 h_1 count_0 h_0 x_0 count_1) (p  x_1 h_1 count_0 h_0 x_0 count_1)))
(constraint (=> (and (a_src  x_1 h_1 count_0 h_0 x_0 count_1) (p  x_1 h_1 count_0 h_0 x_0 count_1) (trans  x_1 h_1 count_0 h_0 x_0 count_1 xp_1 hp_1 countp_0 hp_0 xp_0 countp_1)) (not (a_tgt  xp_1 hp_1 countp_0 hp_0 xp_0 countp_1))))
(constraint (exists ((x_1 Int )(h_1 Int )(count_0 Int )(h_0 Int )(x_0 Int )(count_1 Int ))(and (not (c_src  x_1 h_1 count_0 h_0 x_0 count_1)) (p  x_1 h_1 count_0 h_0 x_0 count_1))))


(check-synth)