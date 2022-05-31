(set-logic HORN)
(define-fun
   IN_INV
   ((n$1_0 Int)
    (n$2_0 Int))
   Bool
   (= n$1_0 n$2_0))
(define-fun
   OUT_INV
   ((result$1 Int)
    (result$2 Int))
   Bool
   (= result$1 result$2))
; :annot (INV_MAIN_42 ct.0$1_0 n.addr.0$1_0 ct.0$2_0 n.addr.0$2_0)
(declare-fun
   INV_MAIN_42
   (Int
    Int
    Int
    Int)
   Bool)
(assert
   (forall
      ((n$1_0_old Int)
       (n$2_0_old Int))
      (=>
         (IN_INV n$1_0_old n$2_0_old)
         (let
            ((n$1_0 n$1_0_old))
            (let
               ((n.addr.0$1_0 n$1_0)
                (ct.0$1_0 0))
               (let
                  ((cmp$1_0 (> n.addr.0$1_0 0)))
                  (=>
                     (not cmp$1_0)
                     (let
                        ((result$1 ct.0$1_0)
                         (n$2_0 n$2_0_old))
                        (let
                           ((n.addr.0$2_0 n$2_0)
                            (ct.0$2_0 0))
                           (let
                              ((cmp$2_0 (> n.addr.0$2_0 0)))
                              (not cmp$2_0)))))))))))
(assert
   (forall
      ((n$1_0_old Int)
       (n$2_0_old Int))
      (=>
         (IN_INV n$1_0_old n$2_0_old)
         (let
            ((n$1_0 n$1_0_old))
            (let
               ((n.addr.0$1_0 n$1_0)
                (ct.0$1_0 0))
               (let
                  ((cmp$1_0 (> n.addr.0$1_0 0)))
                  (=>
                     cmp$1_0
                     (let
                        ((n$2_0 n$2_0_old))
                        (let
                           ((n.addr.0$2_0 n$2_0)
                            (ct.0$2_0 0))
                           (let
                              ((cmp$2_0 (> n.addr.0$2_0 0)))
                              (=>
                                 (not cmp$2_0)
                                 (let
                                    ((result$2 ct.0$2_0))
                                    false))))))))))))
(assert
   (forall
      ((n$1_0_old Int)
       (n$2_0_old Int))
      (=>
         (IN_INV n$1_0_old n$2_0_old)
         (let
            ((n$1_0 n$1_0_old))
            (let
               ((n.addr.0$1_0 n$1_0)
                (ct.0$1_0 0))
               (let
                  ((cmp$1_0 (> n.addr.0$1_0 0)))
                  (=>
                     (not cmp$1_0)
                     (let
                        ((result$1 ct.0$1_0)
                         (n$2_0 n$2_0_old))
                        (let
                           ((n.addr.0$2_0 n$2_0)
                            (ct.0$2_0 0))
                           (let
                              ((cmp$2_0 (> n.addr.0$2_0 0)))
                              (=>
                                 (not cmp$2_0)
                                 (let
                                    ((result$2 ct.0$2_0))
                                    (OUT_INV result$1 result$2)))))))))))))
(assert
   (forall
      ((n$1_0_old Int)
       (n$2_0_old Int))
      (=>
         (IN_INV n$1_0_old n$2_0_old)
         (let
            ((n$1_0 n$1_0_old))
            (let
               ((n.addr.0$1_0 n$1_0)
                (ct.0$1_0 0))
               (let
                  ((cmp$1_0 (> n.addr.0$1_0 0)))
                  (=>
                     cmp$1_0
                     (let
                        ((n$2_0 n$2_0_old))
                        (let
                           ((n.addr.0$2_0 n$2_0)
                            (ct.0$2_0 0))
                           (let
                              ((cmp$2_0 (> n.addr.0$2_0 0)))
                              (=>
                                 cmp$2_0
                                 (INV_MAIN_42 ct.0$1_0 n.addr.0$1_0 ct.0$2_0 n.addr.0$2_0))))))))))))
