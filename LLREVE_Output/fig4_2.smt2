(set-logic HORN)
(define-fun
   IN_INV
   ((x$1_0 Int)
    (x$2_0 Int))
   Bool
   (= x$1_0 x$2_0))
(define-fun
   OUT_INV
   ((result$1 Int)
    (result$2 Int))
   Bool
   (= result$1 result$2))
(assert
   (forall
      ((x$1_0_old Int)
       (x$2_0_old Int))
      (=>
         (IN_INV x$1_0_old x$2_0_old)
         (let
            ((x$1_0 x$1_0_old)
             (result$1 42)
             (x$2_0 x$2_0_old))
            (let
               ((sub$2_0 (- 42 x$2_0)))
               (let
                  ((result$2 sub$2_0))
                  (OUT_INV result$1 result$2)))))))
(check-sat)
(get-model)
