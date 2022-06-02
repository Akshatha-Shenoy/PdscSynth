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
            ((x$1_0 x$1_0_old))
            (let
               ((rem$1_0 (mod
                             x$1_0
                             7)))
               (let
                  ((cmp$1_0 (= rem$1_0 0)))
                  (let
                     ((retval.0$1_0 (ite cmp$1_0 8 rem$1_0)))
                     (let
                        ((result$1 retval.0$1_0)
                         (x$2_0 x$2_0_old))
                        (let
                           ((rem$2_0 (mod
                                         x$2_0
                                         7)))
                           (let
                              ((cmp$2_0 (= rem$2_0 0))
                               (cmp1$2_0 (= x$2_0 1009)))
                              (let
                                 ((.x$2_0 (ite cmp1$2_0 1 x$2_0)))
                                 (let
                                    ((retval.0$2_0 (ite cmp$2_0 8 .x$2_0)))
                                    (let
                                       ((result$2 retval.0$2_0))
                                       (OUT_INV result$1 result$2))))))))))))))
(check-sat)
(get-model)
