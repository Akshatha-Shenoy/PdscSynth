;;c_src (and (= 0 y_1)(= 2 i_1)(= 1 h_1)(= 1 v_1)(= 2 max_1)(= 0 pc_0)(= 0 v_0)(= 0 y_0)(= 0 i_0)(= 1 h_0)(= 2 max_0)(= 3 pc_1))
;;c_tgt (and (= 0 y_0)(= 1 i_0)(= 1 h_0)(= 0 v_0)(= 2 max_0)(= 3 pc_1)(= 1 v_1)(= 0 y_1)(= 2 i_1)(= 1 h_1)(= 2 max_1)(= 1 pc_0))
;;a_src (and (= y_0 y_1)(not (= i_0 i_1))(= max_0 max_1)(not (<= h_1 i_0))(not (= y_0 v_1))(= h_1 (+ 1 i_0))(= pc_0 0)(not (= pc_0 1))(not (= i_0 max_0))(not (= pc_1 0))(not (= pc_1 1))(= i_1 max_1)) 
;;a_tgt (and (not (= y_0 y_1))(= i_0 i_1)(= max_0 max_1)(<= h_1 i_0)(not (= y_0 v_1))(not (= h_1 (+ 1 i_0)))(not (= pc_0 0))(= pc_0 1)(= i_0 max_0)(not (= pc_1 0))(not (= pc_1 1))(= i_1 max_1)) 
;;tr (and (or (and true (or (and (= v_0 0) (= pc_0 0) (= pcp_0 (ite (<= hp_0 ip_0) 1 0)) (< h_0 max_0) (= max_0 maxp_0) (= v_0 vp_0) (= h_0 hp_0) (= ip_0 (+ i_0 1)) (= yp_0 (+ y_0 y_0))) (and (= v_0 0) (= pc_0 1) (= pcp_0 (ite (<= max_0 i_0) 3 2)) (>= i_0 h_0) (= max_0 maxp_0) (= vp_0 1) (= h_0 hp_0) (= ip_0 i_0) (= yp_0 y_0)) (and (= v_0 1) (= pc_0 2) (= pcp_0 (ite (= maxp_0 ip_0) 3 2)) (< i_0 max_0) (= max_0 maxp_0) (= v_0 vp_0) (= h_0 hp_0) (= ip_0 (+ i_0 1)) (= yp_0 (+ y_0 y_0))) (and (= pc_0 3)(= pcp_0 3)(= v_0 vp_0)(= max_0 maxp_0)(= h_0 hp_0)(= ip_0 i_0)(= yp_0 y_0))))(and (= max_0 maxp_0) (= h_0 hp_0) (= i_0 ip_0) (= y_0 yp_0) (= v_0 vp_0) (= pc_0 pcp_0) true (= i_0 max_0)))(= max_1 maxp_1)(= h_1 hp_1)(= i_1 ip_1)(= y_1 yp_1)(= v_1 vp_1)(= pc_1 pcp_1))

;;grammar
(set-logic LIA)
(synth-fun p ((h_1 Int)(h_0 Int)(i_0 Int)(max_0 Int)(y_0 Int)(i_1 Int)(y_1 Int)(v_0 Int)(v_1 Int)(max_1 Int)) Bool 
           ((B Bool) (I Int)(C Int))
           ((B Bool ((and B B) (or B B) (not B) 
                      (= I I) (< I I) (> I I)))
            (I Int (h_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1 C 
                      (+ I I) (* C I) (- I I)))
						(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))

)

(define-fun c_src ((pc_0 Int)(h_1 Int)(pc_1 Int)(h_0 Int)(i_0 Int)(max_0 Int)(y_0 Int)(i_1 Int)(y_1 Int)(v_0 Int)(v_1 Int)(max_1 Int)) Bool (and (= 0 y_1)(= 2 i_1)(= 1 h_1)(= 1 v_1)(= 2 max_1)(= 0 pc_0)(= 0 v_0)(= 0 y_0)(= 0 i_0)(= 1 h_0)(= 2 max_0)(= 3 pc_1)))

(define-fun a_src ((pc_0 Int)(h_1 Int)(pc_1 Int)(h_0 Int)(i_0 Int)(max_0 Int)(y_0 Int)(i_1 Int)(y_1 Int)(v_0 Int)(v_1 Int)(max_1 Int)) Bool  (and (= y_0 y_1)(not (= i_0 i_1))(= max_0 max_1)(not (<= h_1 i_0))(not (= y_0 v_1))(= h_1 (+ 1 i_0))(= pc_0 0)(not (= pc_0 1))(not (= i_0 max_0))(not (= pc_1 0))(not (= pc_1 1))(= i_1 max_1)) )