(assert
   (forall
      ((ct.0$1_0_old Int)
       (n.addr.0$1_0_old Int)
       (ct.0$2_0_old Int)
       (n.addr.0$2_0_old Int))
      (=>
         (INV_MAIN_42 ct.0$1_0_old n.addr.0$1_0_old ct.0$2_0_old n.addr.0$2_0_old)
         (let
            ((ct.0$1_0 ct.0$1_0_old)
             (n.addr.0$1_0 n.addr.0$1_0_old))
            (let
               ((rem$1_0 (mod
                             n.addr.0$1_0
                             10)))
               (let
                  ((cmp1$1_0 (> rem$1_0 0))
                   (inc$1_0 (+ ct.0$1_0 1)))
                  (let
                     ((inc.ct.0$1_0 (ite cmp1$1_0 inc$1_0 ct.0$1_0))
                      (div$1_0 (div n.addr.0$1_0 10)))
                     (let
                        ((n.addr.0$1_0 div$1_0)
                         (ct.0$1_0 inc.ct.0$1_0))
                        (let
                           ((cmp$1_0 (> n.addr.0$1_0 0)))
                           (=>
                              (not cmp$1_0)
                              (let
                                 ((result$1 ct.0$1_0)
                                  (ct.0$2_0 ct.0$2_0_old)
                                  (n.addr.0$2_0 n.addr.0$2_0_old))
                                 (let
                                    ((rem$2_0 (mod
                                                  n.addr.0$2_0
                                                  10)))
                                    (let
                                       ((cmp1$2_0 (> rem$2_0 0))
                                        (inc$2_0 (+ ct.0$2_0 1)))
                                       (let
                                          ((inc.ct.0$2_0 (ite cmp1$2_0 inc$2_0 ct.0$2_0))
                                           (div$2_0 (div n.addr.0$2_0 10)))
                                          (let
                                             ((n.addr.0$2_0 div$2_0)
                                              (ct.0$2_0 inc.ct.0$2_0))
                                             (let
                                                ((cmp$2_0 (> n.addr.0$2_0 0)))
                                                (=>
                                                   (not cmp$2_0)
                                                   (let
                                                      ((result$2 ct.0$2_0))
                                                      (OUT_INV result$1 result$2)))))))))))))))))))
(assert
   (forall
      ((ct.0$1_0_old Int)
       (n.addr.0$1_0_old Int)
       (ct.0$2_0_old Int)
       (n.addr.0$2_0_old Int))
      (=>
         (INV_MAIN_42 ct.0$1_0_old n.addr.0$1_0_old ct.0$2_0_old n.addr.0$2_0_old)
         (let
            ((ct.0$1_0 ct.0$1_0_old)
             (n.addr.0$1_0 n.addr.0$1_0_old))
            (let
               ((rem$1_0 (mod
                             n.addr.0$1_0
                             10)))
               (let
                  ((cmp1$1_0 (> rem$1_0 0))
                   (inc$1_0 (+ ct.0$1_0 1)))
                  (let
                     ((inc.ct.0$1_0 (ite cmp1$1_0 inc$1_0 ct.0$1_0))
                      (div$1_0 (div n.addr.0$1_0 10)))
                     (let
                        ((n.addr.0$1_0 div$1_0)
                         (ct.0$1_0 inc.ct.0$1_0))
                        (let
                           ((cmp$1_0 (> n.addr.0$1_0 0)))
                           (=>
                              cmp$1_0
                              (let
                                 ((ct.0$2_0 ct.0$2_0_old)
                                  (n.addr.0$2_0 n.addr.0$2_0_old))
                                 (let
                                    ((rem$2_0 (mod
                                                  n.addr.0$2_0
                                                  10)))
                                    (let
                                       ((cmp1$2_0 (> rem$2_0 0))
                                        (inc$2_0 (+ ct.0$2_0 1)))
                                       (let
                                          ((inc.ct.0$2_0 (ite cmp1$2_0 inc$2_0 ct.0$2_0))
                                           (div$2_0 (div n.addr.0$2_0 10)))
                                          (let
                                             ((n.addr.0$2_0 div$2_0)
                                              (ct.0$2_0 inc.ct.0$2_0))
                                             (let
                                                ((cmp$2_0 (> n.addr.0$2_0 0)))
                                                (=>
                                                   cmp$2_0
                                                   (INV_MAIN_42 ct.0$1_0 n.addr.0$1_0 ct.0$2_0 n.addr.0$2_0))))))))))))))))))
