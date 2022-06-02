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
; :annot (INV_MAIN_42 x$1_0 y.0$1_0 z.0$1_0 x$2_0 y.0$2_0 z.0$2_0)
(declare-fun
   INV_MAIN_42
   (Int
    Int
    Int
    Int
    Int
    Int)
   Bool)
(assert
   (forall
      ((x$1_0_old Int)
       (x$2_0_old Int))
      (=>
         (IN_INV x$1_0_old x$2_0_old)
         (let
            ((x$1_0 x$1_0_old))
            (let
               ((mul$1_0 (* 2 x$1_0)))
               (let
                  ((y.0$1_0 0)
                   (z.0$1_0 mul$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        (not cmp$1_0)
                        (let
                           ((result$1 y.0$1_0)
                            (x$2_0 x$2_0_old))
                           (let
                              ((y.0$2_0 0)
                               (z.0$2_0 x$2_0))
                              (let
                                 ((cmp$2_0 (> z.0$2_0 0)))
                                 (not cmp$2_0))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (x$2_0_old Int))
      (=>
         (IN_INV x$1_0_old x$2_0_old)
         (let
            ((x$1_0 x$1_0_old))
            (let
               ((mul$1_0 (* 2 x$1_0)))
               (let
                  ((y.0$1_0 0)
                   (z.0$1_0 mul$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        cmp$1_0
                        (let
                           ((x$2_0 x$2_0_old))
                           (let
                              ((y.0$2_0 0)
                               (z.0$2_0 x$2_0))
                              (let
                                 ((cmp$2_0 (> z.0$2_0 0)))
                                 (=>
                                    (not cmp$2_0)
                                    (let
                                       ((mul$2_0 (* 2 y.0$2_0)))
                                       (let
                                          ((result$2 mul$2_0))
                                          false))))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (x$2_0_old Int))
      (=>
         (IN_INV x$1_0_old x$2_0_old)
         (let
            ((x$1_0 x$1_0_old))
            (let
               ((mul$1_0 (* 2 x$1_0)))
               (let
                  ((y.0$1_0 0)
                   (z.0$1_0 mul$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        (not cmp$1_0)
                        (let
                           ((result$1 y.0$1_0)
                            (x$2_0 x$2_0_old))
                           (let
                              ((y.0$2_0 0)
                               (z.0$2_0 x$2_0))
                              (let
                                 ((cmp$2_0 (> z.0$2_0 0)))
                                 (=>
                                    (not cmp$2_0)
                                    (let
                                       ((mul$2_0 (* 2 y.0$2_0)))
                                       (let
                                          ((result$2 mul$2_0))
                                          (OUT_INV result$1 result$2)))))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (x$2_0_old Int))
      (=>
         (IN_INV x$1_0_old x$2_0_old)
         (let
            ((x$1_0 x$1_0_old))
            (let
               ((mul$1_0 (* 2 x$1_0)))
               (let
                  ((y.0$1_0 0)
                   (z.0$1_0 mul$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        cmp$1_0
                        (let
                           ((x$2_0 x$2_0_old))
                           (let
                              ((y.0$2_0 0)
                               (z.0$2_0 x$2_0))
                              (let
                                 ((cmp$2_0 (> z.0$2_0 0)))
                                 (=>
                                    cmp$2_0
                                    (INV_MAIN_42 x$1_0 y.0$1_0 z.0$1_0 x$2_0 y.0$2_0 z.0$2_0)))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (y.0$1_0_old Int)
       (z.0$1_0_old Int)
       (x$2_0_old Int)
       (y.0$2_0_old Int)
       (z.0$2_0_old Int))
      (=>
         (INV_MAIN_42 x$1_0_old y.0$1_0_old z.0$1_0_old x$2_0_old y.0$2_0_old z.0$2_0_old)
         (let
            ((x$1_0 x$1_0_old)
             (y.0$1_0 y.0$1_0_old)
             (z.0$1_0 z.0$1_0_old))
            (let
               ((dec$1_0 (+ z.0$1_0 (- 1)))
                (add$1_0 (+ y.0$1_0 x$1_0)))
               (let
                  ((y.0$1_0 add$1_0)
                   (z.0$1_0 dec$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        (not cmp$1_0)
                        (let
                           ((result$1 y.0$1_0)
                            (x$2_0 x$2_0_old)
                            (y.0$2_0 y.0$2_0_old)
                            (z.0$2_0 z.0$2_0_old))
                           (let
                              ((dec$2_0 (+ z.0$2_0 (- 1)))
                               (add$2_0 (+ y.0$2_0 x$2_0)))
                              (let
                                 ((y.0$2_0 add$2_0)
                                  (z.0$2_0 dec$2_0))
                                 (let
                                    ((cmp$2_0 (> z.0$2_0 0)))
                                    (=>
                                       (not cmp$2_0)
                                       (let
                                          ((mul$2_0 (* 2 y.0$2_0)))
                                          (let
                                             ((result$2 mul$2_0))
                                             (OUT_INV result$1 result$2))))))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (y.0$1_0_old Int)
       (z.0$1_0_old Int)
       (x$2_0_old Int)
       (y.0$2_0_old Int)
       (z.0$2_0_old Int))
      (=>
         (INV_MAIN_42 x$1_0_old y.0$1_0_old z.0$1_0_old x$2_0_old y.0$2_0_old z.0$2_0_old)
         (let
            ((x$1_0 x$1_0_old)
             (y.0$1_0 y.0$1_0_old)
             (z.0$1_0 z.0$1_0_old))
            (let
               ((dec$1_0 (+ z.0$1_0 (- 1)))
                (add$1_0 (+ y.0$1_0 x$1_0)))
               (let
                  ((y.0$1_0 add$1_0)
                   (z.0$1_0 dec$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        cmp$1_0
                        (let
                           ((x$2_0 x$2_0_old)
                            (y.0$2_0 y.0$2_0_old)
                            (z.0$2_0 z.0$2_0_old))
                           (let
                              ((dec$2_0 (+ z.0$2_0 (- 1)))
                               (add$2_0 (+ y.0$2_0 x$2_0)))
                              (let
                                 ((y.0$2_0 add$2_0)
                                  (z.0$2_0 dec$2_0))
                                 (let
                                    ((cmp$2_0 (> z.0$2_0 0)))
                                    (=>
                                       cmp$2_0
                                       (INV_MAIN_42 x$1_0 y.0$1_0 z.0$1_0 x$2_0 y.0$2_0 z.0$2_0))))))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (y.0$1_0_old Int)
       (z.0$1_0_old Int)
       (x$2_0_old Int)
       (y.0$2_0_old Int)
       (z.0$2_0_old Int))
      (=>
         (INV_MAIN_42 x$1_0_old y.0$1_0_old z.0$1_0_old x$2_0_old y.0$2_0_old z.0$2_0_old)
         (let
            ((x$1_0 x$1_0_old)
             (y.0$1_0 y.0$1_0_old)
             (z.0$1_0 z.0$1_0_old))
            (let
               ((dec$1_0 (+ z.0$1_0 (- 1)))
                (add$1_0 (+ y.0$1_0 x$1_0)))
               (let
                  ((y.0$1_0 add$1_0)
                   (z.0$1_0 dec$1_0))
                  (let
                     ((cmp$1_0 (> z.0$1_0 0)))
                     (=>
                        cmp$1_0
                        (=>
                           (let
                              ((x$2_0 x$2_0_old)
                               (y.0$2_0 y.0$2_0_old)
                               (z.0$2_0 z.0$2_0_old))
                              (let
                                 ((dec$2_0 (+ z.0$2_0 (- 1)))
                                  (add$2_0 (+ y.0$2_0 x$2_0)))
                                 (let
                                    ((y.0$2_0 add$2_0)
                                     (z.0$2_0 dec$2_0))
                                    (let
                                       ((cmp$2_0 (> z.0$2_0 0)))
                                       (not cmp$2_0)))))
                           (INV_MAIN_42 x$1_0 y.0$1_0 z.0$1_0 x$2_0_old y.0$2_0_old z.0$2_0_old))))))))))
(assert
   (forall
      ((x$1_0_old Int)
       (y.0$1_0_old Int)
       (z.0$1_0_old Int)
       (x$2_0_old Int)
       (y.0$2_0_old Int)
       (z.0$2_0_old Int))
      (=>
         (INV_MAIN_42 x$1_0_old y.0$1_0_old z.0$1_0_old x$2_0_old y.0$2_0_old z.0$2_0_old)
         (let
            ((x$2_0 x$2_0_old)
             (y.0$2_0 y.0$2_0_old)
             (z.0$2_0 z.0$2_0_old))
            (let
               ((dec$2_0 (+ z.0$2_0 (- 1)))
                (add$2_0 (+ y.0$2_0 x$2_0)))
               (let
                  ((y.0$2_0 add$2_0)
                   (z.0$2_0 dec$2_0))
                  (let
                     ((cmp$2_0 (> z.0$2_0 0)))
                     (=>
                        cmp$2_0
                        (=>
                           (let
                              ((x$1_0 x$1_0_old)
                               (y.0$1_0 y.0$1_0_old)
                               (z.0$1_0 z.0$1_0_old))
                              (let
                                 ((dec$1_0 (+ z.0$1_0 (- 1)))
                                  (add$1_0 (+ y.0$1_0 x$1_0)))
                                 (let
                                    ((y.0$1_0 add$1_0)
                                     (z.0$1_0 dec$1_0))
                                    (let
                                       ((cmp$1_0 (> z.0$1_0 0)))
                                       (not cmp$1_0)))))
                           (INV_MAIN_42 x$1_0_old y.0$1_0_old z.0$1_0_old x$2_0 y.0$2_0 z.0$2_0))))))))))
(check-sat)
(get-model)
