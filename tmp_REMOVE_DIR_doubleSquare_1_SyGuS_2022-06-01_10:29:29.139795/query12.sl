;;c_src (and (= 2 y_1)(= 0 z_1)(= 1 end_1)(= 1 x_1)(= 0 end_0)(= 0 h_0)(= 1 x_0)(= 0 y_0)(= 1 z_0)(= 1 h_1))
;;c_tgt (and (= 1 y_0)(= 0 z_0)(= 0 end_0)(= 1 x_0)(= 1 end_1)(= 1 h_1)(= 1 x_1)(= 2 y_1)(= 0 z_1)(= 0 h_0))
;;a_src (and (not (= z_0 z_1))(not (= y_0 y_1))(= x_0 x_1)(not (<= x_0 0))(<= z_1 x_1)(= x_1 z_0)(= x_1 h_1)(not (= h_1 z_1))(not (= (* 2 x_1) z_1))(not (= (* 2 y_0) y_1))(>= y_0 0)(>= z_0 0)(not (= end_0 1))(not (= h_0 1))(>= y_1 0)(>= z_1 0)(= end_1 1)(= h_1 1)) 
;;a_tgt (and (= z_0 z_1)(not (= y_0 y_1))(= x_0 x_1)(not (<= x_0 0))(<= z_1 x_1)(not (= x_1 z_0))(= x_1 h_1)(not (= h_1 z_1))(not (= (* 2 x_1) z_1))(not (= (* 2 y_0) y_1))(>= y_0 0)(>= z_0 0)(not (= end_0 1))(not (= h_0 1))(>= y_1 0)(>= z_1 0)(= end_1 1)(= h_1 1)) 
;;tr (and (or (and true (= h_0 hp_0) (= x_0 xp_0) (or (and (> z_0 0) (= 0 endp_0) (= 0 end_0) (= zp_0 (- z_0 1)) (= yp_0 (+ x_0 y_0)))(and (<= z_0 0) (= 0 end_0) (= 1 endp_0) (= zp_0 z_0) (= yp_0 (ite (= 1 h_0) y_0 (* 2 y_0))))(and (= zp_0 z_0) (= 1 end_0) (= 1 endp_0) (= yp_0 y_0))))(and (= z_0 zp_0) (= y_0 yp_0) (= x_0 xp_0) (= h_0 hp_0) (= end_0 endp_0) true (= 1 end_0)))(= z_1 zp_1)(= y_1 yp_1)(= x_1 xp_1)(= h_1 hp_1)(= end_1 endp_1))

;;grammar
(set-logic LIA)
(synth-fun p ((x_1 Int)(h_1 Int)(h_0 Int)(x_0 Int)(end_0 Int)(z_0 Int)(y_0 Int)(y_1 Int)(z_1 Int)(end_1 Int)) Bool 
           ((B Bool) (I Int)(C Int))
           ((B Bool ((and B B) (or B B) (not B) 
                      (= I I) (< I I) (> I I)))
            (I Int (x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1 C 
                      (+ I I) (* C I) (- I I)))
						(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))

)

(define-fun c_src ((x_1 Int)(h_1 Int)(h_0 Int)(x_0 Int)(end_0 Int)(z_0 Int)(y_0 Int)(y_1 Int)(z_1 Int)(end_1 Int)) Bool (and (= 2 y_1)(= 0 z_1)(= 1 end_1)(= 1 x_1)(= 0 end_0)(= 0 h_0)(= 1 x_0)(= 0 y_0)(= 1 z_0)(= 1 h_1)))

(define-fun a_src ((x_1 Int)(h_1 Int)(h_0 Int)(x_0 Int)(end_0 Int)(z_0 Int)(y_0 Int)(y_1 Int)(z_1 Int)(end_1 Int)) Bool  (and (not (= z_0 z_1))(not (= y_0 y_1))(= x_0 x_1)(not (<= x_0 0))(<= z_1 x_1)(= x_1 z_0)(= x_1 h_1)(not (= h_1 z_1))(not (= (* 2 x_1) z_1))(not (= (* 2 y_0) y_1))(>= y_0 0)(>= z_0 0)(not (= end_0 1))(not (= h_0 1))(>= y_1 0)(>= z_1 0)(= end_1 1)(= h_1 1)) )