(assert
   (forall
      ((ct.0$1_0_old Int)
       (n.addr.0$1_0_old Int)
       (ct.0$2_0_old Int)
       (n.addr.0$2_0_old Int))
      (=>
         (INV_MAIN_42 ct.0$1_0_old n.addr.0$1_0_old ct.0$2_0_old n.addr.0$2_0_old)
         (let
            ((ct.0$1_0 ct.0$1_0_old)
             (n.addr.0$1_0 n.addr.0$1_0_old))
            (let
               ((rem$1_0 (mod
                             n.addr.0$1_0
                             10)))
               (let
                  ((cmp1$1_0 (> rem$1_0 0))
                   (inc$1_0 (+ ct.0$1_0 1)))
                  (let
                     ((inc.ct.0$1_0 (ite cmp1$1_0 inc$1_0 ct.0$1_0))
                      (div$1_0 (div n.addr.0$1_0 10)))
                     (let
                        ((n.addr.0$1_0 div$1_0)
                         (ct.0$1_0 inc.ct.0$1_0))
                        (let
                           ((cmp$1_0 (> n.addr.0$1_0 0)))
                           (=>
                              cmp$1_0
                              (=>
                                 (let
                                    ((ct.0$2_0 ct.0$2_0_old)
                                     (n.addr.0$2_0 n.addr.0$2_0_old))
                                    (let
                                       ((rem$2_0 (mod
                                                     n.addr.0$2_0
                                                     10)))
                                       (let
                                          ((cmp1$2_0 (> rem$2_0 0))
                                           (inc$2_0 (+ ct.0$2_0 1)))
                                          (let
                                             ((inc.ct.0$2_0 (ite cmp1$2_0 inc$2_0 ct.0$2_0))
                                              (div$2_0 (div n.addr.0$2_0 10)))
                                             (let
                                                ((n.addr.0$2_0 div$2_0)
                                                 (ct.0$2_0 inc.ct.0$2_0))
                                                (let
                                                   ((cmp$2_0 (> n.addr.0$2_0 0)))
                                                   (not cmp$2_0)))))))
                                 (INV_MAIN_42 ct.0$1_0 n.addr.0$1_0 ct.0$2_0_old n.addr.0$2_0_old))))))))))))
(assert
   (forall
      ((ct.0$1_0_old Int)
       (n.addr.0$1_0_old Int)
       (ct.0$2_0_old Int)
       (n.addr.0$2_0_old Int))
      (=>
         (INV_MAIN_42 ct.0$1_0_old n.addr.0$1_0_old ct.0$2_0_old n.addr.0$2_0_old)
         (let
            ((ct.0$2_0 ct.0$2_0_old)
             (n.addr.0$2_0 n.addr.0$2_0_old))
            (let
               ((rem$2_0 (mod
                             n.addr.0$2_0
                             10)))
               (let
                  ((cmp1$2_0 (> rem$2_0 0))
                   (inc$2_0 (+ ct.0$2_0 1)))
                  (let
                     ((inc.ct.0$2_0 (ite cmp1$2_0 inc$2_0 ct.0$2_0))
                      (div$2_0 (div n.addr.0$2_0 10)))
                     (let
                        ((n.addr.0$2_0 div$2_0)
                         (ct.0$2_0 inc.ct.0$2_0))
                        (let
                           ((cmp$2_0 (> n.addr.0$2_0 0)))
                           (=>
                              cmp$2_0
                              (=>
                                 (let
                                    ((ct.0$1_0 ct.0$1_0_old)
                                     (n.addr.0$1_0 n.addr.0$1_0_old))
                                    (let
                                       ((rem$1_0 (mod
                                                     n.addr.0$1_0
                                                     10)))
                                       (let
                                          ((cmp1$1_0 (> rem$1_0 0))
                                           (inc$1_0 (+ ct.0$1_0 1)))
                                          (let
                                             ((inc.ct.0$1_0 (ite cmp1$1_0 inc$1_0 ct.0$1_0))
                                              (div$1_0 (div n.addr.0$1_0 10)))
                                             (let
                                                ((n.addr.0$1_0 div$1_0)
                                                 (ct.0$1_0 inc.ct.0$1_0))
                                                (let
                                                   ((cmp$1_0 (> n.addr.0$1_0 0)))
                                                   (not cmp$1_0)))))))
                                 (INV_MAIN_42 ct.0$1_0_old n.addr.0$1_0_old ct.0$2_0 n.addr.0$2_0))))))))))))
(check-sat)
(get-model)
