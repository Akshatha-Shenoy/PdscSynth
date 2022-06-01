;;c_src (and (= 1 count_1) (= 1 l_1) (= 0 count_0) (= 1 h_0) (= 0 l_0) (= 1 h_1))
;;c_tgt (and (= 2 count_1) (= 0 l_1) (= 0 count_0) (= 1 h_0) (= 0 l_0) (= 1 h_1))
;;a_src (and (not (= l_0 l_1))(not (= count_0 2))(not (= count_1 2))(= count_0 0)(not (<= h_0 0))(not (= count_1 0))(not (<= h_1 0))) 
;;a_tgt (and (not (= l_0 l_1))(not (= count_0 2))(= count_1 2)(= count_0 0)(not (<= h_0 0))(not (= count_1 0))(not (<= h_1 0))) 
;;tr (and (or (and true (= hp_1 h_1) (ite (= count_1 0) (and (= lp_1 (+ l_1 h_1)) (= countp_1 (+ count_1 1))) (ite (= count_1 1) (and (= lp_1 (- l_1 h_1)) (= countp_1 (+ count_1 1))) (and (= lp_1 l_1) (= countp_1 count_1)))))(and (= l_1 lp_1) (= h_1 hp_1) (= count_1 countp_1) true (= count_1 2)))(= l_0 lp_0)(= h_0 hp_0)(= count_0 countp_0))

;;grammar
(set-logic LIA)
(synth-fun p ((h_1 Int)(l_0 Int)(count_0 Int)(h_0 Int)(count_1 Int)(l_1 Int)) Bool 
           ((B Bool) (I Int)(C Int))
           ((B Bool ((and B B) (or B B) (not B) 
                      (= I I) (< I I) (> I I)))
            (I Int (h_1 l_0 count_0 h_0 count_1 l_1 C 
                      (+ I I) (* C I) (- I I)))
						(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))

)

(define-fun c_src ((h_1 Int)(l_0 Int)(count_0 Int)(h_0 Int)(count_1 Int)(l_1 Int)) Bool (and (= 1 count_1) (= 1 l_1) (= 0 count_0) (= 1 h_0) (= 0 l_0) (= 1 h_1)))

(define-fun a_src ((h_1 Int)(l_0 Int)(count_0 Int)(h_0 Int)(count_1 Int)(l_1 Int)) Bool  (and (not (= l_0 l_1))(not (= count_0 2))(not (= count_1 2))(= count_0 0)(not (<= h_0 0))(not (= count_1 0))(not (<= h_1 0))) )

(define-fun a_tgt ((h_1 Int)(l_0 Int)(count_0 Int)(h_0 Int)(count_1 Int)(l_1 Int)) Bool  (and (not (= l_0 l_1))(not (= count_0 2))(= count_1 2)(= count_0 0)(not (<= h_0 0))(not (= count_1 0))(not (<= h_1 0))) )

(define-fun trans((h_1 Int )(l_0 Int )(count_0 Int )(h_0 Int )(count_1 Int )(l_1 Int )(hp_1 Int)(lp_0 Int)(countp_0 Int)(hp_0 Int)(countp_1 Int)(lp_1 Int)) Bool  (and (or (and true (= hp_1 h_1) (ite (= count_1 0) (and (= lp_1 (+ l_1 h_1)) (= countp_1 (+ count_1 1))) (ite (= count_1 1) (and (= lp_1 (- l_1 h_1)) (= countp_1 (+ count_1 1))) (and (= lp_1 l_1) (= countp_1 count_1)))))(and (= l_1 lp_1) (= h_1 hp_1) (= count_1 countp_1) true (= count_1 2)))(= l_0 lp_0)(= h_0 hp_0)(= count_0 countp_0)))

(declare-var h_1 Int )
(declare-var l_0 Int )
(declare-var count_0 Int )
(declare-var h_0 Int )
(declare-var count_1 Int )
(declare-var l_1 Int )
(declare-var hp_1 Int )
(declare-var lp_0 Int )
(declare-var countp_0 Int )
(declare-var hp_0 Int )
(declare-var countp_1 Int )
(declare-var lp_1 Int )

(constraint (=> (c_src  h_1 l_0 count_0 h_0 count_1 l_1) (p  h_1 l_0 count_0 h_0 count_1 l_1)))
(constraint (=> (and (a_src  h_1 l_0 count_0 h_0 count_1 l_1) (p  h_1 l_0 count_0 h_0 count_1 l_1) (trans  h_1 l_0 count_0 h_0 count_1 l_1 hp_1 lp_0 countp_0 hp_0 countp_1 lp_1)) (not (a_tgt  hp_1 lp_0 countp_0 hp_0 countp_1 lp_1))))
(constraint (exists ((h_1 Int )(l_0 Int )(count_0 Int )(h_0 Int )(count_1 Int )(l_1 Int ))(and (not (c_src  h_1 l_0 count_0 h_0 count_1 l_1)) (p  h_1 l_0 count_0 h_0 count_1 l_1))))


(check-synth)