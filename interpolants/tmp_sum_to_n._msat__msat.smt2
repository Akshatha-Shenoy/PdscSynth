(set-logic AUFLIA)
(set-option :produce-interpolants true) 

(set-option :produce-models true)

(declare-fun n_0 ()  Int )
(declare-fun np_0 ()  Int )
(declare-fun npp_0 ()  Int )
(declare-fun nppp_0 ()  Int )
(declare-fun npppp_0 ()  Int )
(declare-fun sum_0 ()  Int )
(declare-fun sump_0 ()  Int )
(declare-fun sumpp_0 ()  Int )
(declare-fun sumppp_0 ()  Int )
(declare-fun sumpppp_0 ()  Int )
(declare-fun sum_1 ()  Int )
(declare-fun sump_1 ()  Int )
(declare-fun sumpp_1 ()  Int )
(declare-fun sumppp_1 ()  Int )
(declare-fun sumpppp_1 ()  Int )
(declare-fun i_1 ()  Int )
(declare-fun ip_1 ()  Int )
(declare-fun ipp_1 ()  Int )
(declare-fun ippp_1 ()  Int )
(declare-fun ipppp_1 ()  Int )
(declare-fun i_0 ()  Int )
(declare-fun ip_0 ()  Int )
(declare-fun ipp_0 ()  Int )
(declare-fun ippp_0 ()  Int )
(declare-fun ipppp_0 ()  Int )
(declare-fun n_1 ()  Int )
(declare-fun np_1 ()  Int )
(declare-fun npp_1 ()  Int )
(declare-fun nppp_1 ()  Int )
(declare-fun npppp_1 ()  Int )
(define-fun A_0 () Bool  (and (> n_0 0)
     (= sum_0 0)
     (= i_0 0)
     (> n_1 0)
     (= sum_1 0)
     (= i_1 0)
     (= n_0 n_1)) )
(define-fun A_1 () Bool  (and (or (and true (= np_1 n_1) (ite (< i_1 n_1)                 (and (= sump_1 (+ sum_1 i_1)) (= ip_1 (+ i_1 1)))                 (and (= sump_1 sum_1) (= ip_1 i_1))))            (and (= i_1 ip_1) (= n_1 np_1) (= sum_1 sump_1) true (= i_1 n_1)))        (= i_0 ip_0)        (= n_0 np_0)        (= sum_0 sump_0))) 
(define-fun A_2 () Bool   ( and ( or ( and true ( = npp_1 np_1 ) ( ite ( < ip_1 np_1 ) ( and ( = sumpp_1 ( + sump_1 ip_1 ) ) ( = ipp_1 ( + ip_1 1 ) ) ) ( and ( = sumpp_1 sump_1 ) ( = ipp_1 ip_1 ) ) ) ) ( and ( = ip_1 ipp_1 ) ( = np_1 npp_1 ) ( = sump_1 sumpp_1 ) true ( = ip_1 np_1 ) ) ) ( = ip_0 ipp_0 ) ( = np_0 npp_0 ) ( = sump_0 sumpp_0 ) ) )
(define-fun A_3 () Bool   ( and ( or ( and true ( = nppp_0 npp_0 ) ( ite ( < ipp_0 npp_0 ) ( and ( = sumppp_0 ( + sumpp_0 ipp_0 ) ) ( = ippp_0 ( + ipp_0 1 ) ) ) ( and ( = sumppp_0 sumpp_0 ) ( = ippp_0 ipp_0 ) ) ) ) ( and ( = ipp_0 ippp_0 ) ( = npp_0 nppp_0 ) ( = sumpp_0 sumppp_0 ) true ( = ipp_0 npp_0 ) ) ) ( = ipp_1 ippp_1 ) ( = npp_1 nppp_1 ) ( = sumpp_1 sumppp_1 ) ) )
(define-fun A_4 () Bool   ( and ( or ( and true ( = npppp_0 nppp_0 ) ( ite ( < ippp_0 nppp_0 ) ( and ( = sumpppp_0 ( + sumppp_0 ippp_0 ) ) ( = ipppp_0 ( + ippp_0 1 ) ) ) ( and ( = sumpppp_0 sumppp_0 ) ( = ipppp_0 ippp_0 ) ) ) ) ( and ( = ippp_0 ipppp_0 ) ( = nppp_0 npppp_0 ) ( = sumppp_0 sumpppp_0 ) true ( = ippp_0 nppp_0 ) ) ) ( = ippp_1 ipppp_1 ) ( = nppp_1 npppp_1 ) ( = sumppp_1 sumpppp_1 ) ) )
(define-fun A_5() Bool      ( and ( not ( = ipppp_0 0 ) ) ( not ( = ipppp_1 0 ) ) ( not ( = sumpppp_0 sumpppp_1 ) ) ( = npppp_0 npppp_1 ) ( not ( = ( + npppp_1 ( * ( - 1 ) ipppp_1 ) ipppp_0 ( * ( - 1 ) npppp_0 ) ) ( - 1 ) ) ) ( not ( = npppp_1 0 ) ) ( = ipppp_0 npppp_0 ) ( <= npppp_0 ipppp_0 ) ( not ( <= npppp_0 0 ) ) ( = ipppp_1 npppp_1 ) ( <= npppp_1 ipppp_1 ) ( not ( <= npppp_1 0 ) ) ))

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