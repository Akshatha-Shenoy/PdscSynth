(set-logic AUFLIA)
(set-option :produce-interpolants true) 

(set-option :produce-models true)

(declare-fun h_1 ()  Int )
(declare-fun hp_1 ()  Int )
(declare-fun hpp_1 ()  Int )
(declare-fun hppp_1 ()  Int )
(declare-fun hpppp_1 ()  Int )
(declare-fun l_0 ()  Int )
(declare-fun lp_0 ()  Int )
(declare-fun lpp_0 ()  Int )
(declare-fun lppp_0 ()  Int )
(declare-fun lpppp_0 ()  Int )
(declare-fun count_0 ()  Int )
(declare-fun countp_0 ()  Int )
(declare-fun countpp_0 ()  Int )
(declare-fun countppp_0 ()  Int )
(declare-fun countpppp_0 ()  Int )
(declare-fun h_0 ()  Int )
(declare-fun hp_0 ()  Int )
(declare-fun hpp_0 ()  Int )
(declare-fun hppp_0 ()  Int )
(declare-fun hpppp_0 ()  Int )
(declare-fun count_1 ()  Int )
(declare-fun countp_1 ()  Int )
(declare-fun countpp_1 ()  Int )
(declare-fun countppp_1 ()  Int )
(declare-fun countpppp_1 ()  Int )
(declare-fun l_1 ()  Int )
(declare-fun lp_1 ()  Int )
(declare-fun lpp_1 ()  Int )
(declare-fun lppp_1 ()  Int )
(declare-fun lpppp_1 ()  Int )
(define-fun A_0 () Bool  (and (= count_0 0) (> h_0 0) (= count_1 0) (> h_1 0) (= l_0 l_1)) )
(define-fun A_1 () Bool  (and (or (and true (= hp_1 h_1) (ite (= count_1 0)                 (and (= lp_1 (+ l_1 h_1)) (= countp_1 (+ count_1 1)))                 (ite (= count_1 1)                 (and (= lp_1 (- l_1 h_1)) (= countp_1 (+ count_1 1)))                 (and (= lp_1 l_1) (= countp_1 count_1)))))            (and (= l_1 lp_1)                 (= h_1 hp_1)                 (= count_1 countp_1)                 true                 (= count_1 2)))        (= l_0 lp_0)        (= h_0 hp_0)        (= count_0 countp_0))) 
(define-fun A_2 () Bool   ( and ( or ( and true ( = hpp_1 hp_1 ) ( ite ( = countp_1 0 ) ( and ( = lpp_1 ( + lp_1 hp_1 ) ) ( = countpp_1 ( + countp_1 1 ) ) ) ( ite ( = countp_1 1 ) ( and ( = lpp_1 ( - lp_1 hp_1 ) ) ( = countpp_1 ( + countp_1 1 ) ) ) ( and ( = lpp_1 lp_1 ) ( = countpp_1 countp_1 ) ) ) ) ) ( and ( = lp_1 lpp_1 ) ( = hp_1 hpp_1 ) ( = countp_1 countpp_1 ) true ( = countp_1 2 ) ) ) ( = lp_0 lpp_0 ) ( = hp_0 hpp_0 ) ( = countp_0 countpp_0 ) ) )
(define-fun A_3 () Bool   ( and ( or ( and true ( = hppp_0 hpp_0 ) ( ite ( = countpp_0 0 ) ( and ( = lppp_0 ( + lpp_0 hpp_0 ) ) ( = countppp_0 ( + countpp_0 1 ) ) ) ( ite ( = countpp_0 1 ) ( and ( = lppp_0 ( - lpp_0 hpp_0 ) ) ( = countppp_0 ( + countpp_0 1 ) ) ) ( and ( = lppp_0 lpp_0 ) ( = countppp_0 countpp_0 ) ) ) ) ) ( and ( = lpp_0 lppp_0 ) ( = hpp_0 hppp_0 ) ( = countpp_0 countppp_0 ) true ( = countpp_0 2 ) ) ) ( = lpp_1 lppp_1 ) ( = hpp_1 hppp_1 ) ( = countpp_1 countppp_1 ) ) )
(define-fun A_4 () Bool   ( and ( or ( and true ( = hpppp_0 hppp_0 ) ( ite ( = countppp_0 0 ) ( and ( = lpppp_0 ( + lppp_0 hppp_0 ) ) ( = countpppp_0 ( + countppp_0 1 ) ) ) ( ite ( = countppp_0 1 ) ( and ( = lpppp_0 ( - lppp_0 hppp_0 ) ) ( = countpppp_0 ( + countppp_0 1 ) ) ) ( and ( = lpppp_0 lppp_0 ) ( = countpppp_0 countppp_0 ) ) ) ) ) ( and ( = lppp_0 lpppp_0 ) ( = hppp_0 hpppp_0 ) ( = countppp_0 countpppp_0 ) true ( = countppp_0 2 ) ) ) ( = lppp_1 lpppp_1 ) ( = hppp_1 hpppp_1 ) ( = countppp_1 countpppp_1 ) ) )
(define-fun A_5() Bool      ( and ( not ( = lpppp_0 lpppp_1 ) ) ( = countpppp_0 2 ) ( = countpppp_1 2 ) ( not ( = ( + hpppp_1 ( * ( - 1 ) lpppp_1 ) lpppp_0 ) 0 ) ) ( not ( <= lpppp_0 lpppp_1 ) ) ( not ( = countpppp_0 0 ) ) ( not ( <= hpppp_0 0 ) ) ( not ( = countpppp_1 0 ) ) ( not ( <= hpppp_1 0 ) ) ))

(assert ( ! A_0 :interpolation-group g0))
(assert ( ! A_1 :interpolation-group g1))
(assert ( ! A_2 :interpolation-group g2))
(assert ( ! A_3 :interpolation-group g3))
(assert ( ! A_4 :interpolation-group g4))
(assert ( ! A_5 :interpolation-group g5))
( check-sat )
( get-interpolant ( g0))
( get-interpolant ( g0 g1))
( get-interpolant ( g0 g1 g2))
( get-interpolant ( g0 g1 g2 g3))
( get-interpolant ( g0 g1 g2 g3 g4))
(exit)