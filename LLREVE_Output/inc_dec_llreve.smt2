(set-logic HORN)
(define-fun
   INV_REC_call2__1
   ((result$1 Int))
   Bool
   true)
(define-fun
   INV_REC_call1__2
   ((result$2 Int))
   Bool
   true)
(define-fun
   IN_INV
   ((l$1_0 Int)
    (l$2_0 Int))
   Bool
   (= l$1_0 l$2_0))
(define-fun
   OUT_INV
   ((result$1 Int)
    (result$2 Int))
   Bool
   (= result$1 result$2))
; :annot (INV_MAIN_42 call$1_0 l$1_0 call$2_0 l$2_0)
(declare-fun
   INV_MAIN_42
   (Int
    Int
    Int
    Int)
   Bool)
(assert
   (forall
      ((l$1_0_old Int)
       (l$2_0_old Int))
      (=>
         (IN_INV l$1_0_old l$2_0_old)
         (let
            ((l$1_0 l$1_0_old)
             (l$2_0 l$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (> call$2_0 0)))
                     (=>
                        cmp$2_0
                        (forall
                           ((call$1_0 Int))
                           (=>
                              (INV_REC_call2__1 call$1_0)
                              (let
                                 ((cmp$1_0 (> call$1_0 0)))
                                 (=>
                                    (not cmp$1_0)
                                    (let
                                       ((l.addr.0$1_0 l$1_0))
                                       (let
                                          ((result$1 l.addr.0$1_0))
                                          false))))))))))))))
(assert
   (forall
      ((l$1_0_old Int)
       (l$2_0_old Int))
      (=>
         (IN_INV l$1_0_old l$2_0_old)
         (let
            ((l$1_0 l$1_0_old)
             (l$2_0 l$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (> call$2_0 0)))
                     (=>
                        (not cmp$2_0)
                        (let
                           ((l.addr.0$2_0 l$2_0))
                           (let
                              ((result$2 l.addr.0$2_0))
                              (forall
                                 ((call$1_0 Int))
                                 (=>
                                    (INV_REC_call2__1 call$1_0)
                                    (let
                                       ((cmp$1_0 (> call$1_0 0)))
                                       (not cmp$1_0))))))))))))))
(assert
   (forall
      ((l$1_0_old Int)
       (l$2_0_old Int))
      (=>
         (IN_INV l$1_0_old l$2_0_old)
         (let
            ((l$1_0 l$1_0_old)
             (l$2_0 l$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (> call$2_0 0)))
                     (=>
                        (not cmp$2_0)
                        (let
                           ((l.addr.0$2_0 l$2_0))
                           (let
                              ((result$2 l.addr.0$2_0))
                              (forall
                                 ((call$1_0 Int))
                                 (=>
                                    (INV_REC_call2__1 call$1_0)
                                    (let
                                       ((cmp$1_0 (> call$1_0 0)))
                                       (=>
                                          (not cmp$1_0)
                                          (let
                                             ((l.addr.0$1_0 l$1_0))
                                             (let
                                                ((result$1 l.addr.0$1_0))
                                                (OUT_INV result$1 result$2)))))))))))))))))
(assert
   (forall
      ((l$1_0_old Int)
       (l$2_0_old Int))
      (=>
         (IN_INV l$1_0_old l$2_0_old)
         (let
            ((l$1_0 l$1_0_old)
             (l$2_0 l$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (> call$2_0 0)))
                     (=>
                        cmp$2_0
                        (forall
                           ((call$1_0 Int))
                           (=>
                              (INV_REC_call2__1 call$1_0)
                              (let
                                 ((cmp$1_0 (> call$1_0 0)))
                                 (=>
                                    cmp$1_0
                                    (INV_MAIN_42 call$1_0 l$1_0 call$2_0 l$2_0)))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (l$1_0_old Int)
       (call$2_0_old Int)
       (l$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old l$1_0_old call$2_0_old l$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (l$1_0 l$1_0_old))
            (let
               ((add$1_0 (+ l$1_0 call$1_0)))
               (let
                  ((sub$1_0 (- add$1_0 call$1_0)))
                  (let
                     ((l.addr.0$1_0 sub$1_0))
                     (let
                        ((result$1 l.addr.0$1_0)
                         (call$2_0 call$2_0_old)
                         (l$2_0 l$2_0_old))
                        (let
                           ((add$2_0 (+ l$2_0 call$2_0)))
                           (let
                              ((sub$2_0 (- add$2_0 call$2_0)))
                              (let
                                 ((l.addr.0$2_0 sub$2_0))
                                 (let
                                    ((result$2 l.addr.0$2_0))
                                    (OUT_INV result$1 result$2)))))))))))))
(check-sat)
(get-model)
