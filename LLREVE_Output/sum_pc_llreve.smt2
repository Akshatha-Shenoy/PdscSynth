(set-logic HORN)
(define-fun
   INV_REC_call1__1
   ((result$1 Int))
   Bool
   true)
(define-fun
   INV_REC_call2__2
   ((result$2 Int))
   Bool
   true)
(define-fun
   IN_INV
   ((max$1_0 Int)
    (max$2_0 Int))
   Bool
   (= max$1_0 max$2_0))
(define-fun
   OUT_INV
   ((result$1 Int)
    (result$2 Int))
   Bool
   (= result$1 result$2))
; :annot (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)
(declare-fun
   INV_MAIN_42
   (Int
    Int
    Int
    Int
    Int
    Int
    Int
    Int
    Int
    Int
    Int
    Int)
   Bool)
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       cmp5$2_0
                                       (forall
                                          ((call$1_0 Int))
                                          (=>
                                             (INV_REC_call1__1 call$1_0)
                                             (let
                                                ((cmp$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((.$1_0 (ite cmp$1_0 1 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0))
                                                    (cmp2$1_0 (<= call$1_0 0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp1$1_0
                                                                        cmp2$1_0)))
                                                      (=>
                                                         or.cond$1_0
                                                         (let
                                                            ((retval.0$1_0 (- 1)))
                                                            (let
                                                               ((result$1 retval.0$1_0))
                                                               false)))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       cmp5$2_0
                                       (forall
                                          ((call$1_0 Int))
                                          (=>
                                             (INV_REC_call1__1 call$1_0)
                                             (let
                                                ((cmp$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((.$1_0 (ite cmp$1_0 1 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0))
                                                    (cmp2$1_0 (<= call$1_0 0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp1$1_0
                                                                        cmp2$1_0)))
                                                      (=>
                                                         (not or.cond$1_0)
                                                         (let
                                                            ((pc.1$1_0 .$1_0)
                                                             (i.0$1_0 0)
                                                             (y.0$1_0 0)
                                                             (v.0$1_0 0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp5$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0))
                                                                        false))))))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              or.cond$2_0
                              (let
                                 ((retval.0$2_0 (- 1)))
                                 (let
                                    ((result$2 retval.0$2_0))
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call1__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0)))
                                             (let
                                                ((.$1_0 (ite cmp$1_0 1 0))
                                                 (cmp1$1_0 (<= max$1_0 call$1_0))
                                                 (cmp2$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((or.cond$1_0 (or
                                                                     cmp1$1_0
                                                                     cmp2$1_0)))
                                                   (=>
                                                      (not or.cond$1_0)
                                                      (let
                                                         ((pc.1$1_0 .$1_0)
                                                          (i.0$1_0 0)
                                                          (y.0$1_0 0)
                                                          (v.0$1_0 0))
                                                         (let
                                                            ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                            (not cmp5$1_0)))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       (not cmp5$2_0)
                                       (let
                                          ((retval.0$2_0 y.0$2_0))
                                          (let
                                             ((result$2 retval.0$2_0))
                                             (forall
                                                ((call$1_0 Int))
                                                (=>
                                                   (INV_REC_call1__1 call$1_0)
                                                   (let
                                                      ((cmp$1_0 (<= call$1_0 0)))
                                                      (let
                                                         ((.$1_0 (ite cmp$1_0 1 0))
                                                          (cmp1$1_0 (<= max$1_0 call$1_0))
                                                          (cmp2$1_0 (<= call$1_0 0)))
                                                         (let
                                                            ((or.cond$1_0 (or
                                                                              cmp1$1_0
                                                                              cmp2$1_0)))
                                                            (=>
                                                               (not or.cond$1_0)
                                                               (let
                                                                  ((pc.1$1_0 .$1_0)
                                                                   (i.0$1_0 0)
                                                                   (y.0$1_0 0)
                                                                   (v.0$1_0 0))
                                                                  (let
                                                                     ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                     (not cmp5$1_0))))))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              or.cond$2_0
                              (let
                                 ((retval.0$2_0 (- 1)))
                                 (let
                                    ((result$2 retval.0$2_0))
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call1__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0)))
                                             (let
                                                ((.$1_0 (ite cmp$1_0 1 0))
                                                 (cmp1$1_0 (<= max$1_0 call$1_0))
                                                 (cmp2$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((or.cond$1_0 (or
                                                                     cmp1$1_0
                                                                     cmp2$1_0)))
                                                   (=>
                                                      or.cond$1_0
                                                      (let
                                                         ((retval.0$1_0 (- 1)))
                                                         (let
                                                            ((result$1 retval.0$1_0))
                                                            (OUT_INV result$1 result$2)))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       (not cmp5$2_0)
                                       (let
                                          ((retval.0$2_0 y.0$2_0))
                                          (let
                                             ((result$2 retval.0$2_0))
                                             (forall
                                                ((call$1_0 Int))
                                                (=>
                                                   (INV_REC_call1__1 call$1_0)
                                                   (let
                                                      ((cmp$1_0 (<= call$1_0 0)))
                                                      (let
                                                         ((.$1_0 (ite cmp$1_0 1 0))
                                                          (cmp1$1_0 (<= max$1_0 call$1_0))
                                                          (cmp2$1_0 (<= call$1_0 0)))
                                                         (let
                                                            ((or.cond$1_0 (or
                                                                              cmp1$1_0
                                                                              cmp2$1_0)))
                                                            (=>
                                                               or.cond$1_0
                                                               (let
                                                                  ((retval.0$1_0 (- 1)))
                                                                  (let
                                                                     ((result$1 retval.0$1_0))
                                                                     (OUT_INV result$1 result$2))))))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              or.cond$2_0
                              (let
                                 ((retval.0$2_0 (- 1)))
                                 (let
                                    ((result$2 retval.0$2_0))
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call1__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0)))
                                             (let
                                                ((.$1_0 (ite cmp$1_0 1 0))
                                                 (cmp1$1_0 (<= max$1_0 call$1_0))
                                                 (cmp2$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((or.cond$1_0 (or
                                                                     cmp1$1_0
                                                                     cmp2$1_0)))
                                                   (=>
                                                      (not or.cond$1_0)
                                                      (let
                                                         ((pc.1$1_0 .$1_0)
                                                          (i.0$1_0 0)
                                                          (y.0$1_0 0)
                                                          (v.0$1_0 0))
                                                         (let
                                                            ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                            (=>
                                                               (not cmp5$1_0)
                                                               (let
                                                                  ((retval.0$1_0 y.0$1_0))
                                                                  (let
                                                                     ((result$1 retval.0$1_0))
                                                                     (OUT_INV result$1 result$2))))))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       (not cmp5$2_0)
                                       (let
                                          ((retval.0$2_0 y.0$2_0))
                                          (let
                                             ((result$2 retval.0$2_0))
                                             (forall
                                                ((call$1_0 Int))
                                                (=>
                                                   (INV_REC_call1__1 call$1_0)
                                                   (let
                                                      ((cmp$1_0 (<= call$1_0 0)))
                                                      (let
                                                         ((.$1_0 (ite cmp$1_0 1 0))
                                                          (cmp1$1_0 (<= max$1_0 call$1_0))
                                                          (cmp2$1_0 (<= call$1_0 0)))
                                                         (let
                                                            ((or.cond$1_0 (or
                                                                              cmp1$1_0
                                                                              cmp2$1_0)))
                                                            (=>
                                                               (not or.cond$1_0)
                                                               (let
                                                                  ((pc.1$1_0 .$1_0)
                                                                   (i.0$1_0 0)
                                                                   (y.0$1_0 0)
                                                                   (v.0$1_0 0))
                                                                  (let
                                                                     ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                     (=>
                                                                        (not cmp5$1_0)
                                                                        (let
                                                                           ((retval.0$1_0 y.0$1_0))
                                                                           (let
                                                                              ((result$1 retval.0$1_0))
                                                                              (OUT_INV result$1 result$2)))))))))))))))))))))))))))
(assert
   (forall
      ((max$1_0_old Int)
       (max$2_0_old Int))
      (=>
         (IN_INV max$1_0_old max$2_0_old)
         (let
            ((max$1_0 max$1_0_old)
             (max$2_0 max$2_0_old))
            (forall
               ((call$2_0 Int))
               (=>
                  (INV_REC_call2__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0)))
                     (let
                        ((.$2_0 (ite cmp$2_0 1 0))
                         (cmp1$2_0 (<= max$2_0 call$2_0))
                         (cmp2$2_0 (<= call$2_0 0)))
                        (let
                           ((or.cond$2_0 (or
                                             cmp1$2_0
                                             cmp2$2_0)))
                           (=>
                              (not or.cond$2_0)
                              (let
                                 ((pc.1$2_0 .$2_0)
                                  (i.0$2_0 0)
                                  (y.0$2_0 0)
                                  (v.0$2_0 0))
                                 (let
                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                    (=>
                                       cmp5$2_0
                                       (forall
                                          ((call$1_0 Int))
                                          (=>
                                             (INV_REC_call1__1 call$1_0)
                                             (let
                                                ((cmp$1_0 (<= call$1_0 0)))
                                                (let
                                                   ((.$1_0 (ite cmp$1_0 1 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0))
                                                    (cmp2$1_0 (<= call$1_0 0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp1$1_0
                                                                        cmp2$1_0)))
                                                      (=>
                                                         (not or.cond$1_0)
                                                         (let
                                                            ((pc.1$1_0 .$1_0)
                                                             (i.0$1_0 0)
                                                             (y.0$1_0 0)
                                                             (v.0$1_0 0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          (not cmp5$1_0)
                                          (let
                                             ((retval.0$1_0 y.0$1_0))
                                             (let
                                                ((result$1 retval.0$1_0)
                                                 (call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.1$2_0 pc.1$2_0_old))
                                                (let
                                                   ((v.0$2_0 v.0$2_0_old)
                                                    (y.0$2_0 y.0$2_0_old)
                                                    (cmp7$2_0 (< call$2_0 max$2_0))
                                                    (cmp8$2_0 (= pc.1$2_0 0)))
                                                   (let
                                                      ((or.cond44$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp8$2_0))
                                                       (cmp10$2_0 (= v.0$2_0 0)))
                                                      (let
                                                         ((or.cond45$2_0 (and
                                                                             or.cond44$2_0
                                                                             cmp10$2_0)))
                                                         (=>
                                                            or.cond45$2_0
                                                            (let
                                                               ((inc$2_0 (+ i.0$2_0 1)))
                                                               (let
                                                                  ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                  (let
                                                                     ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                      (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                     (let
                                                                        ((pc.1$2_0 .46$2_0)
                                                                         (i.0$2_0 inc$2_0)
                                                                         (y.0$2_0 add$2_0)
                                                                         (v.0$2_0 v.0$2_0))
                                                                        (let
                                                                           ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                           (=>
                                                                              (not cmp5$2_0)
                                                                              (let
                                                                                 ((retval.0$2_0 y.0$2_0))
                                                                                 (let
                                                                                    ((result$2 retval.0$2_0))
                                                                                    (OUT_INV result$1 result$2)))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          (not cmp5$1_0)
                                          (let
                                             ((retval.0$1_0 y.0$1_0))
                                             (let
                                                ((result$1 retval.0$1_0)
                                                 (call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.1$2_0 pc.1$2_0_old))
                                                (let
                                                   ((v.0$2_0 v.0$2_0_old)
                                                    (y.0$2_0 y.0$2_0_old)
                                                    (cmp7$2_0 (< call$2_0 max$2_0))
                                                    (cmp8$2_0 (= pc.1$2_0 0)))
                                                   (let
                                                      ((or.cond44$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp8$2_0))
                                                       (cmp10$2_0 (= v.0$2_0 0)))
                                                      (let
                                                         ((or.cond45$2_0 (and
                                                                             or.cond44$2_0
                                                                             cmp10$2_0)))
                                                         (=>
                                                            (not or.cond45$2_0)
                                                            (let
                                                               ((cmp17$2_0 (= v.0$2_0 0))
                                                                (cmp19$2_0 (= pc.1$2_0 1)))
                                                               (let
                                                                  ((or.cond47$2_0 (and
                                                                                      cmp17$2_0
                                                                                      cmp19$2_0))
                                                                   (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                  (let
                                                                     ((or.cond48$2_0 (and
                                                                                         or.cond47$2_0
                                                                                         cmp21$2_0)))
                                                                     (=>
                                                                        or.cond48$2_0
                                                                        (let
                                                                           ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                           (let
                                                                              ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                              (let
                                                                                 ((pc.1$2_0 .49$2_0)
                                                                                  (i.0$2_0 i.0$2_0)
                                                                                  (y.0$2_0 y.0$2_0)
                                                                                  (v.0$2_0 1))
                                                                                 (let
                                                                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                    (=>
                                                                                       (not cmp5$2_0)
                                                                                       (let
                                                                                          ((retval.0$2_0 y.0$2_0))
                                                                                          (let
                                                                                             ((result$2 retval.0$2_0))
                                                                                             (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          (not cmp5$1_0)
                                          (let
                                             ((retval.0$1_0 y.0$1_0))
                                             (let
                                                ((result$1 retval.0$1_0)
                                                 (call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.1$2_0 pc.1$2_0_old))
                                                (let
                                                   ((v.0$2_0 v.0$2_0_old)
                                                    (y.0$2_0 y.0$2_0_old)
                                                    (cmp7$2_0 (< call$2_0 max$2_0))
                                                    (cmp8$2_0 (= pc.1$2_0 0)))
                                                   (let
                                                      ((or.cond44$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp8$2_0))
                                                       (cmp10$2_0 (= v.0$2_0 0)))
                                                      (let
                                                         ((or.cond45$2_0 (and
                                                                             or.cond44$2_0
                                                                             cmp10$2_0)))
                                                         (=>
                                                            (not or.cond45$2_0)
                                                            (let
                                                               ((cmp17$2_0 (= v.0$2_0 0))
                                                                (cmp19$2_0 (= pc.1$2_0 1)))
                                                               (let
                                                                  ((or.cond47$2_0 (and
                                                                                      cmp17$2_0
                                                                                      cmp19$2_0))
                                                                   (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                  (let
                                                                     ((or.cond48$2_0 (and
                                                                                         or.cond47$2_0
                                                                                         cmp21$2_0)))
                                                                     (=>
                                                                        (not or.cond48$2_0)
                                                                        (let
                                                                           ((cmp28$2_0 (= v.0$2_0 1))
                                                                            (cmp30$2_0 (= pc.1$2_0 2)))
                                                                           (let
                                                                              ((or.cond50$2_0 (and
                                                                                                  cmp28$2_0
                                                                                                  cmp30$2_0))
                                                                               (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                              (let
                                                                                 ((or.cond51$2_0 (and
                                                                                                     or.cond50$2_0
                                                                                                     cmp32$2_0)))
                                                                                 (=>
                                                                                    or.cond51$2_0
                                                                                    (let
                                                                                       ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                       (let
                                                                                          ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                           (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                          (let
                                                                                             ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                             (let
                                                                                                ((pc.1$2_0 .52$2_0)
                                                                                                 (i.0$2_0 inc34$2_0)
                                                                                                 (y.0$2_0 add35$2_0)
                                                                                                 (v.0$2_0 v.0$2_0))
                                                                                                (let
                                                                                                   ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                   (=>
                                                                                                      (not cmp5$2_0)
                                                                                                      (let
                                                                                                         ((retval.0$2_0 y.0$2_0))
                                                                                                         (let
                                                                                                            ((result$2 retval.0$2_0))
                                                                                                            (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          (not cmp5$1_0)
                                          (let
                                             ((retval.0$1_0 y.0$1_0))
                                             (let
                                                ((result$1 retval.0$1_0)
                                                 (call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.1$2_0 pc.1$2_0_old))
                                                (let
                                                   ((v.0$2_0 v.0$2_0_old)
                                                    (y.0$2_0 y.0$2_0_old)
                                                    (cmp7$2_0 (< call$2_0 max$2_0))
                                                    (cmp8$2_0 (= pc.1$2_0 0)))
                                                   (let
                                                      ((or.cond44$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp8$2_0))
                                                       (cmp10$2_0 (= v.0$2_0 0)))
                                                      (let
                                                         ((or.cond45$2_0 (and
                                                                             or.cond44$2_0
                                                                             cmp10$2_0)))
                                                         (=>
                                                            (not or.cond45$2_0)
                                                            (let
                                                               ((cmp17$2_0 (= v.0$2_0 0))
                                                                (cmp19$2_0 (= pc.1$2_0 1)))
                                                               (let
                                                                  ((or.cond47$2_0 (and
                                                                                      cmp17$2_0
                                                                                      cmp19$2_0))
                                                                   (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                  (let
                                                                     ((or.cond48$2_0 (and
                                                                                         or.cond47$2_0
                                                                                         cmp21$2_0)))
                                                                     (=>
                                                                        (not or.cond48$2_0)
                                                                        (let
                                                                           ((cmp28$2_0 (= v.0$2_0 1))
                                                                            (cmp30$2_0 (= pc.1$2_0 2)))
                                                                           (let
                                                                              ((or.cond50$2_0 (and
                                                                                                  cmp28$2_0
                                                                                                  cmp30$2_0))
                                                                               (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                              (let
                                                                                 ((or.cond51$2_0 (and
                                                                                                     or.cond50$2_0
                                                                                                     cmp32$2_0)))
                                                                                 (=>
                                                                                    (not or.cond51$2_0)
                                                                                    (let
                                                                                       ((pc.1$2_0 pc.1$2_0)
                                                                                        (i.0$2_0 i.0$2_0)
                                                                                        (y.0$2_0 y.0$2_0)
                                                                                        (v.0$2_0 v.0$2_0))
                                                                                       (let
                                                                                          ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                          (=>
                                                                                             (not cmp5$2_0)
                                                                                             (let
                                                                                                ((retval.0$2_0 y.0$2_0))
                                                                                                (let
                                                                                                   ((result$2 retval.0$2_0))
                                                                                                   (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp5$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.1$2_0 pc.1$2_0_old))
                                                         (let
                                                            ((v.0$2_0 v.0$2_0_old)
                                                             (y.0$2_0 y.0$2_0_old)
                                                             (cmp7$2_0 (< call$2_0 max$2_0))
                                                             (cmp8$2_0 (= pc.1$2_0 0)))
                                                            (let
                                                               ((or.cond44$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp8$2_0))
                                                                (cmp10$2_0 (= v.0$2_0 0)))
                                                               (let
                                                                  ((or.cond45$2_0 (and
                                                                                      or.cond44$2_0
                                                                                      cmp10$2_0)))
                                                                  (=>
                                                                     or.cond45$2_0
                                                                     (let
                                                                        ((inc$2_0 (+ i.0$2_0 1)))
                                                                        (let
                                                                           ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                           (let
                                                                              ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                               (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                              (let
                                                                                 ((pc.1$2_0 .46$2_0)
                                                                                  (i.0$2_0 inc$2_0)
                                                                                  (y.0$2_0 add$2_0)
                                                                                  (v.0$2_0 v.0$2_0))
                                                                                 (let
                                                                                    ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                    (=>
                                                                                       (not cmp5$2_0)
                                                                                       (let
                                                                                          ((retval.0$2_0 y.0$2_0))
                                                                                          (let
                                                                                             ((result$2 retval.0$2_0))
                                                                                             (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp5$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.1$2_0 pc.1$2_0_old))
                                                         (let
                                                            ((v.0$2_0 v.0$2_0_old)
                                                             (y.0$2_0 y.0$2_0_old)
                                                             (cmp7$2_0 (< call$2_0 max$2_0))
                                                             (cmp8$2_0 (= pc.1$2_0 0)))
                                                            (let
                                                               ((or.cond44$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp8$2_0))
                                                                (cmp10$2_0 (= v.0$2_0 0)))
                                                               (let
                                                                  ((or.cond45$2_0 (and
                                                                                      or.cond44$2_0
                                                                                      cmp10$2_0)))
                                                                  (=>
                                                                     (not or.cond45$2_0)
                                                                     (let
                                                                        ((cmp17$2_0 (= v.0$2_0 0))
                                                                         (cmp19$2_0 (= pc.1$2_0 1)))
                                                                        (let
                                                                           ((or.cond47$2_0 (and
                                                                                               cmp17$2_0
                                                                                               cmp19$2_0))
                                                                            (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                           (let
                                                                              ((or.cond48$2_0 (and
                                                                                                  or.cond47$2_0
                                                                                                  cmp21$2_0)))
                                                                              (=>
                                                                                 or.cond48$2_0
                                                                                 (let
                                                                                    ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                    (let
                                                                                       ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                       (let
                                                                                          ((pc.1$2_0 .49$2_0)
                                                                                           (i.0$2_0 i.0$2_0)
                                                                                           (y.0$2_0 y.0$2_0)
                                                                                           (v.0$2_0 1))
                                                                                          (let
                                                                                             ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                             (=>
                                                                                                (not cmp5$2_0)
                                                                                                (let
                                                                                                   ((retval.0$2_0 y.0$2_0))
                                                                                                   (let
                                                                                                      ((result$2 retval.0$2_0))
                                                                                                      (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp5$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.1$2_0 pc.1$2_0_old))
                                                         (let
                                                            ((v.0$2_0 v.0$2_0_old)
                                                             (y.0$2_0 y.0$2_0_old)
                                                             (cmp7$2_0 (< call$2_0 max$2_0))
                                                             (cmp8$2_0 (= pc.1$2_0 0)))
                                                            (let
                                                               ((or.cond44$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp8$2_0))
                                                                (cmp10$2_0 (= v.0$2_0 0)))
                                                               (let
                                                                  ((or.cond45$2_0 (and
                                                                                      or.cond44$2_0
                                                                                      cmp10$2_0)))
                                                                  (=>
                                                                     (not or.cond45$2_0)
                                                                     (let
                                                                        ((cmp17$2_0 (= v.0$2_0 0))
                                                                         (cmp19$2_0 (= pc.1$2_0 1)))
                                                                        (let
                                                                           ((or.cond47$2_0 (and
                                                                                               cmp17$2_0
                                                                                               cmp19$2_0))
                                                                            (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                           (let
                                                                              ((or.cond48$2_0 (and
                                                                                                  or.cond47$2_0
                                                                                                  cmp21$2_0)))
                                                                              (=>
                                                                                 (not or.cond48$2_0)
                                                                                 (let
                                                                                    ((cmp28$2_0 (= v.0$2_0 1))
                                                                                     (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                    (let
                                                                                       ((or.cond50$2_0 (and
                                                                                                           cmp28$2_0
                                                                                                           cmp30$2_0))
                                                                                        (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                       (let
                                                                                          ((or.cond51$2_0 (and
                                                                                                              or.cond50$2_0
                                                                                                              cmp32$2_0)))
                                                                                          (=>
                                                                                             or.cond51$2_0
                                                                                             (let
                                                                                                ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                (let
                                                                                                   ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                    (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                   (let
                                                                                                      ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                      (let
                                                                                                         ((pc.1$2_0 .52$2_0)
                                                                                                          (i.0$2_0 inc34$2_0)
                                                                                                          (y.0$2_0 add35$2_0)
                                                                                                          (v.0$2_0 v.0$2_0))
                                                                                                         (let
                                                                                                            ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                            (=>
                                                                                                               (not cmp5$2_0)
                                                                                                               (let
                                                                                                                  ((retval.0$2_0 y.0$2_0))
                                                                                                                  (let
                                                                                                                     ((result$2 retval.0$2_0))
                                                                                                                     (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp5$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.1$2_0 pc.1$2_0_old))
                                                         (let
                                                            ((v.0$2_0 v.0$2_0_old)
                                                             (y.0$2_0 y.0$2_0_old)
                                                             (cmp7$2_0 (< call$2_0 max$2_0))
                                                             (cmp8$2_0 (= pc.1$2_0 0)))
                                                            (let
                                                               ((or.cond44$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp8$2_0))
                                                                (cmp10$2_0 (= v.0$2_0 0)))
                                                               (let
                                                                  ((or.cond45$2_0 (and
                                                                                      or.cond44$2_0
                                                                                      cmp10$2_0)))
                                                                  (=>
                                                                     (not or.cond45$2_0)
                                                                     (let
                                                                        ((cmp17$2_0 (= v.0$2_0 0))
                                                                         (cmp19$2_0 (= pc.1$2_0 1)))
                                                                        (let
                                                                           ((or.cond47$2_0 (and
                                                                                               cmp17$2_0
                                                                                               cmp19$2_0))
                                                                            (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                           (let
                                                                              ((or.cond48$2_0 (and
                                                                                                  or.cond47$2_0
                                                                                                  cmp21$2_0)))
                                                                              (=>
                                                                                 (not or.cond48$2_0)
                                                                                 (let
                                                                                    ((cmp28$2_0 (= v.0$2_0 1))
                                                                                     (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                    (let
                                                                                       ((or.cond50$2_0 (and
                                                                                                           cmp28$2_0
                                                                                                           cmp30$2_0))
                                                                                        (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                       (let
                                                                                          ((or.cond51$2_0 (and
                                                                                                              or.cond50$2_0
                                                                                                              cmp32$2_0)))
                                                                                          (=>
                                                                                             (not or.cond51$2_0)
                                                                                             (let
                                                                                                ((pc.1$2_0 pc.1$2_0)
                                                                                                 (i.0$2_0 i.0$2_0)
                                                                                                 (y.0$2_0 y.0$2_0)
                                                                                                 (v.0$2_0 v.0$2_0))
                                                                                                (let
                                                                                                   ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                   (=>
                                                                                                      (not cmp5$2_0)
                                                                                                      (let
                                                                                                         ((retval.0$2_0 y.0$2_0))
                                                                                                         (let
                                                                                                            ((result$2 retval.0$2_0))
                                                                                                            (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp5$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0)
                                                                         (call$2_0 call$2_0_old)
                                                                         (i.0$2_0 i.0$2_0_old)
                                                                         (max$2_0 max$2_0_old)
                                                                         (pc.1$2_0 pc.1$2_0_old))
                                                                        (let
                                                                           ((v.0$2_0 v.0$2_0_old)
                                                                            (y.0$2_0 y.0$2_0_old)
                                                                            (cmp7$2_0 (< call$2_0 max$2_0))
                                                                            (cmp8$2_0 (= pc.1$2_0 0)))
                                                                           (let
                                                                              ((or.cond44$2_0 (and
                                                                                                  cmp7$2_0
                                                                                                  cmp8$2_0))
                                                                               (cmp10$2_0 (= v.0$2_0 0)))
                                                                              (let
                                                                                 ((or.cond45$2_0 (and
                                                                                                     or.cond44$2_0
                                                                                                     cmp10$2_0)))
                                                                                 (=>
                                                                                    or.cond45$2_0
                                                                                    (let
                                                                                       ((inc$2_0 (+ i.0$2_0 1)))
                                                                                       (let
                                                                                          ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                                          (let
                                                                                             ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                              (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                             (let
                                                                                                ((pc.1$2_0 .46$2_0)
                                                                                                 (i.0$2_0 inc$2_0)
                                                                                                 (y.0$2_0 add$2_0)
                                                                                                 (v.0$2_0 v.0$2_0))
                                                                                                (let
                                                                                                   ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                   (=>
                                                                                                      (not cmp5$2_0)
                                                                                                      (let
                                                                                                         ((retval.0$2_0 y.0$2_0))
                                                                                                         (let
                                                                                                            ((result$2 retval.0$2_0))
                                                                                                            (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp5$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0)
                                                                         (call$2_0 call$2_0_old)
                                                                         (i.0$2_0 i.0$2_0_old)
                                                                         (max$2_0 max$2_0_old)
                                                                         (pc.1$2_0 pc.1$2_0_old))
                                                                        (let
                                                                           ((v.0$2_0 v.0$2_0_old)
                                                                            (y.0$2_0 y.0$2_0_old)
                                                                            (cmp7$2_0 (< call$2_0 max$2_0))
                                                                            (cmp8$2_0 (= pc.1$2_0 0)))
                                                                           (let
                                                                              ((or.cond44$2_0 (and
                                                                                                  cmp7$2_0
                                                                                                  cmp8$2_0))
                                                                               (cmp10$2_0 (= v.0$2_0 0)))
                                                                              (let
                                                                                 ((or.cond45$2_0 (and
                                                                                                     or.cond44$2_0
                                                                                                     cmp10$2_0)))
                                                                                 (=>
                                                                                    (not or.cond45$2_0)
                                                                                    (let
                                                                                       ((cmp17$2_0 (= v.0$2_0 0))
                                                                                        (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                       (let
                                                                                          ((or.cond47$2_0 (and
                                                                                                              cmp17$2_0
                                                                                                              cmp19$2_0))
                                                                                           (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                          (let
                                                                                             ((or.cond48$2_0 (and
                                                                                                                 or.cond47$2_0
                                                                                                                 cmp21$2_0)))
                                                                                             (=>
                                                                                                or.cond48$2_0
                                                                                                (let
                                                                                                   ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                                   (let
                                                                                                      ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                                      (let
                                                                                                         ((pc.1$2_0 .49$2_0)
                                                                                                          (i.0$2_0 i.0$2_0)
                                                                                                          (y.0$2_0 y.0$2_0)
                                                                                                          (v.0$2_0 1))
                                                                                                         (let
                                                                                                            ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                            (=>
                                                                                                               (not cmp5$2_0)
                                                                                                               (let
                                                                                                                  ((retval.0$2_0 y.0$2_0))
                                                                                                                  (let
                                                                                                                     ((result$2 retval.0$2_0))
                                                                                                                     (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp5$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0)
                                                                         (call$2_0 call$2_0_old)
                                                                         (i.0$2_0 i.0$2_0_old)
                                                                         (max$2_0 max$2_0_old)
                                                                         (pc.1$2_0 pc.1$2_0_old))
                                                                        (let
                                                                           ((v.0$2_0 v.0$2_0_old)
                                                                            (y.0$2_0 y.0$2_0_old)
                                                                            (cmp7$2_0 (< call$2_0 max$2_0))
                                                                            (cmp8$2_0 (= pc.1$2_0 0)))
                                                                           (let
                                                                              ((or.cond44$2_0 (and
                                                                                                  cmp7$2_0
                                                                                                  cmp8$2_0))
                                                                               (cmp10$2_0 (= v.0$2_0 0)))
                                                                              (let
                                                                                 ((or.cond45$2_0 (and
                                                                                                     or.cond44$2_0
                                                                                                     cmp10$2_0)))
                                                                                 (=>
                                                                                    (not or.cond45$2_0)
                                                                                    (let
                                                                                       ((cmp17$2_0 (= v.0$2_0 0))
                                                                                        (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                       (let
                                                                                          ((or.cond47$2_0 (and
                                                                                                              cmp17$2_0
                                                                                                              cmp19$2_0))
                                                                                           (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                          (let
                                                                                             ((or.cond48$2_0 (and
                                                                                                                 or.cond47$2_0
                                                                                                                 cmp21$2_0)))
                                                                                             (=>
                                                                                                (not or.cond48$2_0)
                                                                                                (let
                                                                                                   ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                    (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                   (let
                                                                                                      ((or.cond50$2_0 (and
                                                                                                                          cmp28$2_0
                                                                                                                          cmp30$2_0))
                                                                                                       (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                      (let
                                                                                                         ((or.cond51$2_0 (and
                                                                                                                             or.cond50$2_0
                                                                                                                             cmp32$2_0)))
                                                                                                         (=>
                                                                                                            or.cond51$2_0
                                                                                                            (let
                                                                                                               ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                               (let
                                                                                                                  ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                                   (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                                  (let
                                                                                                                     ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                                     (let
                                                                                                                        ((pc.1$2_0 .52$2_0)
                                                                                                                         (i.0$2_0 inc34$2_0)
                                                                                                                         (y.0$2_0 add35$2_0)
                                                                                                                         (v.0$2_0 v.0$2_0))
                                                                                                                        (let
                                                                                                                           ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                           (=>
                                                                                                                              (not cmp5$2_0)
                                                                                                                              (let
                                                                                                                                 ((retval.0$2_0 y.0$2_0))
                                                                                                                                 (let
                                                                                                                                    ((result$2 retval.0$2_0))
                                                                                                                                    (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp5$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0)
                                                                         (call$2_0 call$2_0_old)
                                                                         (i.0$2_0 i.0$2_0_old)
                                                                         (max$2_0 max$2_0_old)
                                                                         (pc.1$2_0 pc.1$2_0_old))
                                                                        (let
                                                                           ((v.0$2_0 v.0$2_0_old)
                                                                            (y.0$2_0 y.0$2_0_old)
                                                                            (cmp7$2_0 (< call$2_0 max$2_0))
                                                                            (cmp8$2_0 (= pc.1$2_0 0)))
                                                                           (let
                                                                              ((or.cond44$2_0 (and
                                                                                                  cmp7$2_0
                                                                                                  cmp8$2_0))
                                                                               (cmp10$2_0 (= v.0$2_0 0)))
                                                                              (let
                                                                                 ((or.cond45$2_0 (and
                                                                                                     or.cond44$2_0
                                                                                                     cmp10$2_0)))
                                                                                 (=>
                                                                                    (not or.cond45$2_0)
                                                                                    (let
                                                                                       ((cmp17$2_0 (= v.0$2_0 0))
                                                                                        (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                       (let
                                                                                          ((or.cond47$2_0 (and
                                                                                                              cmp17$2_0
                                                                                                              cmp19$2_0))
                                                                                           (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                          (let
                                                                                             ((or.cond48$2_0 (and
                                                                                                                 or.cond47$2_0
                                                                                                                 cmp21$2_0)))
                                                                                             (=>
                                                                                                (not or.cond48$2_0)
                                                                                                (let
                                                                                                   ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                    (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                   (let
                                                                                                      ((or.cond50$2_0 (and
                                                                                                                          cmp28$2_0
                                                                                                                          cmp30$2_0))
                                                                                                       (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                      (let
                                                                                                         ((or.cond51$2_0 (and
                                                                                                                             or.cond50$2_0
                                                                                                                             cmp32$2_0)))
                                                                                                         (=>
                                                                                                            (not or.cond51$2_0)
                                                                                                            (let
                                                                                                               ((pc.1$2_0 pc.1$2_0)
                                                                                                                (i.0$2_0 i.0$2_0)
                                                                                                                (y.0$2_0 y.0$2_0)
                                                                                                                (v.0$2_0 v.0$2_0))
                                                                                                               (let
                                                                                                                  ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                  (=>
                                                                                                                     (not cmp5$2_0)
                                                                                                                     (let
                                                                                                                        ((retval.0$2_0 y.0$2_0))
                                                                                                                        (let
                                                                                                                           ((result$2 retval.0$2_0))
                                                                                                                           (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         (not cmp5$1_0)
                                                         (let
                                                            ((retval.0$1_0 y.0$1_0))
                                                            (let
                                                               ((result$1 retval.0$1_0)
                                                                (call$2_0 call$2_0_old)
                                                                (i.0$2_0 i.0$2_0_old)
                                                                (max$2_0 max$2_0_old)
                                                                (pc.1$2_0 pc.1$2_0_old))
                                                               (let
                                                                  ((v.0$2_0 v.0$2_0_old)
                                                                   (y.0$2_0 y.0$2_0_old)
                                                                   (cmp7$2_0 (< call$2_0 max$2_0))
                                                                   (cmp8$2_0 (= pc.1$2_0 0)))
                                                                  (let
                                                                     ((or.cond44$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp8$2_0))
                                                                      (cmp10$2_0 (= v.0$2_0 0)))
                                                                     (let
                                                                        ((or.cond45$2_0 (and
                                                                                            or.cond44$2_0
                                                                                            cmp10$2_0)))
                                                                        (=>
                                                                           or.cond45$2_0
                                                                           (let
                                                                              ((inc$2_0 (+ i.0$2_0 1)))
                                                                              (let
                                                                                 ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                                 (let
                                                                                    ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                     (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                    (let
                                                                                       ((pc.1$2_0 .46$2_0)
                                                                                        (i.0$2_0 inc$2_0)
                                                                                        (y.0$2_0 add$2_0)
                                                                                        (v.0$2_0 v.0$2_0))
                                                                                       (let
                                                                                          ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                          (=>
                                                                                             (not cmp5$2_0)
                                                                                             (let
                                                                                                ((retval.0$2_0 y.0$2_0))
                                                                                                (let
                                                                                                   ((result$2 retval.0$2_0))
                                                                                                   (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         (not cmp5$1_0)
                                                         (let
                                                            ((retval.0$1_0 y.0$1_0))
                                                            (let
                                                               ((result$1 retval.0$1_0)
                                                                (call$2_0 call$2_0_old)
                                                                (i.0$2_0 i.0$2_0_old)
                                                                (max$2_0 max$2_0_old)
                                                                (pc.1$2_0 pc.1$2_0_old))
                                                               (let
                                                                  ((v.0$2_0 v.0$2_0_old)
                                                                   (y.0$2_0 y.0$2_0_old)
                                                                   (cmp7$2_0 (< call$2_0 max$2_0))
                                                                   (cmp8$2_0 (= pc.1$2_0 0)))
                                                                  (let
                                                                     ((or.cond44$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp8$2_0))
                                                                      (cmp10$2_0 (= v.0$2_0 0)))
                                                                     (let
                                                                        ((or.cond45$2_0 (and
                                                                                            or.cond44$2_0
                                                                                            cmp10$2_0)))
                                                                        (=>
                                                                           (not or.cond45$2_0)
                                                                           (let
                                                                              ((cmp17$2_0 (= v.0$2_0 0))
                                                                               (cmp19$2_0 (= pc.1$2_0 1)))
                                                                              (let
                                                                                 ((or.cond47$2_0 (and
                                                                                                     cmp17$2_0
                                                                                                     cmp19$2_0))
                                                                                  (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                 (let
                                                                                    ((or.cond48$2_0 (and
                                                                                                        or.cond47$2_0
                                                                                                        cmp21$2_0)))
                                                                                    (=>
                                                                                       or.cond48$2_0
                                                                                       (let
                                                                                          ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                          (let
                                                                                             ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                             (let
                                                                                                ((pc.1$2_0 .49$2_0)
                                                                                                 (i.0$2_0 i.0$2_0)
                                                                                                 (y.0$2_0 y.0$2_0)
                                                                                                 (v.0$2_0 1))
                                                                                                (let
                                                                                                   ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                   (=>
                                                                                                      (not cmp5$2_0)
                                                                                                      (let
                                                                                                         ((retval.0$2_0 y.0$2_0))
                                                                                                         (let
                                                                                                            ((result$2 retval.0$2_0))
                                                                                                            (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         (not cmp5$1_0)
                                                         (let
                                                            ((retval.0$1_0 y.0$1_0))
                                                            (let
                                                               ((result$1 retval.0$1_0)
                                                                (call$2_0 call$2_0_old)
                                                                (i.0$2_0 i.0$2_0_old)
                                                                (max$2_0 max$2_0_old)
                                                                (pc.1$2_0 pc.1$2_0_old))
                                                               (let
                                                                  ((v.0$2_0 v.0$2_0_old)
                                                                   (y.0$2_0 y.0$2_0_old)
                                                                   (cmp7$2_0 (< call$2_0 max$2_0))
                                                                   (cmp8$2_0 (= pc.1$2_0 0)))
                                                                  (let
                                                                     ((or.cond44$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp8$2_0))
                                                                      (cmp10$2_0 (= v.0$2_0 0)))
                                                                     (let
                                                                        ((or.cond45$2_0 (and
                                                                                            or.cond44$2_0
                                                                                            cmp10$2_0)))
                                                                        (=>
                                                                           (not or.cond45$2_0)
                                                                           (let
                                                                              ((cmp17$2_0 (= v.0$2_0 0))
                                                                               (cmp19$2_0 (= pc.1$2_0 1)))
                                                                              (let
                                                                                 ((or.cond47$2_0 (and
                                                                                                     cmp17$2_0
                                                                                                     cmp19$2_0))
                                                                                  (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                 (let
                                                                                    ((or.cond48$2_0 (and
                                                                                                        or.cond47$2_0
                                                                                                        cmp21$2_0)))
                                                                                    (=>
                                                                                       (not or.cond48$2_0)
                                                                                       (let
                                                                                          ((cmp28$2_0 (= v.0$2_0 1))
                                                                                           (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                          (let
                                                                                             ((or.cond50$2_0 (and
                                                                                                                 cmp28$2_0
                                                                                                                 cmp30$2_0))
                                                                                              (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                             (let
                                                                                                ((or.cond51$2_0 (and
                                                                                                                    or.cond50$2_0
                                                                                                                    cmp32$2_0)))
                                                                                                (=>
                                                                                                   or.cond51$2_0
                                                                                                   (let
                                                                                                      ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                      (let
                                                                                                         ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                          (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                         (let
                                                                                                            ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                            (let
                                                                                                               ((pc.1$2_0 .52$2_0)
                                                                                                                (i.0$2_0 inc34$2_0)
                                                                                                                (y.0$2_0 add35$2_0)
                                                                                                                (v.0$2_0 v.0$2_0))
                                                                                                               (let
                                                                                                                  ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                  (=>
                                                                                                                     (not cmp5$2_0)
                                                                                                                     (let
                                                                                                                        ((retval.0$2_0 y.0$2_0))
                                                                                                                        (let
                                                                                                                           ((result$2 retval.0$2_0))
                                                                                                                           (OUT_INV result$1 result$2))))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         (not cmp5$1_0)
                                                         (let
                                                            ((retval.0$1_0 y.0$1_0))
                                                            (let
                                                               ((result$1 retval.0$1_0)
                                                                (call$2_0 call$2_0_old)
                                                                (i.0$2_0 i.0$2_0_old)
                                                                (max$2_0 max$2_0_old)
                                                                (pc.1$2_0 pc.1$2_0_old))
                                                               (let
                                                                  ((v.0$2_0 v.0$2_0_old)
                                                                   (y.0$2_0 y.0$2_0_old)
                                                                   (cmp7$2_0 (< call$2_0 max$2_0))
                                                                   (cmp8$2_0 (= pc.1$2_0 0)))
                                                                  (let
                                                                     ((or.cond44$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp8$2_0))
                                                                      (cmp10$2_0 (= v.0$2_0 0)))
                                                                     (let
                                                                        ((or.cond45$2_0 (and
                                                                                            or.cond44$2_0
                                                                                            cmp10$2_0)))
                                                                        (=>
                                                                           (not or.cond45$2_0)
                                                                           (let
                                                                              ((cmp17$2_0 (= v.0$2_0 0))
                                                                               (cmp19$2_0 (= pc.1$2_0 1)))
                                                                              (let
                                                                                 ((or.cond47$2_0 (and
                                                                                                     cmp17$2_0
                                                                                                     cmp19$2_0))
                                                                                  (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                 (let
                                                                                    ((or.cond48$2_0 (and
                                                                                                        or.cond47$2_0
                                                                                                        cmp21$2_0)))
                                                                                    (=>
                                                                                       (not or.cond48$2_0)
                                                                                       (let
                                                                                          ((cmp28$2_0 (= v.0$2_0 1))
                                                                                           (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                          (let
                                                                                             ((or.cond50$2_0 (and
                                                                                                                 cmp28$2_0
                                                                                                                 cmp30$2_0))
                                                                                              (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                             (let
                                                                                                ((or.cond51$2_0 (and
                                                                                                                    or.cond50$2_0
                                                                                                                    cmp32$2_0)))
                                                                                                (=>
                                                                                                   (not or.cond51$2_0)
                                                                                                   (let
                                                                                                      ((pc.1$2_0 pc.1$2_0)
                                                                                                       (i.0$2_0 i.0$2_0)
                                                                                                       (y.0$2_0 y.0$2_0)
                                                                                                       (v.0$2_0 v.0$2_0))
                                                                                                      (let
                                                                                                         ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                         (=>
                                                                                                            (not cmp5$2_0)
                                                                                                            (let
                                                                                                               ((retval.0$2_0 y.0$2_0))
                                                                                                               (let
                                                                                                                  ((result$2 retval.0$2_0))
                                                                                                                  (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          cmp5$1_0
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.1$2_0 pc.1$2_0_old))
                                             (let
                                                ((v.0$2_0 v.0$2_0_old)
                                                 (y.0$2_0 y.0$2_0_old)
                                                 (cmp7$2_0 (< call$2_0 max$2_0))
                                                 (cmp8$2_0 (= pc.1$2_0 0)))
                                                (let
                                                   ((or.cond44$2_0 (and
                                                                       cmp7$2_0
                                                                       cmp8$2_0))
                                                    (cmp10$2_0 (= v.0$2_0 0)))
                                                   (let
                                                      ((or.cond45$2_0 (and
                                                                          or.cond44$2_0
                                                                          cmp10$2_0)))
                                                      (=>
                                                         or.cond45$2_0
                                                         (let
                                                            ((inc$2_0 (+ i.0$2_0 1)))
                                                            (let
                                                               ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                               (let
                                                                  ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                   (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                  (let
                                                                     ((pc.1$2_0 .46$2_0)
                                                                      (i.0$2_0 inc$2_0)
                                                                      (y.0$2_0 add$2_0)
                                                                      (v.0$2_0 v.0$2_0))
                                                                     (let
                                                                        ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                        (=>
                                                                           cmp5$2_0
                                                                           (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          cmp5$1_0
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.1$2_0 pc.1$2_0_old))
                                             (let
                                                ((v.0$2_0 v.0$2_0_old)
                                                 (y.0$2_0 y.0$2_0_old)
                                                 (cmp7$2_0 (< call$2_0 max$2_0))
                                                 (cmp8$2_0 (= pc.1$2_0 0)))
                                                (let
                                                   ((or.cond44$2_0 (and
                                                                       cmp7$2_0
                                                                       cmp8$2_0))
                                                    (cmp10$2_0 (= v.0$2_0 0)))
                                                   (let
                                                      ((or.cond45$2_0 (and
                                                                          or.cond44$2_0
                                                                          cmp10$2_0)))
                                                      (=>
                                                         (not or.cond45$2_0)
                                                         (let
                                                            ((cmp17$2_0 (= v.0$2_0 0))
                                                             (cmp19$2_0 (= pc.1$2_0 1)))
                                                            (let
                                                               ((or.cond47$2_0 (and
                                                                                   cmp17$2_0
                                                                                   cmp19$2_0))
                                                                (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond48$2_0 (and
                                                                                      or.cond47$2_0
                                                                                      cmp21$2_0)))
                                                                  (=>
                                                                     or.cond48$2_0
                                                                     (let
                                                                        ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                        (let
                                                                           ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                           (let
                                                                              ((pc.1$2_0 .49$2_0)
                                                                               (i.0$2_0 i.0$2_0)
                                                                               (y.0$2_0 y.0$2_0)
                                                                               (v.0$2_0 1))
                                                                              (let
                                                                                 ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                 (=>
                                                                                    cmp5$2_0
                                                                                    (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          cmp5$1_0
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.1$2_0 pc.1$2_0_old))
                                             (let
                                                ((v.0$2_0 v.0$2_0_old)
                                                 (y.0$2_0 y.0$2_0_old)
                                                 (cmp7$2_0 (< call$2_0 max$2_0))
                                                 (cmp8$2_0 (= pc.1$2_0 0)))
                                                (let
                                                   ((or.cond44$2_0 (and
                                                                       cmp7$2_0
                                                                       cmp8$2_0))
                                                    (cmp10$2_0 (= v.0$2_0 0)))
                                                   (let
                                                      ((or.cond45$2_0 (and
                                                                          or.cond44$2_0
                                                                          cmp10$2_0)))
                                                      (=>
                                                         (not or.cond45$2_0)
                                                         (let
                                                            ((cmp17$2_0 (= v.0$2_0 0))
                                                             (cmp19$2_0 (= pc.1$2_0 1)))
                                                            (let
                                                               ((or.cond47$2_0 (and
                                                                                   cmp17$2_0
                                                                                   cmp19$2_0))
                                                                (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond48$2_0 (and
                                                                                      or.cond47$2_0
                                                                                      cmp21$2_0)))
                                                                  (=>
                                                                     (not or.cond48$2_0)
                                                                     (let
                                                                        ((cmp28$2_0 (= v.0$2_0 1))
                                                                         (cmp30$2_0 (= pc.1$2_0 2)))
                                                                        (let
                                                                           ((or.cond50$2_0 (and
                                                                                               cmp28$2_0
                                                                                               cmp30$2_0))
                                                                            (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                           (let
                                                                              ((or.cond51$2_0 (and
                                                                                                  or.cond50$2_0
                                                                                                  cmp32$2_0)))
                                                                              (=>
                                                                                 or.cond51$2_0
                                                                                 (let
                                                                                    ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                    (let
                                                                                       ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                        (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                       (let
                                                                                          ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                          (let
                                                                                             ((pc.1$2_0 .52$2_0)
                                                                                              (i.0$2_0 inc34$2_0)
                                                                                              (y.0$2_0 add35$2_0)
                                                                                              (v.0$2_0 v.0$2_0))
                                                                                             (let
                                                                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                (=>
                                                                                                   cmp5$2_0
                                                                                                   (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          cmp5$1_0
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.1$2_0 pc.1$2_0_old))
                                             (let
                                                ((v.0$2_0 v.0$2_0_old)
                                                 (y.0$2_0 y.0$2_0_old)
                                                 (cmp7$2_0 (< call$2_0 max$2_0))
                                                 (cmp8$2_0 (= pc.1$2_0 0)))
                                                (let
                                                   ((or.cond44$2_0 (and
                                                                       cmp7$2_0
                                                                       cmp8$2_0))
                                                    (cmp10$2_0 (= v.0$2_0 0)))
                                                   (let
                                                      ((or.cond45$2_0 (and
                                                                          or.cond44$2_0
                                                                          cmp10$2_0)))
                                                      (=>
                                                         (not or.cond45$2_0)
                                                         (let
                                                            ((cmp17$2_0 (= v.0$2_0 0))
                                                             (cmp19$2_0 (= pc.1$2_0 1)))
                                                            (let
                                                               ((or.cond47$2_0 (and
                                                                                   cmp17$2_0
                                                                                   cmp19$2_0))
                                                                (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond48$2_0 (and
                                                                                      or.cond47$2_0
                                                                                      cmp21$2_0)))
                                                                  (=>
                                                                     (not or.cond48$2_0)
                                                                     (let
                                                                        ((cmp28$2_0 (= v.0$2_0 1))
                                                                         (cmp30$2_0 (= pc.1$2_0 2)))
                                                                        (let
                                                                           ((or.cond50$2_0 (and
                                                                                               cmp28$2_0
                                                                                               cmp30$2_0))
                                                                            (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                           (let
                                                                              ((or.cond51$2_0 (and
                                                                                                  or.cond50$2_0
                                                                                                  cmp32$2_0)))
                                                                              (=>
                                                                                 (not or.cond51$2_0)
                                                                                 (let
                                                                                    ((pc.1$2_0 pc.1$2_0)
                                                                                     (i.0$2_0 i.0$2_0)
                                                                                     (y.0$2_0 y.0$2_0)
                                                                                     (v.0$2_0 v.0$2_0))
                                                                                    (let
                                                                                       ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                       (=>
                                                                                          cmp5$2_0
                                                                                          (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp5$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.1$2_0 pc.1$2_0_old))
                                                      (let
                                                         ((v.0$2_0 v.0$2_0_old)
                                                          (y.0$2_0 y.0$2_0_old)
                                                          (cmp7$2_0 (< call$2_0 max$2_0))
                                                          (cmp8$2_0 (= pc.1$2_0 0)))
                                                         (let
                                                            ((or.cond44$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp8$2_0))
                                                             (cmp10$2_0 (= v.0$2_0 0)))
                                                            (let
                                                               ((or.cond45$2_0 (and
                                                                                   or.cond44$2_0
                                                                                   cmp10$2_0)))
                                                               (=>
                                                                  or.cond45$2_0
                                                                  (let
                                                                     ((inc$2_0 (+ i.0$2_0 1)))
                                                                     (let
                                                                        ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                        (let
                                                                           ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                            (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                           (let
                                                                              ((pc.1$2_0 .46$2_0)
                                                                               (i.0$2_0 inc$2_0)
                                                                               (y.0$2_0 add$2_0)
                                                                               (v.0$2_0 v.0$2_0))
                                                                              (let
                                                                                 ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                 (=>
                                                                                    cmp5$2_0
                                                                                    (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp5$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.1$2_0 pc.1$2_0_old))
                                                      (let
                                                         ((v.0$2_0 v.0$2_0_old)
                                                          (y.0$2_0 y.0$2_0_old)
                                                          (cmp7$2_0 (< call$2_0 max$2_0))
                                                          (cmp8$2_0 (= pc.1$2_0 0)))
                                                         (let
                                                            ((or.cond44$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp8$2_0))
                                                             (cmp10$2_0 (= v.0$2_0 0)))
                                                            (let
                                                               ((or.cond45$2_0 (and
                                                                                   or.cond44$2_0
                                                                                   cmp10$2_0)))
                                                               (=>
                                                                  (not or.cond45$2_0)
                                                                  (let
                                                                     ((cmp17$2_0 (= v.0$2_0 0))
                                                                      (cmp19$2_0 (= pc.1$2_0 1)))
                                                                     (let
                                                                        ((or.cond47$2_0 (and
                                                                                            cmp17$2_0
                                                                                            cmp19$2_0))
                                                                         (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                        (let
                                                                           ((or.cond48$2_0 (and
                                                                                               or.cond47$2_0
                                                                                               cmp21$2_0)))
                                                                           (=>
                                                                              or.cond48$2_0
                                                                              (let
                                                                                 ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                 (let
                                                                                    ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                    (let
                                                                                       ((pc.1$2_0 .49$2_0)
                                                                                        (i.0$2_0 i.0$2_0)
                                                                                        (y.0$2_0 y.0$2_0)
                                                                                        (v.0$2_0 1))
                                                                                       (let
                                                                                          ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                          (=>
                                                                                             cmp5$2_0
                                                                                             (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp5$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.1$2_0 pc.1$2_0_old))
                                                      (let
                                                         ((v.0$2_0 v.0$2_0_old)
                                                          (y.0$2_0 y.0$2_0_old)
                                                          (cmp7$2_0 (< call$2_0 max$2_0))
                                                          (cmp8$2_0 (= pc.1$2_0 0)))
                                                         (let
                                                            ((or.cond44$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp8$2_0))
                                                             (cmp10$2_0 (= v.0$2_0 0)))
                                                            (let
                                                               ((or.cond45$2_0 (and
                                                                                   or.cond44$2_0
                                                                                   cmp10$2_0)))
                                                               (=>
                                                                  (not or.cond45$2_0)
                                                                  (let
                                                                     ((cmp17$2_0 (= v.0$2_0 0))
                                                                      (cmp19$2_0 (= pc.1$2_0 1)))
                                                                     (let
                                                                        ((or.cond47$2_0 (and
                                                                                            cmp17$2_0
                                                                                            cmp19$2_0))
                                                                         (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                        (let
                                                                           ((or.cond48$2_0 (and
                                                                                               or.cond47$2_0
                                                                                               cmp21$2_0)))
                                                                           (=>
                                                                              (not or.cond48$2_0)
                                                                              (let
                                                                                 ((cmp28$2_0 (= v.0$2_0 1))
                                                                                  (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                 (let
                                                                                    ((or.cond50$2_0 (and
                                                                                                        cmp28$2_0
                                                                                                        cmp30$2_0))
                                                                                     (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                    (let
                                                                                       ((or.cond51$2_0 (and
                                                                                                           or.cond50$2_0
                                                                                                           cmp32$2_0)))
                                                                                       (=>
                                                                                          or.cond51$2_0
                                                                                          (let
                                                                                             ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                             (let
                                                                                                ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                 (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                (let
                                                                                                   ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                   (let
                                                                                                      ((pc.1$2_0 .52$2_0)
                                                                                                       (i.0$2_0 inc34$2_0)
                                                                                                       (y.0$2_0 add35$2_0)
                                                                                                       (v.0$2_0 v.0$2_0))
                                                                                                      (let
                                                                                                         ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                         (=>
                                                                                                            cmp5$2_0
                                                                                                            (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp5$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.1$2_0 pc.1$2_0_old))
                                                      (let
                                                         ((v.0$2_0 v.0$2_0_old)
                                                          (y.0$2_0 y.0$2_0_old)
                                                          (cmp7$2_0 (< call$2_0 max$2_0))
                                                          (cmp8$2_0 (= pc.1$2_0 0)))
                                                         (let
                                                            ((or.cond44$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp8$2_0))
                                                             (cmp10$2_0 (= v.0$2_0 0)))
                                                            (let
                                                               ((or.cond45$2_0 (and
                                                                                   or.cond44$2_0
                                                                                   cmp10$2_0)))
                                                               (=>
                                                                  (not or.cond45$2_0)
                                                                  (let
                                                                     ((cmp17$2_0 (= v.0$2_0 0))
                                                                      (cmp19$2_0 (= pc.1$2_0 1)))
                                                                     (let
                                                                        ((or.cond47$2_0 (and
                                                                                            cmp17$2_0
                                                                                            cmp19$2_0))
                                                                         (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                        (let
                                                                           ((or.cond48$2_0 (and
                                                                                               or.cond47$2_0
                                                                                               cmp21$2_0)))
                                                                           (=>
                                                                              (not or.cond48$2_0)
                                                                              (let
                                                                                 ((cmp28$2_0 (= v.0$2_0 1))
                                                                                  (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                 (let
                                                                                    ((or.cond50$2_0 (and
                                                                                                        cmp28$2_0
                                                                                                        cmp30$2_0))
                                                                                     (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                    (let
                                                                                       ((or.cond51$2_0 (and
                                                                                                           or.cond50$2_0
                                                                                                           cmp32$2_0)))
                                                                                       (=>
                                                                                          (not or.cond51$2_0)
                                                                                          (let
                                                                                             ((pc.1$2_0 pc.1$2_0)
                                                                                              (i.0$2_0 i.0$2_0)
                                                                                              (y.0$2_0 y.0$2_0)
                                                                                              (v.0$2_0 v.0$2_0))
                                                                                             (let
                                                                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                (=>
                                                                                                   cmp5$2_0
                                                                                                   (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (let
                                                                     ((call$2_0 call$2_0_old)
                                                                      (i.0$2_0 i.0$2_0_old)
                                                                      (max$2_0 max$2_0_old)
                                                                      (pc.1$2_0 pc.1$2_0_old))
                                                                     (let
                                                                        ((v.0$2_0 v.0$2_0_old)
                                                                         (y.0$2_0 y.0$2_0_old)
                                                                         (cmp7$2_0 (< call$2_0 max$2_0))
                                                                         (cmp8$2_0 (= pc.1$2_0 0)))
                                                                        (let
                                                                           ((or.cond44$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp8$2_0))
                                                                            (cmp10$2_0 (= v.0$2_0 0)))
                                                                           (let
                                                                              ((or.cond45$2_0 (and
                                                                                                  or.cond44$2_0
                                                                                                  cmp10$2_0)))
                                                                              (=>
                                                                                 or.cond45$2_0
                                                                                 (let
                                                                                    ((inc$2_0 (+ i.0$2_0 1)))
                                                                                    (let
                                                                                       ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                                       (let
                                                                                          ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                           (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                          (let
                                                                                             ((pc.1$2_0 .46$2_0)
                                                                                              (i.0$2_0 inc$2_0)
                                                                                              (y.0$2_0 add$2_0)
                                                                                              (v.0$2_0 v.0$2_0))
                                                                                             (let
                                                                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                (=>
                                                                                                   cmp5$2_0
                                                                                                   (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (let
                                                                     ((call$2_0 call$2_0_old)
                                                                      (i.0$2_0 i.0$2_0_old)
                                                                      (max$2_0 max$2_0_old)
                                                                      (pc.1$2_0 pc.1$2_0_old))
                                                                     (let
                                                                        ((v.0$2_0 v.0$2_0_old)
                                                                         (y.0$2_0 y.0$2_0_old)
                                                                         (cmp7$2_0 (< call$2_0 max$2_0))
                                                                         (cmp8$2_0 (= pc.1$2_0 0)))
                                                                        (let
                                                                           ((or.cond44$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp8$2_0))
                                                                            (cmp10$2_0 (= v.0$2_0 0)))
                                                                           (let
                                                                              ((or.cond45$2_0 (and
                                                                                                  or.cond44$2_0
                                                                                                  cmp10$2_0)))
                                                                              (=>
                                                                                 (not or.cond45$2_0)
                                                                                 (let
                                                                                    ((cmp17$2_0 (= v.0$2_0 0))
                                                                                     (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                    (let
                                                                                       ((or.cond47$2_0 (and
                                                                                                           cmp17$2_0
                                                                                                           cmp19$2_0))
                                                                                        (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                       (let
                                                                                          ((or.cond48$2_0 (and
                                                                                                              or.cond47$2_0
                                                                                                              cmp21$2_0)))
                                                                                          (=>
                                                                                             or.cond48$2_0
                                                                                             (let
                                                                                                ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                                (let
                                                                                                   ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                                   (let
                                                                                                      ((pc.1$2_0 .49$2_0)
                                                                                                       (i.0$2_0 i.0$2_0)
                                                                                                       (y.0$2_0 y.0$2_0)
                                                                                                       (v.0$2_0 1))
                                                                                                      (let
                                                                                                         ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                         (=>
                                                                                                            cmp5$2_0
                                                                                                            (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (let
                                                                     ((call$2_0 call$2_0_old)
                                                                      (i.0$2_0 i.0$2_0_old)
                                                                      (max$2_0 max$2_0_old)
                                                                      (pc.1$2_0 pc.1$2_0_old))
                                                                     (let
                                                                        ((v.0$2_0 v.0$2_0_old)
                                                                         (y.0$2_0 y.0$2_0_old)
                                                                         (cmp7$2_0 (< call$2_0 max$2_0))
                                                                         (cmp8$2_0 (= pc.1$2_0 0)))
                                                                        (let
                                                                           ((or.cond44$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp8$2_0))
                                                                            (cmp10$2_0 (= v.0$2_0 0)))
                                                                           (let
                                                                              ((or.cond45$2_0 (and
                                                                                                  or.cond44$2_0
                                                                                                  cmp10$2_0)))
                                                                              (=>
                                                                                 (not or.cond45$2_0)
                                                                                 (let
                                                                                    ((cmp17$2_0 (= v.0$2_0 0))
                                                                                     (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                    (let
                                                                                       ((or.cond47$2_0 (and
                                                                                                           cmp17$2_0
                                                                                                           cmp19$2_0))
                                                                                        (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                       (let
                                                                                          ((or.cond48$2_0 (and
                                                                                                              or.cond47$2_0
                                                                                                              cmp21$2_0)))
                                                                                          (=>
                                                                                             (not or.cond48$2_0)
                                                                                             (let
                                                                                                ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                 (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                (let
                                                                                                   ((or.cond50$2_0 (and
                                                                                                                       cmp28$2_0
                                                                                                                       cmp30$2_0))
                                                                                                    (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                   (let
                                                                                                      ((or.cond51$2_0 (and
                                                                                                                          or.cond50$2_0
                                                                                                                          cmp32$2_0)))
                                                                                                      (=>
                                                                                                         or.cond51$2_0
                                                                                                         (let
                                                                                                            ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                            (let
                                                                                                               ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                                (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                               (let
                                                                                                                  ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                                  (let
                                                                                                                     ((pc.1$2_0 .52$2_0)
                                                                                                                      (i.0$2_0 inc34$2_0)
                                                                                                                      (y.0$2_0 add35$2_0)
                                                                                                                      (v.0$2_0 v.0$2_0))
                                                                                                                     (let
                                                                                                                        ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                        (=>
                                                                                                                           cmp5$2_0
                                                                                                                           (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (let
                                                                     ((call$2_0 call$2_0_old)
                                                                      (i.0$2_0 i.0$2_0_old)
                                                                      (max$2_0 max$2_0_old)
                                                                      (pc.1$2_0 pc.1$2_0_old))
                                                                     (let
                                                                        ((v.0$2_0 v.0$2_0_old)
                                                                         (y.0$2_0 y.0$2_0_old)
                                                                         (cmp7$2_0 (< call$2_0 max$2_0))
                                                                         (cmp8$2_0 (= pc.1$2_0 0)))
                                                                        (let
                                                                           ((or.cond44$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp8$2_0))
                                                                            (cmp10$2_0 (= v.0$2_0 0)))
                                                                           (let
                                                                              ((or.cond45$2_0 (and
                                                                                                  or.cond44$2_0
                                                                                                  cmp10$2_0)))
                                                                              (=>
                                                                                 (not or.cond45$2_0)
                                                                                 (let
                                                                                    ((cmp17$2_0 (= v.0$2_0 0))
                                                                                     (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                    (let
                                                                                       ((or.cond47$2_0 (and
                                                                                                           cmp17$2_0
                                                                                                           cmp19$2_0))
                                                                                        (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                       (let
                                                                                          ((or.cond48$2_0 (and
                                                                                                              or.cond47$2_0
                                                                                                              cmp21$2_0)))
                                                                                          (=>
                                                                                             (not or.cond48$2_0)
                                                                                             (let
                                                                                                ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                 (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                (let
                                                                                                   ((or.cond50$2_0 (and
                                                                                                                       cmp28$2_0
                                                                                                                       cmp30$2_0))
                                                                                                    (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                   (let
                                                                                                      ((or.cond51$2_0 (and
                                                                                                                          or.cond50$2_0
                                                                                                                          cmp32$2_0)))
                                                                                                      (=>
                                                                                                         (not or.cond51$2_0)
                                                                                                         (let
                                                                                                            ((pc.1$2_0 pc.1$2_0)
                                                                                                             (i.0$2_0 i.0$2_0)
                                                                                                             (y.0$2_0 y.0$2_0)
                                                                                                             (v.0$2_0 v.0$2_0))
                                                                                                            (let
                                                                                                               ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                               (=>
                                                                                                                  cmp5$2_0
                                                                                                                  (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         cmp5$1_0
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        or.cond45$2_0
                                                                        (let
                                                                           ((inc$2_0 (+ i.0$2_0 1)))
                                                                           (let
                                                                              ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                              (let
                                                                                 ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                  (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                 (let
                                                                                    ((pc.1$2_0 .46$2_0)
                                                                                     (i.0$2_0 inc$2_0)
                                                                                     (y.0$2_0 add$2_0)
                                                                                     (v.0$2_0 v.0$2_0))
                                                                                    (let
                                                                                       ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                       (=>
                                                                                          cmp5$2_0
                                                                                          (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         cmp5$1_0
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    or.cond48$2_0
                                                                                    (let
                                                                                       ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                       (let
                                                                                          ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                          (let
                                                                                             ((pc.1$2_0 .49$2_0)
                                                                                              (i.0$2_0 i.0$2_0)
                                                                                              (y.0$2_0 y.0$2_0)
                                                                                              (v.0$2_0 1))
                                                                                             (let
                                                                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                (=>
                                                                                                   cmp5$2_0
                                                                                                   (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         cmp5$1_0
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    (not or.cond48$2_0)
                                                                                    (let
                                                                                       ((cmp28$2_0 (= v.0$2_0 1))
                                                                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$2_0 (and
                                                                                                              cmp28$2_0
                                                                                                              cmp30$2_0))
                                                                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                          (let
                                                                                             ((or.cond51$2_0 (and
                                                                                                                 or.cond50$2_0
                                                                                                                 cmp32$2_0)))
                                                                                             (=>
                                                                                                or.cond51$2_0
                                                                                                (let
                                                                                                   ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                   (let
                                                                                                      ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                       (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                      (let
                                                                                                         ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                         (let
                                                                                                            ((pc.1$2_0 .52$2_0)
                                                                                                             (i.0$2_0 inc34$2_0)
                                                                                                             (y.0$2_0 add35$2_0)
                                                                                                             (v.0$2_0 v.0$2_0))
                                                                                                            (let
                                                                                                               ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                               (=>
                                                                                                                  cmp5$2_0
                                                                                                                  (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         cmp5$1_0
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    (not or.cond48$2_0)
                                                                                    (let
                                                                                       ((cmp28$2_0 (= v.0$2_0 1))
                                                                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$2_0 (and
                                                                                                              cmp28$2_0
                                                                                                              cmp30$2_0))
                                                                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                          (let
                                                                                             ((or.cond51$2_0 (and
                                                                                                                 or.cond50$2_0
                                                                                                                 cmp32$2_0)))
                                                                                             (=>
                                                                                                (not or.cond51$2_0)
                                                                                                (let
                                                                                                   ((pc.1$2_0 pc.1$2_0)
                                                                                                    (i.0$2_0 i.0$2_0)
                                                                                                    (y.0$2_0 y.0$2_0)
                                                                                                    (v.0$2_0 v.0$2_0))
                                                                                                   (let
                                                                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                      (=>
                                                                                                         cmp5$2_0
                                                                                                         (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        or.cond45$1_0
                        (let
                           ((inc$1_0 (+ i.0$1_0 1)))
                           (let
                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                              (let
                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                 (let
                                    ((pc.1$1_0 .46$1_0)
                                     (i.0$1_0 inc$1_0)
                                     (y.0$1_0 add$1_0)
                                     (v.0$1_0 v.0$1_0))
                                    (let
                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                       (=>
                                          cmp5$1_0
                                          (=>
                                             (and
                                                (let
                                                   ((call$2_0 call$2_0_old)
                                                    (i.0$2_0 i.0$2_0_old)
                                                    (max$2_0 max$2_0_old)
                                                    (pc.1$2_0 pc.1$2_0_old))
                                                   (let
                                                      ((v.0$2_0 v.0$2_0_old)
                                                       (y.0$2_0 y.0$2_0_old)
                                                       (cmp7$2_0 (< call$2_0 max$2_0))
                                                       (cmp8$2_0 (= pc.1$2_0 0)))
                                                      (let
                                                         ((or.cond44$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp8$2_0))
                                                          (cmp10$2_0 (= v.0$2_0 0)))
                                                         (let
                                                            ((or.cond45$2_0 (and
                                                                                or.cond44$2_0
                                                                                cmp10$2_0)))
                                                            (=>
                                                               or.cond45$2_0
                                                               (let
                                                                  ((inc$2_0 (+ i.0$2_0 1)))
                                                                  (let
                                                                     ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                     (let
                                                                        ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                         (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                        (let
                                                                           ((pc.1$2_0 .46$2_0)
                                                                            (i.0$2_0 inc$2_0)
                                                                            (y.0$2_0 add$2_0)
                                                                            (v.0$2_0 v.0$2_0))
                                                                           (let
                                                                              ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                              (not cmp5$2_0)))))))))))
                                                (let
                                                   ((call$2_0 call$2_0_old)
                                                    (i.0$2_0 i.0$2_0_old)
                                                    (max$2_0 max$2_0_old)
                                                    (pc.1$2_0 pc.1$2_0_old))
                                                   (let
                                                      ((v.0$2_0 v.0$2_0_old)
                                                       (y.0$2_0 y.0$2_0_old)
                                                       (cmp7$2_0 (< call$2_0 max$2_0))
                                                       (cmp8$2_0 (= pc.1$2_0 0)))
                                                      (let
                                                         ((or.cond44$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp8$2_0))
                                                          (cmp10$2_0 (= v.0$2_0 0)))
                                                         (let
                                                            ((or.cond45$2_0 (and
                                                                                or.cond44$2_0
                                                                                cmp10$2_0)))
                                                            (=>
                                                               (not or.cond45$2_0)
                                                               (let
                                                                  ((cmp17$2_0 (= v.0$2_0 0))
                                                                   (cmp19$2_0 (= pc.1$2_0 1)))
                                                                  (let
                                                                     ((or.cond47$2_0 (and
                                                                                         cmp17$2_0
                                                                                         cmp19$2_0))
                                                                      (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                     (let
                                                                        ((or.cond48$2_0 (and
                                                                                            or.cond47$2_0
                                                                                            cmp21$2_0)))
                                                                        (=>
                                                                           or.cond48$2_0
                                                                           (let
                                                                              ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                              (let
                                                                                 ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                 (let
                                                                                    ((pc.1$2_0 .49$2_0)
                                                                                     (i.0$2_0 i.0$2_0)
                                                                                     (y.0$2_0 y.0$2_0)
                                                                                     (v.0$2_0 1))
                                                                                    (let
                                                                                       ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                       (not cmp5$2_0))))))))))))))
                                                (let
                                                   ((call$2_0 call$2_0_old)
                                                    (i.0$2_0 i.0$2_0_old)
                                                    (max$2_0 max$2_0_old)
                                                    (pc.1$2_0 pc.1$2_0_old))
                                                   (let
                                                      ((v.0$2_0 v.0$2_0_old)
                                                       (y.0$2_0 y.0$2_0_old)
                                                       (cmp7$2_0 (< call$2_0 max$2_0))
                                                       (cmp8$2_0 (= pc.1$2_0 0)))
                                                      (let
                                                         ((or.cond44$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp8$2_0))
                                                          (cmp10$2_0 (= v.0$2_0 0)))
                                                         (let
                                                            ((or.cond45$2_0 (and
                                                                                or.cond44$2_0
                                                                                cmp10$2_0)))
                                                            (=>
                                                               (not or.cond45$2_0)
                                                               (let
                                                                  ((cmp17$2_0 (= v.0$2_0 0))
                                                                   (cmp19$2_0 (= pc.1$2_0 1)))
                                                                  (let
                                                                     ((or.cond47$2_0 (and
                                                                                         cmp17$2_0
                                                                                         cmp19$2_0))
                                                                      (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                     (let
                                                                        ((or.cond48$2_0 (and
                                                                                            or.cond47$2_0
                                                                                            cmp21$2_0)))
                                                                        (=>
                                                                           (not or.cond48$2_0)
                                                                           (let
                                                                              ((cmp28$2_0 (= v.0$2_0 1))
                                                                               (cmp30$2_0 (= pc.1$2_0 2)))
                                                                              (let
                                                                                 ((or.cond50$2_0 (and
                                                                                                     cmp28$2_0
                                                                                                     cmp30$2_0))
                                                                                  (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                 (let
                                                                                    ((or.cond51$2_0 (and
                                                                                                        or.cond50$2_0
                                                                                                        cmp32$2_0)))
                                                                                    (=>
                                                                                       or.cond51$2_0
                                                                                       (let
                                                                                          ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                          (let
                                                                                             ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                              (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                             (let
                                                                                                ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                (let
                                                                                                   ((pc.1$2_0 .52$2_0)
                                                                                                    (i.0$2_0 inc34$2_0)
                                                                                                    (y.0$2_0 add35$2_0)
                                                                                                    (v.0$2_0 v.0$2_0))
                                                                                                   (let
                                                                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                      (not cmp5$2_0)))))))))))))))))))
                                                (let
                                                   ((call$2_0 call$2_0_old)
                                                    (i.0$2_0 i.0$2_0_old)
                                                    (max$2_0 max$2_0_old)
                                                    (pc.1$2_0 pc.1$2_0_old))
                                                   (let
                                                      ((v.0$2_0 v.0$2_0_old)
                                                       (y.0$2_0 y.0$2_0_old)
                                                       (cmp7$2_0 (< call$2_0 max$2_0))
                                                       (cmp8$2_0 (= pc.1$2_0 0)))
                                                      (let
                                                         ((or.cond44$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp8$2_0))
                                                          (cmp10$2_0 (= v.0$2_0 0)))
                                                         (let
                                                            ((or.cond45$2_0 (and
                                                                                or.cond44$2_0
                                                                                cmp10$2_0)))
                                                            (=>
                                                               (not or.cond45$2_0)
                                                               (let
                                                                  ((cmp17$2_0 (= v.0$2_0 0))
                                                                   (cmp19$2_0 (= pc.1$2_0 1)))
                                                                  (let
                                                                     ((or.cond47$2_0 (and
                                                                                         cmp17$2_0
                                                                                         cmp19$2_0))
                                                                      (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                     (let
                                                                        ((or.cond48$2_0 (and
                                                                                            or.cond47$2_0
                                                                                            cmp21$2_0)))
                                                                        (=>
                                                                           (not or.cond48$2_0)
                                                                           (let
                                                                              ((cmp28$2_0 (= v.0$2_0 1))
                                                                               (cmp30$2_0 (= pc.1$2_0 2)))
                                                                              (let
                                                                                 ((or.cond50$2_0 (and
                                                                                                     cmp28$2_0
                                                                                                     cmp30$2_0))
                                                                                  (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                 (let
                                                                                    ((or.cond51$2_0 (and
                                                                                                        or.cond50$2_0
                                                                                                        cmp32$2_0)))
                                                                                    (=>
                                                                                       (not or.cond51$2_0)
                                                                                       (let
                                                                                          ((pc.1$2_0 pc.1$2_0)
                                                                                           (i.0$2_0 i.0$2_0)
                                                                                           (y.0$2_0 y.0$2_0)
                                                                                           (v.0$2_0 v.0$2_0))
                                                                                          (let
                                                                                             ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                             (not cmp5$2_0)))))))))))))))))
                                             (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    or.cond48$1_0
                                    (let
                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                       (let
                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                          (let
                                             ((pc.1$1_0 .49$1_0)
                                              (i.0$1_0 i.0$1_0)
                                              (y.0$1_0 y.0$1_0)
                                              (v.0$1_0 1))
                                             (let
                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp5$1_0
                                                   (=>
                                                      (and
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        or.cond45$2_0
                                                                        (let
                                                                           ((inc$2_0 (+ i.0$2_0 1)))
                                                                           (let
                                                                              ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                              (let
                                                                                 ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                  (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                 (let
                                                                                    ((pc.1$2_0 .46$2_0)
                                                                                     (i.0$2_0 inc$2_0)
                                                                                     (y.0$2_0 add$2_0)
                                                                                     (v.0$2_0 v.0$2_0))
                                                                                    (let
                                                                                       ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                       (not cmp5$2_0)))))))))))
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    or.cond48$2_0
                                                                                    (let
                                                                                       ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                       (let
                                                                                          ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                          (let
                                                                                             ((pc.1$2_0 .49$2_0)
                                                                                              (i.0$2_0 i.0$2_0)
                                                                                              (y.0$2_0 y.0$2_0)
                                                                                              (v.0$2_0 1))
                                                                                             (let
                                                                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                (not cmp5$2_0))))))))))))))
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    (not or.cond48$2_0)
                                                                                    (let
                                                                                       ((cmp28$2_0 (= v.0$2_0 1))
                                                                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$2_0 (and
                                                                                                              cmp28$2_0
                                                                                                              cmp30$2_0))
                                                                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                          (let
                                                                                             ((or.cond51$2_0 (and
                                                                                                                 or.cond50$2_0
                                                                                                                 cmp32$2_0)))
                                                                                             (=>
                                                                                                or.cond51$2_0
                                                                                                (let
                                                                                                   ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                   (let
                                                                                                      ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                       (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                      (let
                                                                                                         ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                         (let
                                                                                                            ((pc.1$2_0 .52$2_0)
                                                                                                             (i.0$2_0 inc34$2_0)
                                                                                                             (y.0$2_0 add35$2_0)
                                                                                                             (v.0$2_0 v.0$2_0))
                                                                                                            (let
                                                                                                               ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                               (not cmp5$2_0)))))))))))))))))))
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.1$2_0 pc.1$2_0_old))
                                                            (let
                                                               ((v.0$2_0 v.0$2_0_old)
                                                                (y.0$2_0 y.0$2_0_old)
                                                                (cmp7$2_0 (< call$2_0 max$2_0))
                                                                (cmp8$2_0 (= pc.1$2_0 0)))
                                                               (let
                                                                  ((or.cond44$2_0 (and
                                                                                      cmp7$2_0
                                                                                      cmp8$2_0))
                                                                   (cmp10$2_0 (= v.0$2_0 0)))
                                                                  (let
                                                                     ((or.cond45$2_0 (and
                                                                                         or.cond44$2_0
                                                                                         cmp10$2_0)))
                                                                     (=>
                                                                        (not or.cond45$2_0)
                                                                        (let
                                                                           ((cmp17$2_0 (= v.0$2_0 0))
                                                                            (cmp19$2_0 (= pc.1$2_0 1)))
                                                                           (let
                                                                              ((or.cond47$2_0 (and
                                                                                                  cmp17$2_0
                                                                                                  cmp19$2_0))
                                                                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                              (let
                                                                                 ((or.cond48$2_0 (and
                                                                                                     or.cond47$2_0
                                                                                                     cmp21$2_0)))
                                                                                 (=>
                                                                                    (not or.cond48$2_0)
                                                                                    (let
                                                                                       ((cmp28$2_0 (= v.0$2_0 1))
                                                                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$2_0 (and
                                                                                                              cmp28$2_0
                                                                                                              cmp30$2_0))
                                                                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                          (let
                                                                                             ((or.cond51$2_0 (and
                                                                                                                 or.cond50$2_0
                                                                                                                 cmp32$2_0)))
                                                                                             (=>
                                                                                                (not or.cond51$2_0)
                                                                                                (let
                                                                                                   ((pc.1$2_0 pc.1$2_0)
                                                                                                    (i.0$2_0 i.0$2_0)
                                                                                                    (y.0$2_0 y.0$2_0)
                                                                                                    (v.0$2_0 v.0$2_0))
                                                                                                   (let
                                                                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                      (not cmp5$2_0)))))))))))))))))
                                                      (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                or.cond51$1_0
                                                (let
                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                   (let
                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                      (let
                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                         (let
                                                            ((pc.1$1_0 .52$1_0)
                                                             (i.0$1_0 inc34$1_0)
                                                             (y.0$1_0 add35$1_0)
                                                             (v.0$1_0 v.0$1_0))
                                                            (let
                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                               (=>
                                                                  cmp5$1_0
                                                                  (=>
                                                                     (and
                                                                        (let
                                                                           ((call$2_0 call$2_0_old)
                                                                            (i.0$2_0 i.0$2_0_old)
                                                                            (max$2_0 max$2_0_old)
                                                                            (pc.1$2_0 pc.1$2_0_old))
                                                                           (let
                                                                              ((v.0$2_0 v.0$2_0_old)
                                                                               (y.0$2_0 y.0$2_0_old)
                                                                               (cmp7$2_0 (< call$2_0 max$2_0))
                                                                               (cmp8$2_0 (= pc.1$2_0 0)))
                                                                              (let
                                                                                 ((or.cond44$2_0 (and
                                                                                                     cmp7$2_0
                                                                                                     cmp8$2_0))
                                                                                  (cmp10$2_0 (= v.0$2_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$2_0 (and
                                                                                                        or.cond44$2_0
                                                                                                        cmp10$2_0)))
                                                                                    (=>
                                                                                       or.cond45$2_0
                                                                                       (let
                                                                                          ((inc$2_0 (+ i.0$2_0 1)))
                                                                                          (let
                                                                                             ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                                             (let
                                                                                                ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                                 (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                                (let
                                                                                                   ((pc.1$2_0 .46$2_0)
                                                                                                    (i.0$2_0 inc$2_0)
                                                                                                    (y.0$2_0 add$2_0)
                                                                                                    (v.0$2_0 v.0$2_0))
                                                                                                   (let
                                                                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                      (not cmp5$2_0)))))))))))
                                                                        (let
                                                                           ((call$2_0 call$2_0_old)
                                                                            (i.0$2_0 i.0$2_0_old)
                                                                            (max$2_0 max$2_0_old)
                                                                            (pc.1$2_0 pc.1$2_0_old))
                                                                           (let
                                                                              ((v.0$2_0 v.0$2_0_old)
                                                                               (y.0$2_0 y.0$2_0_old)
                                                                               (cmp7$2_0 (< call$2_0 max$2_0))
                                                                               (cmp8$2_0 (= pc.1$2_0 0)))
                                                                              (let
                                                                                 ((or.cond44$2_0 (and
                                                                                                     cmp7$2_0
                                                                                                     cmp8$2_0))
                                                                                  (cmp10$2_0 (= v.0$2_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$2_0 (and
                                                                                                        or.cond44$2_0
                                                                                                        cmp10$2_0)))
                                                                                    (=>
                                                                                       (not or.cond45$2_0)
                                                                                       (let
                                                                                          ((cmp17$2_0 (= v.0$2_0 0))
                                                                                           (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$2_0 (and
                                                                                                                 cmp17$2_0
                                                                                                                 cmp19$2_0))
                                                                                              (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                             (let
                                                                                                ((or.cond48$2_0 (and
                                                                                                                    or.cond47$2_0
                                                                                                                    cmp21$2_0)))
                                                                                                (=>
                                                                                                   or.cond48$2_0
                                                                                                   (let
                                                                                                      ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                                      (let
                                                                                                         ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                                         (let
                                                                                                            ((pc.1$2_0 .49$2_0)
                                                                                                             (i.0$2_0 i.0$2_0)
                                                                                                             (y.0$2_0 y.0$2_0)
                                                                                                             (v.0$2_0 1))
                                                                                                            (let
                                                                                                               ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                               (not cmp5$2_0))))))))))))))
                                                                        (let
                                                                           ((call$2_0 call$2_0_old)
                                                                            (i.0$2_0 i.0$2_0_old)
                                                                            (max$2_0 max$2_0_old)
                                                                            (pc.1$2_0 pc.1$2_0_old))
                                                                           (let
                                                                              ((v.0$2_0 v.0$2_0_old)
                                                                               (y.0$2_0 y.0$2_0_old)
                                                                               (cmp7$2_0 (< call$2_0 max$2_0))
                                                                               (cmp8$2_0 (= pc.1$2_0 0)))
                                                                              (let
                                                                                 ((or.cond44$2_0 (and
                                                                                                     cmp7$2_0
                                                                                                     cmp8$2_0))
                                                                                  (cmp10$2_0 (= v.0$2_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$2_0 (and
                                                                                                        or.cond44$2_0
                                                                                                        cmp10$2_0)))
                                                                                    (=>
                                                                                       (not or.cond45$2_0)
                                                                                       (let
                                                                                          ((cmp17$2_0 (= v.0$2_0 0))
                                                                                           (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$2_0 (and
                                                                                                                 cmp17$2_0
                                                                                                                 cmp19$2_0))
                                                                                              (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                             (let
                                                                                                ((or.cond48$2_0 (and
                                                                                                                    or.cond47$2_0
                                                                                                                    cmp21$2_0)))
                                                                                                (=>
                                                                                                   (not or.cond48$2_0)
                                                                                                   (let
                                                                                                      ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                       (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                      (let
                                                                                                         ((or.cond50$2_0 (and
                                                                                                                             cmp28$2_0
                                                                                                                             cmp30$2_0))
                                                                                                          (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                         (let
                                                                                                            ((or.cond51$2_0 (and
                                                                                                                                or.cond50$2_0
                                                                                                                                cmp32$2_0)))
                                                                                                            (=>
                                                                                                               or.cond51$2_0
                                                                                                               (let
                                                                                                                  ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                                  (let
                                                                                                                     ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                                      (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                                     (let
                                                                                                                        ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                                        (let
                                                                                                                           ((pc.1$2_0 .52$2_0)
                                                                                                                            (i.0$2_0 inc34$2_0)
                                                                                                                            (y.0$2_0 add35$2_0)
                                                                                                                            (v.0$2_0 v.0$2_0))
                                                                                                                           (let
                                                                                                                              ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                              (not cmp5$2_0)))))))))))))))))))
                                                                        (let
                                                                           ((call$2_0 call$2_0_old)
                                                                            (i.0$2_0 i.0$2_0_old)
                                                                            (max$2_0 max$2_0_old)
                                                                            (pc.1$2_0 pc.1$2_0_old))
                                                                           (let
                                                                              ((v.0$2_0 v.0$2_0_old)
                                                                               (y.0$2_0 y.0$2_0_old)
                                                                               (cmp7$2_0 (< call$2_0 max$2_0))
                                                                               (cmp8$2_0 (= pc.1$2_0 0)))
                                                                              (let
                                                                                 ((or.cond44$2_0 (and
                                                                                                     cmp7$2_0
                                                                                                     cmp8$2_0))
                                                                                  (cmp10$2_0 (= v.0$2_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$2_0 (and
                                                                                                        or.cond44$2_0
                                                                                                        cmp10$2_0)))
                                                                                    (=>
                                                                                       (not or.cond45$2_0)
                                                                                       (let
                                                                                          ((cmp17$2_0 (= v.0$2_0 0))
                                                                                           (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$2_0 (and
                                                                                                                 cmp17$2_0
                                                                                                                 cmp19$2_0))
                                                                                              (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                             (let
                                                                                                ((or.cond48$2_0 (and
                                                                                                                    or.cond47$2_0
                                                                                                                    cmp21$2_0)))
                                                                                                (=>
                                                                                                   (not or.cond48$2_0)
                                                                                                   (let
                                                                                                      ((cmp28$2_0 (= v.0$2_0 1))
                                                                                                       (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                                      (let
                                                                                                         ((or.cond50$2_0 (and
                                                                                                                             cmp28$2_0
                                                                                                                             cmp30$2_0))
                                                                                                          (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                         (let
                                                                                                            ((or.cond51$2_0 (and
                                                                                                                                or.cond50$2_0
                                                                                                                                cmp32$2_0)))
                                                                                                            (=>
                                                                                                               (not or.cond51$2_0)
                                                                                                               (let
                                                                                                                  ((pc.1$2_0 pc.1$2_0)
                                                                                                                   (i.0$2_0 i.0$2_0)
                                                                                                                   (y.0$2_0 y.0$2_0)
                                                                                                                   (v.0$2_0 v.0$2_0))
                                                                                                                  (let
                                                                                                                     ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                     (not cmp5$2_0)))))))))))))))))
                                                                     (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.1$1_0 pc.1$1_0_old))
            (let
               ((v.0$1_0 v.0$1_0_old)
                (y.0$1_0 y.0$1_0_old)
                (cmp7$1_0 (< call$1_0 max$1_0))
                (cmp8$1_0 (= pc.1$1_0 0)))
               (let
                  ((or.cond44$1_0 (and
                                      cmp7$1_0
                                      cmp8$1_0))
                   (cmp10$1_0 (= v.0$1_0 0)))
                  (let
                     ((or.cond45$1_0 (and
                                         or.cond44$1_0
                                         cmp10$1_0)))
                     (=>
                        (not or.cond45$1_0)
                        (let
                           ((cmp17$1_0 (= v.0$1_0 0))
                            (cmp19$1_0 (= pc.1$1_0 1)))
                           (let
                              ((or.cond47$1_0 (and
                                                  cmp17$1_0
                                                  cmp19$1_0))
                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                              (let
                                 ((or.cond48$1_0 (and
                                                     or.cond47$1_0
                                                     cmp21$1_0)))
                                 (=>
                                    (not or.cond48$1_0)
                                    (let
                                       ((cmp28$1_0 (= v.0$1_0 1))
                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                       (let
                                          ((or.cond50$1_0 (and
                                                              cmp28$1_0
                                                              cmp30$1_0))
                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                          (let
                                             ((or.cond51$1_0 (and
                                                                 or.cond50$1_0
                                                                 cmp32$1_0)))
                                             (=>
                                                (not or.cond51$1_0)
                                                (let
                                                   ((pc.1$1_0 pc.1$1_0)
                                                    (i.0$1_0 i.0$1_0)
                                                    (y.0$1_0 y.0$1_0)
                                                    (v.0$1_0 v.0$1_0))
                                                   (let
                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                      (=>
                                                         cmp5$1_0
                                                         (=>
                                                            (and
                                                               (let
                                                                  ((call$2_0 call$2_0_old)
                                                                   (i.0$2_0 i.0$2_0_old)
                                                                   (max$2_0 max$2_0_old)
                                                                   (pc.1$2_0 pc.1$2_0_old))
                                                                  (let
                                                                     ((v.0$2_0 v.0$2_0_old)
                                                                      (y.0$2_0 y.0$2_0_old)
                                                                      (cmp7$2_0 (< call$2_0 max$2_0))
                                                                      (cmp8$2_0 (= pc.1$2_0 0)))
                                                                     (let
                                                                        ((or.cond44$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp8$2_0))
                                                                         (cmp10$2_0 (= v.0$2_0 0)))
                                                                        (let
                                                                           ((or.cond45$2_0 (and
                                                                                               or.cond44$2_0
                                                                                               cmp10$2_0)))
                                                                           (=>
                                                                              or.cond45$2_0
                                                                              (let
                                                                                 ((inc$2_0 (+ i.0$2_0 1)))
                                                                                 (let
                                                                                    ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                                                                                    (let
                                                                                       ((.46$2_0 (ite cmp12$2_0 1 0))
                                                                                        (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                                                                       (let
                                                                                          ((pc.1$2_0 .46$2_0)
                                                                                           (i.0$2_0 inc$2_0)
                                                                                           (y.0$2_0 add$2_0)
                                                                                           (v.0$2_0 v.0$2_0))
                                                                                          (let
                                                                                             ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                             (not cmp5$2_0)))))))))))
                                                               (let
                                                                  ((call$2_0 call$2_0_old)
                                                                   (i.0$2_0 i.0$2_0_old)
                                                                   (max$2_0 max$2_0_old)
                                                                   (pc.1$2_0 pc.1$2_0_old))
                                                                  (let
                                                                     ((v.0$2_0 v.0$2_0_old)
                                                                      (y.0$2_0 y.0$2_0_old)
                                                                      (cmp7$2_0 (< call$2_0 max$2_0))
                                                                      (cmp8$2_0 (= pc.1$2_0 0)))
                                                                     (let
                                                                        ((or.cond44$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp8$2_0))
                                                                         (cmp10$2_0 (= v.0$2_0 0)))
                                                                        (let
                                                                           ((or.cond45$2_0 (and
                                                                                               or.cond44$2_0
                                                                                               cmp10$2_0)))
                                                                           (=>
                                                                              (not or.cond45$2_0)
                                                                              (let
                                                                                 ((cmp17$2_0 (= v.0$2_0 0))
                                                                                  (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$2_0 (and
                                                                                                        cmp17$2_0
                                                                                                        cmp19$2_0))
                                                                                     (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                    (let
                                                                                       ((or.cond48$2_0 (and
                                                                                                           or.cond47$2_0
                                                                                                           cmp21$2_0)))
                                                                                       (=>
                                                                                          or.cond48$2_0
                                                                                          (let
                                                                                             ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                                                                             (let
                                                                                                ((.49$2_0 (ite cmp23$2_0 3 2)))
                                                                                                (let
                                                                                                   ((pc.1$2_0 .49$2_0)
                                                                                                    (i.0$2_0 i.0$2_0)
                                                                                                    (y.0$2_0 y.0$2_0)
                                                                                                    (v.0$2_0 1))
                                                                                                   (let
                                                                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                      (not cmp5$2_0))))))))))))))
                                                               (let
                                                                  ((call$2_0 call$2_0_old)
                                                                   (i.0$2_0 i.0$2_0_old)
                                                                   (max$2_0 max$2_0_old)
                                                                   (pc.1$2_0 pc.1$2_0_old))
                                                                  (let
                                                                     ((v.0$2_0 v.0$2_0_old)
                                                                      (y.0$2_0 y.0$2_0_old)
                                                                      (cmp7$2_0 (< call$2_0 max$2_0))
                                                                      (cmp8$2_0 (= pc.1$2_0 0)))
                                                                     (let
                                                                        ((or.cond44$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp8$2_0))
                                                                         (cmp10$2_0 (= v.0$2_0 0)))
                                                                        (let
                                                                           ((or.cond45$2_0 (and
                                                                                               or.cond44$2_0
                                                                                               cmp10$2_0)))
                                                                           (=>
                                                                              (not or.cond45$2_0)
                                                                              (let
                                                                                 ((cmp17$2_0 (= v.0$2_0 0))
                                                                                  (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$2_0 (and
                                                                                                        cmp17$2_0
                                                                                                        cmp19$2_0))
                                                                                     (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                    (let
                                                                                       ((or.cond48$2_0 (and
                                                                                                           or.cond47$2_0
                                                                                                           cmp21$2_0)))
                                                                                       (=>
                                                                                          (not or.cond48$2_0)
                                                                                          (let
                                                                                             ((cmp28$2_0 (= v.0$2_0 1))
                                                                                              (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                             (let
                                                                                                ((or.cond50$2_0 (and
                                                                                                                    cmp28$2_0
                                                                                                                    cmp30$2_0))
                                                                                                 (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                (let
                                                                                                   ((or.cond51$2_0 (and
                                                                                                                       or.cond50$2_0
                                                                                                                       cmp32$2_0)))
                                                                                                   (=>
                                                                                                      or.cond51$2_0
                                                                                                      (let
                                                                                                         ((inc34$2_0 (+ i.0$2_0 1)))
                                                                                                         (let
                                                                                                            ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                                                                             (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                                                                            (let
                                                                                                               ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                                                                               (let
                                                                                                                  ((pc.1$2_0 .52$2_0)
                                                                                                                   (i.0$2_0 inc34$2_0)
                                                                                                                   (y.0$2_0 add35$2_0)
                                                                                                                   (v.0$2_0 v.0$2_0))
                                                                                                                  (let
                                                                                                                     ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                                     (not cmp5$2_0)))))))))))))))))))
                                                               (let
                                                                  ((call$2_0 call$2_0_old)
                                                                   (i.0$2_0 i.0$2_0_old)
                                                                   (max$2_0 max$2_0_old)
                                                                   (pc.1$2_0 pc.1$2_0_old))
                                                                  (let
                                                                     ((v.0$2_0 v.0$2_0_old)
                                                                      (y.0$2_0 y.0$2_0_old)
                                                                      (cmp7$2_0 (< call$2_0 max$2_0))
                                                                      (cmp8$2_0 (= pc.1$2_0 0)))
                                                                     (let
                                                                        ((or.cond44$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp8$2_0))
                                                                         (cmp10$2_0 (= v.0$2_0 0)))
                                                                        (let
                                                                           ((or.cond45$2_0 (and
                                                                                               or.cond44$2_0
                                                                                               cmp10$2_0)))
                                                                           (=>
                                                                              (not or.cond45$2_0)
                                                                              (let
                                                                                 ((cmp17$2_0 (= v.0$2_0 0))
                                                                                  (cmp19$2_0 (= pc.1$2_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$2_0 (and
                                                                                                        cmp17$2_0
                                                                                                        cmp19$2_0))
                                                                                     (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                                                                                    (let
                                                                                       ((or.cond48$2_0 (and
                                                                                                           or.cond47$2_0
                                                                                                           cmp21$2_0)))
                                                                                       (=>
                                                                                          (not or.cond48$2_0)
                                                                                          (let
                                                                                             ((cmp28$2_0 (= v.0$2_0 1))
                                                                                              (cmp30$2_0 (= pc.1$2_0 2)))
                                                                                             (let
                                                                                                ((or.cond50$2_0 (and
                                                                                                                    cmp28$2_0
                                                                                                                    cmp30$2_0))
                                                                                                 (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                                                                                (let
                                                                                                   ((or.cond51$2_0 (and
                                                                                                                       or.cond50$2_0
                                                                                                                       cmp32$2_0)))
                                                                                                   (=>
                                                                                                      (not or.cond51$2_0)
                                                                                                      (let
                                                                                                         ((pc.1$2_0 pc.1$2_0)
                                                                                                          (i.0$2_0 i.0$2_0)
                                                                                                          (y.0$2_0 y.0$2_0)
                                                                                                          (v.0$2_0 v.0$2_0))
                                                                                                         (let
                                                                                                            ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                                                                            (not cmp5$2_0)))))))))))))))))
                                                            (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.1$1_0 v.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.1$2_0 pc.1$2_0_old))
            (let
               ((v.0$2_0 v.0$2_0_old)
                (y.0$2_0 y.0$2_0_old)
                (cmp7$2_0 (< call$2_0 max$2_0))
                (cmp8$2_0 (= pc.1$2_0 0)))
               (let
                  ((or.cond44$2_0 (and
                                      cmp7$2_0
                                      cmp8$2_0))
                   (cmp10$2_0 (= v.0$2_0 0)))
                  (let
                     ((or.cond45$2_0 (and
                                         or.cond44$2_0
                                         cmp10$2_0)))
                     (=>
                        or.cond45$2_0
                        (let
                           ((inc$2_0 (+ i.0$2_0 1)))
                           (let
                              ((cmp12$2_0 (<= call$2_0 inc$2_0)))
                              (let
                                 ((.46$2_0 (ite cmp12$2_0 1 0))
                                  (add$2_0 (+ y.0$2_0 y.0$2_0)))
                                 (let
                                    ((pc.1$2_0 .46$2_0)
                                     (i.0$2_0 inc$2_0)
                                     (y.0$2_0 add$2_0)
                                     (v.0$2_0 v.0$2_0))
                                    (let
                                       ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                       (=>
                                          cmp5$2_0
                                          (=>
                                             (and
                                                (let
                                                   ((call$1_0 call$1_0_old)
                                                    (i.0$1_0 i.0$1_0_old)
                                                    (max$1_0 max$1_0_old)
                                                    (pc.1$1_0 pc.1$1_0_old))
                                                   (let
                                                      ((v.0$1_0 v.0$1_0_old)
                                                       (y.0$1_0 y.0$1_0_old)
                                                       (cmp7$1_0 (< call$1_0 max$1_0))
                                                       (cmp8$1_0 (= pc.1$1_0 0)))
                                                      (let
                                                         ((or.cond44$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp8$1_0))
                                                          (cmp10$1_0 (= v.0$1_0 0)))
                                                         (let
                                                            ((or.cond45$1_0 (and
                                                                                or.cond44$1_0
                                                                                cmp10$1_0)))
                                                            (=>
                                                               or.cond45$1_0
                                                               (let
                                                                  ((inc$1_0 (+ i.0$1_0 1)))
                                                                  (let
                                                                     ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                                                                     (let
                                                                        ((.46$1_0 (ite cmp12$1_0 1 0))
                                                                         (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                                                        (let
                                                                           ((pc.1$1_0 .46$1_0)
                                                                            (i.0$1_0 inc$1_0)
                                                                            (y.0$1_0 add$1_0)
                                                                            (v.0$1_0 v.0$1_0))
                                                                           (let
                                                                              ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                              (not cmp5$1_0)))))))))))
                                                (let
                                                   ((call$1_0 call$1_0_old)
                                                    (i.0$1_0 i.0$1_0_old)
                                                    (max$1_0 max$1_0_old)
                                                    (pc.1$1_0 pc.1$1_0_old))
                                                   (let
                                                      ((v.0$1_0 v.0$1_0_old)
                                                       (y.0$1_0 y.0$1_0_old)
                                                       (cmp7$1_0 (< call$1_0 max$1_0))
                                                       (cmp8$1_0 (= pc.1$1_0 0)))
                                                      (let
                                                         ((or.cond44$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp8$1_0))
                                                          (cmp10$1_0 (= v.0$1_0 0)))
                                                         (let
                                                            ((or.cond45$1_0 (and
                                                                                or.cond44$1_0
                                                                                cmp10$1_0)))
                                                            (=>
                                                               (not or.cond45$1_0)
                                                               (let
                                                                  ((cmp17$1_0 (= v.0$1_0 0))
                                                                   (cmp19$1_0 (= pc.1$1_0 1)))
                                                                  (let
                                                                     ((or.cond47$1_0 (and
                                                                                         cmp17$1_0
                                                                                         cmp19$1_0))
                                                                      (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                     (let
                                                                        ((or.cond48$1_0 (and
                                                                                            or.cond47$1_0
                                                                                            cmp21$1_0)))
                                                                        (=>
                                                                           or.cond48$1_0
                                                                           (let
                                                                              ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                                                              (let
                                                                                 ((.49$1_0 (ite cmp23$1_0 3 2)))
                                                                                 (let
                                                                                    ((pc.1$1_0 .49$1_0)
                                                                                     (i.0$1_0 i.0$1_0)
                                                                                     (y.0$1_0 y.0$1_0)
                                                                                     (v.0$1_0 1))
                                                                                    (let
                                                                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                       (not cmp5$1_0))))))))))))))
                                                (let
                                                   ((call$1_0 call$1_0_old)
                                                    (i.0$1_0 i.0$1_0_old)
                                                    (max$1_0 max$1_0_old)
                                                    (pc.1$1_0 pc.1$1_0_old))
                                                   (let
                                                      ((v.0$1_0 v.0$1_0_old)
                                                       (y.0$1_0 y.0$1_0_old)
                                                       (cmp7$1_0 (< call$1_0 max$1_0))
                                                       (cmp8$1_0 (= pc.1$1_0 0)))
                                                      (let
                                                         ((or.cond44$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp8$1_0))
                                                          (cmp10$1_0 (= v.0$1_0 0)))
                                                         (let
                                                            ((or.cond45$1_0 (and
                                                                                or.cond44$1_0
                                                                                cmp10$1_0)))
                                                            (=>
                                                               (not or.cond45$1_0)
                                                               (let
                                                                  ((cmp17$1_0 (= v.0$1_0 0))
                                                                   (cmp19$1_0 (= pc.1$1_0 1)))
                                                                  (let
                                                                     ((or.cond47$1_0 (and
                                                                                         cmp17$1_0
                                                                                         cmp19$1_0))
                                                                      (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                     (let
                                                                        ((or.cond48$1_0 (and
                                                                                            or.cond47$1_0
                                                                                            cmp21$1_0)))
                                                                        (=>
                                                                           (not or.cond48$1_0)
                                                                           (let
                                                                              ((cmp28$1_0 (= v.0$1_0 1))
                                                                               (cmp30$1_0 (= pc.1$1_0 2)))
                                                                              (let
                                                                                 ((or.cond50$1_0 (and
                                                                                                     cmp28$1_0
                                                                                                     cmp30$1_0))
                                                                                  (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                 (let
                                                                                    ((or.cond51$1_0 (and
                                                                                                        or.cond50$1_0
                                                                                                        cmp32$1_0)))
                                                                                    (=>
                                                                                       or.cond51$1_0
                                                                                       (let
                                                                                          ((inc34$1_0 (+ i.0$1_0 1)))
                                                                                          (let
                                                                                             ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                                                              (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                                                             (let
                                                                                                ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                                                                (let
                                                                                                   ((pc.1$1_0 .52$1_0)
                                                                                                    (i.0$1_0 inc34$1_0)
                                                                                                    (y.0$1_0 add35$1_0)
                                                                                                    (v.0$1_0 v.0$1_0))
                                                                                                   (let
                                                                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                      (not cmp5$1_0)))))))))))))))))))
                                                (let
                                                   ((call$1_0 call$1_0_old)
                                                    (i.0$1_0 i.0$1_0_old)
                                                    (max$1_0 max$1_0_old)
                                                    (pc.1$1_0 pc.1$1_0_old))
                                                   (let
                                                      ((v.0$1_0 v.0$1_0_old)
                                                       (y.0$1_0 y.0$1_0_old)
                                                       (cmp7$1_0 (< call$1_0 max$1_0))
                                                       (cmp8$1_0 (= pc.1$1_0 0)))
                                                      (let
                                                         ((or.cond44$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp8$1_0))
                                                          (cmp10$1_0 (= v.0$1_0 0)))
                                                         (let
                                                            ((or.cond45$1_0 (and
                                                                                or.cond44$1_0
                                                                                cmp10$1_0)))
                                                            (=>
                                                               (not or.cond45$1_0)
                                                               (let
                                                                  ((cmp17$1_0 (= v.0$1_0 0))
                                                                   (cmp19$1_0 (= pc.1$1_0 1)))
                                                                  (let
                                                                     ((or.cond47$1_0 (and
                                                                                         cmp17$1_0
                                                                                         cmp19$1_0))
                                                                      (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                     (let
                                                                        ((or.cond48$1_0 (and
                                                                                            or.cond47$1_0
                                                                                            cmp21$1_0)))
                                                                        (=>
                                                                           (not or.cond48$1_0)
                                                                           (let
                                                                              ((cmp28$1_0 (= v.0$1_0 1))
                                                                               (cmp30$1_0 (= pc.1$1_0 2)))
                                                                              (let
                                                                                 ((or.cond50$1_0 (and
                                                                                                     cmp28$1_0
                                                                                                     cmp30$1_0))
                                                                                  (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                 (let
                                                                                    ((or.cond51$1_0 (and
                                                                                                        or.cond50$1_0
                                                                                                        cmp32$1_0)))
                                                                                    (=>
                                                                                       (not or.cond51$1_0)
                                                                                       (let
                                                                                          ((pc.1$1_0 pc.1$1_0)
                                                                                           (i.0$1_0 i.0$1_0)
                                                                                           (y.0$1_0 y.0$1_0)
                                                                                           (v.0$1_0 v.0$1_0))
                                                                                          (let
                                                                                             ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                             (not cmp5$1_0)))))))))))))))))
                                             (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.1$2_0 pc.1$2_0_old))
            (let
               ((v.0$2_0 v.0$2_0_old)
                (y.0$2_0 y.0$2_0_old)
                (cmp7$2_0 (< call$2_0 max$2_0))
                (cmp8$2_0 (= pc.1$2_0 0)))
               (let
                  ((or.cond44$2_0 (and
                                      cmp7$2_0
                                      cmp8$2_0))
                   (cmp10$2_0 (= v.0$2_0 0)))
                  (let
                     ((or.cond45$2_0 (and
                                         or.cond44$2_0
                                         cmp10$2_0)))
                     (=>
                        (not or.cond45$2_0)
                        (let
                           ((cmp17$2_0 (= v.0$2_0 0))
                            (cmp19$2_0 (= pc.1$2_0 1)))
                           (let
                              ((or.cond47$2_0 (and
                                                  cmp17$2_0
                                                  cmp19$2_0))
                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                              (let
                                 ((or.cond48$2_0 (and
                                                     or.cond47$2_0
                                                     cmp21$2_0)))
                                 (=>
                                    or.cond48$2_0
                                    (let
                                       ((cmp23$2_0 (<= max$2_0 i.0$2_0)))
                                       (let
                                          ((.49$2_0 (ite cmp23$2_0 3 2)))
                                          (let
                                             ((pc.1$2_0 .49$2_0)
                                              (i.0$2_0 i.0$2_0)
                                              (y.0$2_0 y.0$2_0)
                                              (v.0$2_0 1))
                                             (let
                                                ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                (=>
                                                   cmp5$2_0
                                                   (=>
                                                      (and
                                                         (let
                                                            ((call$1_0 call$1_0_old)
                                                             (i.0$1_0 i.0$1_0_old)
                                                             (max$1_0 max$1_0_old)
                                                             (pc.1$1_0 pc.1$1_0_old))
                                                            (let
                                                               ((v.0$1_0 v.0$1_0_old)
                                                                (y.0$1_0 y.0$1_0_old)
                                                                (cmp7$1_0 (< call$1_0 max$1_0))
                                                                (cmp8$1_0 (= pc.1$1_0 0)))
                                                               (let
                                                                  ((or.cond44$1_0 (and
                                                                                      cmp7$1_0
                                                                                      cmp8$1_0))
                                                                   (cmp10$1_0 (= v.0$1_0 0)))
                                                                  (let
                                                                     ((or.cond45$1_0 (and
                                                                                         or.cond44$1_0
                                                                                         cmp10$1_0)))
                                                                     (=>
                                                                        or.cond45$1_0
                                                                        (let
                                                                           ((inc$1_0 (+ i.0$1_0 1)))
                                                                           (let
                                                                              ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                                                                              (let
                                                                                 ((.46$1_0 (ite cmp12$1_0 1 0))
                                                                                  (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                                                                 (let
                                                                                    ((pc.1$1_0 .46$1_0)
                                                                                     (i.0$1_0 inc$1_0)
                                                                                     (y.0$1_0 add$1_0)
                                                                                     (v.0$1_0 v.0$1_0))
                                                                                    (let
                                                                                       ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                       (not cmp5$1_0)))))))))))
                                                         (let
                                                            ((call$1_0 call$1_0_old)
                                                             (i.0$1_0 i.0$1_0_old)
                                                             (max$1_0 max$1_0_old)
                                                             (pc.1$1_0 pc.1$1_0_old))
                                                            (let
                                                               ((v.0$1_0 v.0$1_0_old)
                                                                (y.0$1_0 y.0$1_0_old)
                                                                (cmp7$1_0 (< call$1_0 max$1_0))
                                                                (cmp8$1_0 (= pc.1$1_0 0)))
                                                               (let
                                                                  ((or.cond44$1_0 (and
                                                                                      cmp7$1_0
                                                                                      cmp8$1_0))
                                                                   (cmp10$1_0 (= v.0$1_0 0)))
                                                                  (let
                                                                     ((or.cond45$1_0 (and
                                                                                         or.cond44$1_0
                                                                                         cmp10$1_0)))
                                                                     (=>
                                                                        (not or.cond45$1_0)
                                                                        (let
                                                                           ((cmp17$1_0 (= v.0$1_0 0))
                                                                            (cmp19$1_0 (= pc.1$1_0 1)))
                                                                           (let
                                                                              ((or.cond47$1_0 (and
                                                                                                  cmp17$1_0
                                                                                                  cmp19$1_0))
                                                                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                              (let
                                                                                 ((or.cond48$1_0 (and
                                                                                                     or.cond47$1_0
                                                                                                     cmp21$1_0)))
                                                                                 (=>
                                                                                    or.cond48$1_0
                                                                                    (let
                                                                                       ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                                                                       (let
                                                                                          ((.49$1_0 (ite cmp23$1_0 3 2)))
                                                                                          (let
                                                                                             ((pc.1$1_0 .49$1_0)
                                                                                              (i.0$1_0 i.0$1_0)
                                                                                              (y.0$1_0 y.0$1_0)
                                                                                              (v.0$1_0 1))
                                                                                             (let
                                                                                                ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                (not cmp5$1_0))))))))))))))
                                                         (let
                                                            ((call$1_0 call$1_0_old)
                                                             (i.0$1_0 i.0$1_0_old)
                                                             (max$1_0 max$1_0_old)
                                                             (pc.1$1_0 pc.1$1_0_old))
                                                            (let
                                                               ((v.0$1_0 v.0$1_0_old)
                                                                (y.0$1_0 y.0$1_0_old)
                                                                (cmp7$1_0 (< call$1_0 max$1_0))
                                                                (cmp8$1_0 (= pc.1$1_0 0)))
                                                               (let
                                                                  ((or.cond44$1_0 (and
                                                                                      cmp7$1_0
                                                                                      cmp8$1_0))
                                                                   (cmp10$1_0 (= v.0$1_0 0)))
                                                                  (let
                                                                     ((or.cond45$1_0 (and
                                                                                         or.cond44$1_0
                                                                                         cmp10$1_0)))
                                                                     (=>
                                                                        (not or.cond45$1_0)
                                                                        (let
                                                                           ((cmp17$1_0 (= v.0$1_0 0))
                                                                            (cmp19$1_0 (= pc.1$1_0 1)))
                                                                           (let
                                                                              ((or.cond47$1_0 (and
                                                                                                  cmp17$1_0
                                                                                                  cmp19$1_0))
                                                                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                              (let
                                                                                 ((or.cond48$1_0 (and
                                                                                                     or.cond47$1_0
                                                                                                     cmp21$1_0)))
                                                                                 (=>
                                                                                    (not or.cond48$1_0)
                                                                                    (let
                                                                                       ((cmp28$1_0 (= v.0$1_0 1))
                                                                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$1_0 (and
                                                                                                              cmp28$1_0
                                                                                                              cmp30$1_0))
                                                                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                          (let
                                                                                             ((or.cond51$1_0 (and
                                                                                                                 or.cond50$1_0
                                                                                                                 cmp32$1_0)))
                                                                                             (=>
                                                                                                or.cond51$1_0
                                                                                                (let
                                                                                                   ((inc34$1_0 (+ i.0$1_0 1)))
                                                                                                   (let
                                                                                                      ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                                                                       (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                                                                      (let
                                                                                                         ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                                                                         (let
                                                                                                            ((pc.1$1_0 .52$1_0)
                                                                                                             (i.0$1_0 inc34$1_0)
                                                                                                             (y.0$1_0 add35$1_0)
                                                                                                             (v.0$1_0 v.0$1_0))
                                                                                                            (let
                                                                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                               (not cmp5$1_0)))))))))))))))))))
                                                         (let
                                                            ((call$1_0 call$1_0_old)
                                                             (i.0$1_0 i.0$1_0_old)
                                                             (max$1_0 max$1_0_old)
                                                             (pc.1$1_0 pc.1$1_0_old))
                                                            (let
                                                               ((v.0$1_0 v.0$1_0_old)
                                                                (y.0$1_0 y.0$1_0_old)
                                                                (cmp7$1_0 (< call$1_0 max$1_0))
                                                                (cmp8$1_0 (= pc.1$1_0 0)))
                                                               (let
                                                                  ((or.cond44$1_0 (and
                                                                                      cmp7$1_0
                                                                                      cmp8$1_0))
                                                                   (cmp10$1_0 (= v.0$1_0 0)))
                                                                  (let
                                                                     ((or.cond45$1_0 (and
                                                                                         or.cond44$1_0
                                                                                         cmp10$1_0)))
                                                                     (=>
                                                                        (not or.cond45$1_0)
                                                                        (let
                                                                           ((cmp17$1_0 (= v.0$1_0 0))
                                                                            (cmp19$1_0 (= pc.1$1_0 1)))
                                                                           (let
                                                                              ((or.cond47$1_0 (and
                                                                                                  cmp17$1_0
                                                                                                  cmp19$1_0))
                                                                               (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                              (let
                                                                                 ((or.cond48$1_0 (and
                                                                                                     or.cond47$1_0
                                                                                                     cmp21$1_0)))
                                                                                 (=>
                                                                                    (not or.cond48$1_0)
                                                                                    (let
                                                                                       ((cmp28$1_0 (= v.0$1_0 1))
                                                                                        (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                       (let
                                                                                          ((or.cond50$1_0 (and
                                                                                                              cmp28$1_0
                                                                                                              cmp30$1_0))
                                                                                           (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                          (let
                                                                                             ((or.cond51$1_0 (and
                                                                                                                 or.cond50$1_0
                                                                                                                 cmp32$1_0)))
                                                                                             (=>
                                                                                                (not or.cond51$1_0)
                                                                                                (let
                                                                                                   ((pc.1$1_0 pc.1$1_0)
                                                                                                    (i.0$1_0 i.0$1_0)
                                                                                                    (y.0$1_0 y.0$1_0)
                                                                                                    (v.0$1_0 v.0$1_0))
                                                                                                   (let
                                                                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                      (not cmp5$1_0)))))))))))))))))
                                                      (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.1$2_0 pc.1$2_0_old))
            (let
               ((v.0$2_0 v.0$2_0_old)
                (y.0$2_0 y.0$2_0_old)
                (cmp7$2_0 (< call$2_0 max$2_0))
                (cmp8$2_0 (= pc.1$2_0 0)))
               (let
                  ((or.cond44$2_0 (and
                                      cmp7$2_0
                                      cmp8$2_0))
                   (cmp10$2_0 (= v.0$2_0 0)))
                  (let
                     ((or.cond45$2_0 (and
                                         or.cond44$2_0
                                         cmp10$2_0)))
                     (=>
                        (not or.cond45$2_0)
                        (let
                           ((cmp17$2_0 (= v.0$2_0 0))
                            (cmp19$2_0 (= pc.1$2_0 1)))
                           (let
                              ((or.cond47$2_0 (and
                                                  cmp17$2_0
                                                  cmp19$2_0))
                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                              (let
                                 ((or.cond48$2_0 (and
                                                     or.cond47$2_0
                                                     cmp21$2_0)))
                                 (=>
                                    (not or.cond48$2_0)
                                    (let
                                       ((cmp28$2_0 (= v.0$2_0 1))
                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                       (let
                                          ((or.cond50$2_0 (and
                                                              cmp28$2_0
                                                              cmp30$2_0))
                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                          (let
                                             ((or.cond51$2_0 (and
                                                                 or.cond50$2_0
                                                                 cmp32$2_0)))
                                             (=>
                                                or.cond51$2_0
                                                (let
                                                   ((inc34$2_0 (+ i.0$2_0 1)))
                                                   (let
                                                      ((add35$2_0 (+ y.0$2_0 y.0$2_0))
                                                       (cmp36$2_0 (= max$2_0 inc34$2_0)))
                                                      (let
                                                         ((.52$2_0 (ite cmp36$2_0 3 2)))
                                                         (let
                                                            ((pc.1$2_0 .52$2_0)
                                                             (i.0$2_0 inc34$2_0)
                                                             (y.0$2_0 add35$2_0)
                                                             (v.0$2_0 v.0$2_0))
                                                            (let
                                                               ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                               (=>
                                                                  cmp5$2_0
                                                                  (=>
                                                                     (and
                                                                        (let
                                                                           ((call$1_0 call$1_0_old)
                                                                            (i.0$1_0 i.0$1_0_old)
                                                                            (max$1_0 max$1_0_old)
                                                                            (pc.1$1_0 pc.1$1_0_old))
                                                                           (let
                                                                              ((v.0$1_0 v.0$1_0_old)
                                                                               (y.0$1_0 y.0$1_0_old)
                                                                               (cmp7$1_0 (< call$1_0 max$1_0))
                                                                               (cmp8$1_0 (= pc.1$1_0 0)))
                                                                              (let
                                                                                 ((or.cond44$1_0 (and
                                                                                                     cmp7$1_0
                                                                                                     cmp8$1_0))
                                                                                  (cmp10$1_0 (= v.0$1_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$1_0 (and
                                                                                                        or.cond44$1_0
                                                                                                        cmp10$1_0)))
                                                                                    (=>
                                                                                       or.cond45$1_0
                                                                                       (let
                                                                                          ((inc$1_0 (+ i.0$1_0 1)))
                                                                                          (let
                                                                                             ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                                                                                             (let
                                                                                                ((.46$1_0 (ite cmp12$1_0 1 0))
                                                                                                 (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                                                                                (let
                                                                                                   ((pc.1$1_0 .46$1_0)
                                                                                                    (i.0$1_0 inc$1_0)
                                                                                                    (y.0$1_0 add$1_0)
                                                                                                    (v.0$1_0 v.0$1_0))
                                                                                                   (let
                                                                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                      (not cmp5$1_0)))))))))))
                                                                        (let
                                                                           ((call$1_0 call$1_0_old)
                                                                            (i.0$1_0 i.0$1_0_old)
                                                                            (max$1_0 max$1_0_old)
                                                                            (pc.1$1_0 pc.1$1_0_old))
                                                                           (let
                                                                              ((v.0$1_0 v.0$1_0_old)
                                                                               (y.0$1_0 y.0$1_0_old)
                                                                               (cmp7$1_0 (< call$1_0 max$1_0))
                                                                               (cmp8$1_0 (= pc.1$1_0 0)))
                                                                              (let
                                                                                 ((or.cond44$1_0 (and
                                                                                                     cmp7$1_0
                                                                                                     cmp8$1_0))
                                                                                  (cmp10$1_0 (= v.0$1_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$1_0 (and
                                                                                                        or.cond44$1_0
                                                                                                        cmp10$1_0)))
                                                                                    (=>
                                                                                       (not or.cond45$1_0)
                                                                                       (let
                                                                                          ((cmp17$1_0 (= v.0$1_0 0))
                                                                                           (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$1_0 (and
                                                                                                                 cmp17$1_0
                                                                                                                 cmp19$1_0))
                                                                                              (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                             (let
                                                                                                ((or.cond48$1_0 (and
                                                                                                                    or.cond47$1_0
                                                                                                                    cmp21$1_0)))
                                                                                                (=>
                                                                                                   or.cond48$1_0
                                                                                                   (let
                                                                                                      ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                                                                                      (let
                                                                                                         ((.49$1_0 (ite cmp23$1_0 3 2)))
                                                                                                         (let
                                                                                                            ((pc.1$1_0 .49$1_0)
                                                                                                             (i.0$1_0 i.0$1_0)
                                                                                                             (y.0$1_0 y.0$1_0)
                                                                                                             (v.0$1_0 1))
                                                                                                            (let
                                                                                                               ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                               (not cmp5$1_0))))))))))))))
                                                                        (let
                                                                           ((call$1_0 call$1_0_old)
                                                                            (i.0$1_0 i.0$1_0_old)
                                                                            (max$1_0 max$1_0_old)
                                                                            (pc.1$1_0 pc.1$1_0_old))
                                                                           (let
                                                                              ((v.0$1_0 v.0$1_0_old)
                                                                               (y.0$1_0 y.0$1_0_old)
                                                                               (cmp7$1_0 (< call$1_0 max$1_0))
                                                                               (cmp8$1_0 (= pc.1$1_0 0)))
                                                                              (let
                                                                                 ((or.cond44$1_0 (and
                                                                                                     cmp7$1_0
                                                                                                     cmp8$1_0))
                                                                                  (cmp10$1_0 (= v.0$1_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$1_0 (and
                                                                                                        or.cond44$1_0
                                                                                                        cmp10$1_0)))
                                                                                    (=>
                                                                                       (not or.cond45$1_0)
                                                                                       (let
                                                                                          ((cmp17$1_0 (= v.0$1_0 0))
                                                                                           (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$1_0 (and
                                                                                                                 cmp17$1_0
                                                                                                                 cmp19$1_0))
                                                                                              (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                             (let
                                                                                                ((or.cond48$1_0 (and
                                                                                                                    or.cond47$1_0
                                                                                                                    cmp21$1_0)))
                                                                                                (=>
                                                                                                   (not or.cond48$1_0)
                                                                                                   (let
                                                                                                      ((cmp28$1_0 (= v.0$1_0 1))
                                                                                                       (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                                      (let
                                                                                                         ((or.cond50$1_0 (and
                                                                                                                             cmp28$1_0
                                                                                                                             cmp30$1_0))
                                                                                                          (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                                         (let
                                                                                                            ((or.cond51$1_0 (and
                                                                                                                                or.cond50$1_0
                                                                                                                                cmp32$1_0)))
                                                                                                            (=>
                                                                                                               or.cond51$1_0
                                                                                                               (let
                                                                                                                  ((inc34$1_0 (+ i.0$1_0 1)))
                                                                                                                  (let
                                                                                                                     ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                                                                                      (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                                                                                     (let
                                                                                                                        ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                                                                                        (let
                                                                                                                           ((pc.1$1_0 .52$1_0)
                                                                                                                            (i.0$1_0 inc34$1_0)
                                                                                                                            (y.0$1_0 add35$1_0)
                                                                                                                            (v.0$1_0 v.0$1_0))
                                                                                                                           (let
                                                                                                                              ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                                              (not cmp5$1_0)))))))))))))))))))
                                                                        (let
                                                                           ((call$1_0 call$1_0_old)
                                                                            (i.0$1_0 i.0$1_0_old)
                                                                            (max$1_0 max$1_0_old)
                                                                            (pc.1$1_0 pc.1$1_0_old))
                                                                           (let
                                                                              ((v.0$1_0 v.0$1_0_old)
                                                                               (y.0$1_0 y.0$1_0_old)
                                                                               (cmp7$1_0 (< call$1_0 max$1_0))
                                                                               (cmp8$1_0 (= pc.1$1_0 0)))
                                                                              (let
                                                                                 ((or.cond44$1_0 (and
                                                                                                     cmp7$1_0
                                                                                                     cmp8$1_0))
                                                                                  (cmp10$1_0 (= v.0$1_0 0)))
                                                                                 (let
                                                                                    ((or.cond45$1_0 (and
                                                                                                        or.cond44$1_0
                                                                                                        cmp10$1_0)))
                                                                                    (=>
                                                                                       (not or.cond45$1_0)
                                                                                       (let
                                                                                          ((cmp17$1_0 (= v.0$1_0 0))
                                                                                           (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                          (let
                                                                                             ((or.cond47$1_0 (and
                                                                                                                 cmp17$1_0
                                                                                                                 cmp19$1_0))
                                                                                              (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                             (let
                                                                                                ((or.cond48$1_0 (and
                                                                                                                    or.cond47$1_0
                                                                                                                    cmp21$1_0)))
                                                                                                (=>
                                                                                                   (not or.cond48$1_0)
                                                                                                   (let
                                                                                                      ((cmp28$1_0 (= v.0$1_0 1))
                                                                                                       (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                                      (let
                                                                                                         ((or.cond50$1_0 (and
                                                                                                                             cmp28$1_0
                                                                                                                             cmp30$1_0))
                                                                                                          (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                                         (let
                                                                                                            ((or.cond51$1_0 (and
                                                                                                                                or.cond50$1_0
                                                                                                                                cmp32$1_0)))
                                                                                                            (=>
                                                                                                               (not or.cond51$1_0)
                                                                                                               (let
                                                                                                                  ((pc.1$1_0 pc.1$1_0)
                                                                                                                   (i.0$1_0 i.0$1_0)
                                                                                                                   (y.0$1_0 y.0$1_0)
                                                                                                                   (v.0$1_0 v.0$1_0))
                                                                                                                  (let
                                                                                                                     ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                                     (not cmp5$1_0)))))))))))))))))
                                                                     (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.1$1_0_old Int)
       (v.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.1$2_0_old Int)
       (v.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.1$2_0_old v.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.1$2_0 pc.1$2_0_old))
            (let
               ((v.0$2_0 v.0$2_0_old)
                (y.0$2_0 y.0$2_0_old)
                (cmp7$2_0 (< call$2_0 max$2_0))
                (cmp8$2_0 (= pc.1$2_0 0)))
               (let
                  ((or.cond44$2_0 (and
                                      cmp7$2_0
                                      cmp8$2_0))
                   (cmp10$2_0 (= v.0$2_0 0)))
                  (let
                     ((or.cond45$2_0 (and
                                         or.cond44$2_0
                                         cmp10$2_0)))
                     (=>
                        (not or.cond45$2_0)
                        (let
                           ((cmp17$2_0 (= v.0$2_0 0))
                            (cmp19$2_0 (= pc.1$2_0 1)))
                           (let
                              ((or.cond47$2_0 (and
                                                  cmp17$2_0
                                                  cmp19$2_0))
                               (cmp21$2_0 (>= i.0$2_0 call$2_0)))
                              (let
                                 ((or.cond48$2_0 (and
                                                     or.cond47$2_0
                                                     cmp21$2_0)))
                                 (=>
                                    (not or.cond48$2_0)
                                    (let
                                       ((cmp28$2_0 (= v.0$2_0 1))
                                        (cmp30$2_0 (= pc.1$2_0 2)))
                                       (let
                                          ((or.cond50$2_0 (and
                                                              cmp28$2_0
                                                              cmp30$2_0))
                                           (cmp32$2_0 (< i.0$2_0 max$2_0)))
                                          (let
                                             ((or.cond51$2_0 (and
                                                                 or.cond50$2_0
                                                                 cmp32$2_0)))
                                             (=>
                                                (not or.cond51$2_0)
                                                (let
                                                   ((pc.1$2_0 pc.1$2_0)
                                                    (i.0$2_0 i.0$2_0)
                                                    (y.0$2_0 y.0$2_0)
                                                    (v.0$2_0 v.0$2_0))
                                                   (let
                                                      ((cmp5$2_0 (distinct i.0$2_0 max$2_0)))
                                                      (=>
                                                         cmp5$2_0
                                                         (=>
                                                            (and
                                                               (let
                                                                  ((call$1_0 call$1_0_old)
                                                                   (i.0$1_0 i.0$1_0_old)
                                                                   (max$1_0 max$1_0_old)
                                                                   (pc.1$1_0 pc.1$1_0_old))
                                                                  (let
                                                                     ((v.0$1_0 v.0$1_0_old)
                                                                      (y.0$1_0 y.0$1_0_old)
                                                                      (cmp7$1_0 (< call$1_0 max$1_0))
                                                                      (cmp8$1_0 (= pc.1$1_0 0)))
                                                                     (let
                                                                        ((or.cond44$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp8$1_0))
                                                                         (cmp10$1_0 (= v.0$1_0 0)))
                                                                        (let
                                                                           ((or.cond45$1_0 (and
                                                                                               or.cond44$1_0
                                                                                               cmp10$1_0)))
                                                                           (=>
                                                                              or.cond45$1_0
                                                                              (let
                                                                                 ((inc$1_0 (+ i.0$1_0 1)))
                                                                                 (let
                                                                                    ((cmp12$1_0 (<= call$1_0 inc$1_0)))
                                                                                    (let
                                                                                       ((.46$1_0 (ite cmp12$1_0 1 0))
                                                                                        (add$1_0 (+ y.0$1_0 y.0$1_0)))
                                                                                       (let
                                                                                          ((pc.1$1_0 .46$1_0)
                                                                                           (i.0$1_0 inc$1_0)
                                                                                           (y.0$1_0 add$1_0)
                                                                                           (v.0$1_0 v.0$1_0))
                                                                                          (let
                                                                                             ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                             (not cmp5$1_0)))))))))))
                                                               (let
                                                                  ((call$1_0 call$1_0_old)
                                                                   (i.0$1_0 i.0$1_0_old)
                                                                   (max$1_0 max$1_0_old)
                                                                   (pc.1$1_0 pc.1$1_0_old))
                                                                  (let
                                                                     ((v.0$1_0 v.0$1_0_old)
                                                                      (y.0$1_0 y.0$1_0_old)
                                                                      (cmp7$1_0 (< call$1_0 max$1_0))
                                                                      (cmp8$1_0 (= pc.1$1_0 0)))
                                                                     (let
                                                                        ((or.cond44$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp8$1_0))
                                                                         (cmp10$1_0 (= v.0$1_0 0)))
                                                                        (let
                                                                           ((or.cond45$1_0 (and
                                                                                               or.cond44$1_0
                                                                                               cmp10$1_0)))
                                                                           (=>
                                                                              (not or.cond45$1_0)
                                                                              (let
                                                                                 ((cmp17$1_0 (= v.0$1_0 0))
                                                                                  (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$1_0 (and
                                                                                                        cmp17$1_0
                                                                                                        cmp19$1_0))
                                                                                     (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                    (let
                                                                                       ((or.cond48$1_0 (and
                                                                                                           or.cond47$1_0
                                                                                                           cmp21$1_0)))
                                                                                       (=>
                                                                                          or.cond48$1_0
                                                                                          (let
                                                                                             ((cmp23$1_0 (<= max$1_0 i.0$1_0)))
                                                                                             (let
                                                                                                ((.49$1_0 (ite cmp23$1_0 3 2)))
                                                                                                (let
                                                                                                   ((pc.1$1_0 .49$1_0)
                                                                                                    (i.0$1_0 i.0$1_0)
                                                                                                    (y.0$1_0 y.0$1_0)
                                                                                                    (v.0$1_0 1))
                                                                                                   (let
                                                                                                      ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                      (not cmp5$1_0))))))))))))))
                                                               (let
                                                                  ((call$1_0 call$1_0_old)
                                                                   (i.0$1_0 i.0$1_0_old)
                                                                   (max$1_0 max$1_0_old)
                                                                   (pc.1$1_0 pc.1$1_0_old))
                                                                  (let
                                                                     ((v.0$1_0 v.0$1_0_old)
                                                                      (y.0$1_0 y.0$1_0_old)
                                                                      (cmp7$1_0 (< call$1_0 max$1_0))
                                                                      (cmp8$1_0 (= pc.1$1_0 0)))
                                                                     (let
                                                                        ((or.cond44$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp8$1_0))
                                                                         (cmp10$1_0 (= v.0$1_0 0)))
                                                                        (let
                                                                           ((or.cond45$1_0 (and
                                                                                               or.cond44$1_0
                                                                                               cmp10$1_0)))
                                                                           (=>
                                                                              (not or.cond45$1_0)
                                                                              (let
                                                                                 ((cmp17$1_0 (= v.0$1_0 0))
                                                                                  (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$1_0 (and
                                                                                                        cmp17$1_0
                                                                                                        cmp19$1_0))
                                                                                     (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                    (let
                                                                                       ((or.cond48$1_0 (and
                                                                                                           or.cond47$1_0
                                                                                                           cmp21$1_0)))
                                                                                       (=>
                                                                                          (not or.cond48$1_0)
                                                                                          (let
                                                                                             ((cmp28$1_0 (= v.0$1_0 1))
                                                                                              (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                             (let
                                                                                                ((or.cond50$1_0 (and
                                                                                                                    cmp28$1_0
                                                                                                                    cmp30$1_0))
                                                                                                 (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                                (let
                                                                                                   ((or.cond51$1_0 (and
                                                                                                                       or.cond50$1_0
                                                                                                                       cmp32$1_0)))
                                                                                                   (=>
                                                                                                      or.cond51$1_0
                                                                                                      (let
                                                                                                         ((inc34$1_0 (+ i.0$1_0 1)))
                                                                                                         (let
                                                                                                            ((add35$1_0 (+ y.0$1_0 y.0$1_0))
                                                                                                             (cmp36$1_0 (= max$1_0 inc34$1_0)))
                                                                                                            (let
                                                                                                               ((.52$1_0 (ite cmp36$1_0 3 2)))
                                                                                                               (let
                                                                                                                  ((pc.1$1_0 .52$1_0)
                                                                                                                   (i.0$1_0 inc34$1_0)
                                                                                                                   (y.0$1_0 add35$1_0)
                                                                                                                   (v.0$1_0 v.0$1_0))
                                                                                                                  (let
                                                                                                                     ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                                     (not cmp5$1_0)))))))))))))))))))
                                                               (let
                                                                  ((call$1_0 call$1_0_old)
                                                                   (i.0$1_0 i.0$1_0_old)
                                                                   (max$1_0 max$1_0_old)
                                                                   (pc.1$1_0 pc.1$1_0_old))
                                                                  (let
                                                                     ((v.0$1_0 v.0$1_0_old)
                                                                      (y.0$1_0 y.0$1_0_old)
                                                                      (cmp7$1_0 (< call$1_0 max$1_0))
                                                                      (cmp8$1_0 (= pc.1$1_0 0)))
                                                                     (let
                                                                        ((or.cond44$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp8$1_0))
                                                                         (cmp10$1_0 (= v.0$1_0 0)))
                                                                        (let
                                                                           ((or.cond45$1_0 (and
                                                                                               or.cond44$1_0
                                                                                               cmp10$1_0)))
                                                                           (=>
                                                                              (not or.cond45$1_0)
                                                                              (let
                                                                                 ((cmp17$1_0 (= v.0$1_0 0))
                                                                                  (cmp19$1_0 (= pc.1$1_0 1)))
                                                                                 (let
                                                                                    ((or.cond47$1_0 (and
                                                                                                        cmp17$1_0
                                                                                                        cmp19$1_0))
                                                                                     (cmp21$1_0 (>= i.0$1_0 call$1_0)))
                                                                                    (let
                                                                                       ((or.cond48$1_0 (and
                                                                                                           or.cond47$1_0
                                                                                                           cmp21$1_0)))
                                                                                       (=>
                                                                                          (not or.cond48$1_0)
                                                                                          (let
                                                                                             ((cmp28$1_0 (= v.0$1_0 1))
                                                                                              (cmp30$1_0 (= pc.1$1_0 2)))
                                                                                             (let
                                                                                                ((or.cond50$1_0 (and
                                                                                                                    cmp28$1_0
                                                                                                                    cmp30$1_0))
                                                                                                 (cmp32$1_0 (< i.0$1_0 max$1_0)))
                                                                                                (let
                                                                                                   ((or.cond51$1_0 (and
                                                                                                                       or.cond50$1_0
                                                                                                                       cmp32$1_0)))
                                                                                                   (=>
                                                                                                      (not or.cond51$1_0)
                                                                                                      (let
                                                                                                         ((pc.1$1_0 pc.1$1_0)
                                                                                                          (i.0$1_0 i.0$1_0)
                                                                                                          (y.0$1_0 y.0$1_0)
                                                                                                          (v.0$1_0 v.0$1_0))
                                                                                                         (let
                                                                                                            ((cmp5$1_0 (distinct i.0$1_0 max$1_0)))
                                                                                                            (not cmp5$1_0)))))))))))))))))
                                                            (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.1$1_0_old v.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.1$2_0 v.0$2_0 y.0$2_0)))))))))))))))))))))
(check-sat)
(get-model)