(define-fun a_tgt ((x_1 Int)(h_1 Int)(h_0 Int)(x_0 Int)(end_0 Int)(z_0 Int)(y_0 Int)(y_1 Int)(z_1 Int)(end_1 Int)) Bool  (and (= z_0 z_1)(not (= y_0 y_1))(= x_0 x_1)(not (<= x_0 0))(<= z_1 x_1)(not (= x_1 z_0))(= x_1 h_1)(not (= h_1 z_1))(not (= (* 2 x_1) z_1))(not (= (* 2 y_0) y_1))(>= y_0 0)(>= z_0 0)(not (= end_0 1))(not (= h_0 1))(>= y_1 0)(>= z_1 0)(= end_1 1)(= h_1 1)) )

(define-fun trans((x_1 Int )(h_1 Int )(h_0 Int )(x_0 Int )(end_0 Int )(z_0 Int )(y_0 Int )(y_1 Int )(z_1 Int )(end_1 Int )(xp_1 Int)(hp_1 Int)(hp_0 Int)(xp_0 Int)(endp_0 Int)(zp_0 Int)(yp_0 Int)(yp_1 Int)(zp_1 Int)(endp_1 Int)) Bool  (and (or (and true (= h_0 hp_0) (= x_0 xp_0) (or (and (> z_0 0) (= 0 endp_0) (= 0 end_0) (= zp_0 (- z_0 1)) (= yp_0 (+ x_0 y_0)))(and (<= z_0 0) (= 0 end_0) (= 1 endp_0) (= zp_0 z_0) (= yp_0 (ite (= 1 h_0) y_0 (* 2 y_0))))(and (= zp_0 z_0) (= 1 end_0) (= 1 endp_0) (= yp_0 y_0))))(and (= z_0 zp_0) (= y_0 yp_0) (= x_0 xp_0) (= h_0 hp_0) (= end_0 endp_0) true (= 1 end_0)))(= z_1 zp_1)(= y_1 yp_1)(= x_1 xp_1)(= h_1 hp_1)(= end_1 endp_1)))

(declare-var x_1 Int )
(declare-var h_1 Int )
(declare-var h_0 Int )
(declare-var x_0 Int )
(declare-var end_0 Int )
(declare-var z_0 Int )
(declare-var y_0 Int )
(declare-var y_1 Int )
(declare-var z_1 Int )
(declare-var end_1 Int )
(declare-var xp_1 Int )
(declare-var hp_1 Int )
(declare-var hp_0 Int )
(declare-var xp_0 Int )
(declare-var endp_0 Int )
(declare-var zp_0 Int )
(declare-var yp_0 Int )
(declare-var yp_1 Int )
(declare-var zp_1 Int )
(declare-var endp_1 Int )

(constraint (=> (c_src  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1) (p  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1)))
(constraint (=> (and (a_src  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1) (p  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1) (trans  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1 xp_1 hp_1 hp_0 xp_0 endp_0 zp_0 yp_0 yp_1 zp_1 endp_1)) (not (a_tgt  xp_1 hp_1 hp_0 xp_0 endp_0 zp_0 yp_0 yp_1 zp_1 endp_1))))
(constraint (exists ((x_1 Int )(h_1 Int )(h_0 Int )(x_0 Int )(end_0 Int )(z_0 Int )(y_0 Int )(y_1 Int )(z_1 Int )(end_1 Int ))(and (not (c_src  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1)) (p  x_1 h_1 h_0 x_0 end_0 z_0 y_0 y_1 z_1 end_1))))


(check-synth)