;;c_src (and (= 2 i_1) (= 1 sum_1) (= 0 sum_0) (= 2 n_0) (= 0 i_0) (= 2 n_1))
;;c_tgt (and (= 1 i_0) (= 0 sum_0) (= 1 sum_1) (= 2 n_1) (= 2 i_1) (= 2 n_0))
;;a_src (and (= i_0 0)(not (= i_1 0))(not (= sum_0 sum_1))(= n_0 n_1)(not (= n_0 1))(not (= sum_0 (+ sum_1 (* (- 1) i_0))))(not (= i_0 n_0))(not (<= n_0 i_0))(not (<= n_0 0))(= i_1 n_1)(<= n_1 i_1)(not (<= n_1 0)))
;;a_tgt (and (not (= i_0 0))(not (= i_1 0))(not (= sum_0 sum_1))(= n_0 n_1)(not (= n_0 1))(not (= sum_0 (+ sum_1 (* (- 1) i_0))))(not (= i_0 n_0))(not (<= n_0 i_0))(not (<= n_0 0))(= i_1 n_1)(<= n_1 i_1)(not (<= n_1 0)))
;;tr (and (or (and true (= np_0 n_0) (ite (< i_0 n_0) (and (= sump_0 (+ sum_0 i_0)) (= ip_0 (+ i_0 1))) (and (= sump_0 sum_0) (= ip_0 i_0))))(and (= i_0 ip_0) (= n_0 np_0) (= sum_0 sump_0) true (= i_0 n_0)))(= i_1 ip_1)(= n_1 np_1)(= sum_1 sump_1))

;;grammar
(set-logic LIA)
(synth-fun p ((n_0 Int)(sum_0 Int)(sum_1 Int)(i_1 Int)(i_0 Int)(n_1 Int)) Bool 
           ((B Bool) (I Int)(C Int))
           ((B Bool ((and B B) (or B B) (not B) 
                      (= I I) (< I I) (> I I)))
            (I Int (n_0 sum_0 sum_1 i_1 i_0 n_1 C 
                      (+ I I) (* C I) (- I I)))
						(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))

)

(define-fun c_src ((n_0 Int)(sum_0 Int)(sum_1 Int)(i_1 Int)(i_0 Int)(n_1 Int)) Bool (and (= 2 i_1) (= 1 sum_1) (= 0 sum_0) (= 2 n_0) (= 0 i_0) (= 2 n_1)))

(define-fun a_src ((n_0 Int)(sum_0 Int)(sum_1 Int)(i_1 Int)(i_0 Int)(n_1 Int)) Bool  (and (= i_0 0)(not (= i_1 0))(not (= sum_0 sum_1))(= n_0 n_1)(not (= n_0 1))(not (= sum_0 (+ sum_1 (* (- 1) i_0))))(not (= i_0 n_0))(not (<= n_0 i_0))(not (<= n_0 0))(= i_1 n_1)(<= n_1 i_1)(not (<= n_1 0))))

(define-fun a_tgt ((n_0 Int)(sum_0 Int)(sum_1 Int)(i_1 Int)(i_0 Int)(n_1 Int)) Bool  (and (not (= i_0 0))(not (= i_1 0))(not (= sum_0 sum_1))(= n_0 n_1)(not (= n_0 1))(not (= sum_0 (+ sum_1 (* (- 1) i_0))))(not (= i_0 n_0))(not (<= n_0 i_0))(not (<= n_0 0))(= i_1 n_1)(<= n_1 i_1)(not (<= n_1 0))))

(define-fun trans((n_0 Int )(sum_0 Int )(sum_1 Int )(i_1 Int )(i_0 Int )(n_1 Int )(np_0 Int)(sump_0 Int)(sump_1 Int)(ip_1 Int)(ip_0 Int)(np_1 Int)) Bool  (and (or (and true (= np_0 n_0) (ite (< i_0 n_0) (and (= sump_0 (+ sum_0 i_0)) (= ip_0 (+ i_0 1))) (and (= sump_0 sum_0) (= ip_0 i_0))))(and (= i_0 ip_0) (= n_0 np_0) (= sum_0 sump_0) true (= i_0 n_0)))(= i_1 ip_1)(= n_1 np_1)(= sum_1 sump_1)))

(declare-var n_0 Int )
(declare-var sum_0 Int )
(declare-var sum_1 Int )
(declare-var i_1 Int )
(declare-var i_0 Int )
(declare-var n_1 Int )
(declare-var np_0 Int )
(declare-var sump_0 Int )
(declare-var sump_1 Int )
(declare-var ip_1 Int )
(declare-var ip_0 Int )
(declare-var np_1 Int )

(constraint (=> (c_src  n_0 sum_0 sum_1 i_1 i_0 n_1) (p  n_0 sum_0 sum_1 i_1 i_0 n_1)))
(constraint (=> (and (a_src  n_0 sum_0 sum_1 i_1 i_0 n_1) (p  n_0 sum_0 sum_1 i_1 i_0 n_1) (trans  n_0 sum_0 sum_1 i_1 i_0 n_1 np_0 sump_0 sump_1 ip_1 ip_0 np_1)) (not (a_tgt  np_0 sump_0 sump_1 ip_1 ip_0 np_1))))
(constraint (exists ((n_0 Int )(sum_0 Int )(sum_1 Int )(i_1 Int )(i_0 Int )(n_1 Int ))(and (not (c_src  n_0 sum_0 sum_1 i_1 i_0 n_1)) (p  n_0 sum_0 sum_1 i_1 i_0 n_1))))


(check-synth)