(define-fun a_tgt ((pc_0 Int)(h_1 Int)(pc_1 Int)(h_0 Int)(i_0 Int)(max_0 Int)(y_0 Int)(i_1 Int)(y_1 Int)(v_0 Int)(v_1 Int)(max_1 Int)) Bool  (and (not (= y_0 y_1))(= i_0 i_1)(= max_0 max_1)(<= h_1 i_0)(not (= y_0 v_1))(not (= h_1 (+ 1 i_0)))(not (= pc_0 0))(= pc_0 1)(= i_0 max_0)(not (= pc_1 0))(not (= pc_1 1))(= i_1 max_1)) )

(define-fun trans((pc_0 Int )(h_1 Int )(pc_1 Int )(h_0 Int )(i_0 Int )(max_0 Int )(y_0 Int )(i_1 Int )(y_1 Int )(v_0 Int )(v_1 Int )(max_1 Int )(pcp_0 Int)(hp_1 Int)(pcp_1 Int)(hp_0 Int)(ip_0 Int)(maxp_0 Int)(yp_0 Int)(ip_1 Int)(yp_1 Int)(vp_0 Int)(vp_1 Int)(maxp_1 Int)) Bool  (and (or (and true (or (and (= v_0 0) (= pc_0 0) (= pcp_0 (ite (<= hp_0 ip_0) 1 0)) (< h_0 max_0) (= max_0 maxp_0) (= v_0 vp_0) (= h_0 hp_0) (= ip_0 (+ i_0 1)) (= yp_0 (+ y_0 y_0))) (and (= v_0 0) (= pc_0 1) (= pcp_0 (ite (<= max_0 i_0) 3 2)) (>= i_0 h_0) (= max_0 maxp_0) (= vp_0 1) (= h_0 hp_0) (= ip_0 i_0) (= yp_0 y_0)) (and (= v_0 1) (= pc_0 2) (= pcp_0 (ite (= maxp_0 ip_0) 3 2)) (< i_0 max_0) (= max_0 maxp_0) (= v_0 vp_0) (= h_0 hp_0) (= ip_0 (+ i_0 1)) (= yp_0 (+ y_0 y_0))) (and (= pc_0 3)(= pcp_0 3)(= v_0 vp_0)(= max_0 maxp_0)(= h_0 hp_0)(= ip_0 i_0)(= yp_0 y_0))))(and (= max_0 maxp_0) (= h_0 hp_0) (= i_0 ip_0) (= y_0 yp_0) (= v_0 vp_0) (= pc_0 pcp_0) true (= i_0 max_0)))(= max_1 maxp_1)(= h_1 hp_1)(= i_1 ip_1)(= y_1 yp_1)(= v_1 vp_1)(= pc_1 pcp_1)))

(declare-var pc_0 Int )
(declare-var h_1 Int )
(declare-var pc_1 Int )
(declare-var h_0 Int )
(declare-var i_0 Int )
(declare-var max_0 Int )
(declare-var y_0 Int )
(declare-var i_1 Int )
(declare-var y_1 Int )
(declare-var v_0 Int )
(declare-var v_1 Int )
(declare-var max_1 Int )
(declare-var pcp_0 Int )
(declare-var hp_1 Int )
(declare-var pcp_1 Int )
(declare-var hp_0 Int )
(declare-var ip_0 Int )
(declare-var maxp_0 Int )
(declare-var yp_0 Int )
(declare-var ip_1 Int )
(declare-var yp_1 Int )
(declare-var vp_0 Int )
(declare-var vp_1 Int )
(declare-var maxp_1 Int )

(constraint (=> (c_src  pc_0 h_1 pc_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1) (p  h_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1)))
(constraint (=> (and (a_src  pc_0 h_1 pc_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1) (p  h_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1) (trans  pc_0 h_1 pc_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1 pcp_0 hp_1 pcp_1 hp_0 ip_0 maxp_0 yp_0 ip_1 yp_1 vp_0 vp_1 maxp_1)) (not (a_tgt  pcp_0 hp_1 pcp_1 hp_0 ip_0 maxp_0 yp_0 ip_1 yp_1 vp_0 vp_1 maxp_1))))
(constraint (exists ((pc_0 Int )(h_1 Int )(pc_1 Int )(h_0 Int )(i_0 Int )(max_0 Int )(y_0 Int )(i_1 Int )(y_1 Int )(v_0 Int )(v_1 Int )(max_1 Int ))(and (not (c_src  pc_0 h_1 pc_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1)) (p  h_1 h_0 i_0 max_0 y_0 i_1 y_1 v_0 v_1 max_1))))


(check-synth)