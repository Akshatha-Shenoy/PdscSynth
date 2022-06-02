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
; :annot (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    cmp2$2_0
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call2__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0))
                                              (cmp1$1_0 (<= max$1_0 call$1_0)))
                                             (let
                                                ((or.cond$1_0 (or
                                                                  cmp$1_0
                                                                  cmp1$1_0)))
                                                (=>
                                                   or.cond$1_0
                                                   (let
                                                      ((retval.0$1_0 (- 1)))
                                                      (let
                                                         ((result$1 retval.0$1_0))
                                                         false)))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    cmp2$2_0
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call2__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0))
                                              (cmp1$1_0 (<= max$1_0 call$1_0)))
                                             (let
                                                ((or.cond$1_0 (or
                                                                  cmp$1_0
                                                                  cmp1$1_0)))
                                                (=>
                                                   (not or.cond$1_0)
                                                   (let
                                                      ((y.0$1_0 0)
                                                       (i.0$1_0 0)
                                                       (pc.0$1_0 0))
                                                      (let
                                                         ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                         (=>
                                                            (not cmp2$1_0)
                                                            (let
                                                               ((retval.0$1_0 y.0$1_0))
                                                               (let
                                                                  ((result$1 retval.0$1_0))
                                                                  false))))))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           or.cond$2_0
                           (let
                              ((retval.0$2_0 (- 1)))
                              (let
                                 ((result$2 retval.0$2_0))
                                 (forall
                                    ((call$1_0 Int))
                                    (=>
                                       (INV_REC_call2__1 call$1_0)
                                       (let
                                          ((cmp$1_0 (<= call$1_0 0))
                                           (cmp1$1_0 (<= max$1_0 call$1_0)))
                                          (let
                                             ((or.cond$1_0 (or
                                                               cmp$1_0
                                                               cmp1$1_0)))
                                             (=>
                                                (not or.cond$1_0)
                                                (let
                                                   ((y.0$1_0 0)
                                                    (i.0$1_0 0)
                                                    (pc.0$1_0 0))
                                                   (let
                                                      ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                      (not cmp2$1_0)))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    (not cmp2$2_0)
                                    (let
                                       ((retval.0$2_0 y.0$2_0))
                                       (let
                                          ((result$2 retval.0$2_0))
                                          (forall
                                             ((call$1_0 Int))
                                             (=>
                                                (INV_REC_call2__1 call$1_0)
                                                (let
                                                   ((cmp$1_0 (<= call$1_0 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp$1_0
                                                                        cmp1$1_0)))
                                                      (=>
                                                         (not or.cond$1_0)
                                                         (let
                                                            ((y.0$1_0 0)
                                                             (i.0$1_0 0)
                                                             (pc.0$1_0 0))
                                                            (let
                                                               ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                               (not cmp2$1_0))))))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           or.cond$2_0
                           (let
                              ((retval.0$2_0 (- 1)))
                              (let
                                 ((result$2 retval.0$2_0))
                                 (forall
                                    ((call$1_0 Int))
                                    (=>
                                       (INV_REC_call2__1 call$1_0)
                                       (let
                                          ((cmp$1_0 (<= call$1_0 0))
                                           (cmp1$1_0 (<= max$1_0 call$1_0)))
                                          (let
                                             ((or.cond$1_0 (or
                                                               cmp$1_0
                                                               cmp1$1_0)))
                                             (=>
                                                or.cond$1_0
                                                (let
                                                   ((retval.0$1_0 (- 1)))
                                                   (let
                                                      ((result$1 retval.0$1_0))
                                                      (OUT_INV result$1 result$2)))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    (not cmp2$2_0)
                                    (let
                                       ((retval.0$2_0 y.0$2_0))
                                       (let
                                          ((result$2 retval.0$2_0))
                                          (forall
                                             ((call$1_0 Int))
                                             (=>
                                                (INV_REC_call2__1 call$1_0)
                                                (let
                                                   ((cmp$1_0 (<= call$1_0 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp$1_0
                                                                        cmp1$1_0)))
                                                      (=>
                                                         or.cond$1_0
                                                         (let
                                                            ((retval.0$1_0 (- 1)))
                                                            (let
                                                               ((result$1 retval.0$1_0))
                                                               (OUT_INV result$1 result$2))))))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           or.cond$2_0
                           (let
                              ((retval.0$2_0 (- 1)))
                              (let
                                 ((result$2 retval.0$2_0))
                                 (forall
                                    ((call$1_0 Int))
                                    (=>
                                       (INV_REC_call2__1 call$1_0)
                                       (let
                                          ((cmp$1_0 (<= call$1_0 0))
                                           (cmp1$1_0 (<= max$1_0 call$1_0)))
                                          (let
                                             ((or.cond$1_0 (or
                                                               cmp$1_0
                                                               cmp1$1_0)))
                                             (=>
                                                (not or.cond$1_0)
                                                (let
                                                   ((y.0$1_0 0)
                                                    (i.0$1_0 0)
                                                    (pc.0$1_0 0))
                                                   (let
                                                      ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                      (=>
                                                         (not cmp2$1_0)
                                                         (let
                                                            ((retval.0$1_0 y.0$1_0))
                                                            (let
                                                               ((result$1 retval.0$1_0))
                                                               (OUT_INV result$1 result$2))))))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    (not cmp2$2_0)
                                    (let
                                       ((retval.0$2_0 y.0$2_0))
                                       (let
                                          ((result$2 retval.0$2_0))
                                          (forall
                                             ((call$1_0 Int))
                                             (=>
                                                (INV_REC_call2__1 call$1_0)
                                                (let
                                                   ((cmp$1_0 (<= call$1_0 0))
                                                    (cmp1$1_0 (<= max$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond$1_0 (or
                                                                        cmp$1_0
                                                                        cmp1$1_0)))
                                                      (=>
                                                         (not or.cond$1_0)
                                                         (let
                                                            ((y.0$1_0 0)
                                                             (i.0$1_0 0)
                                                             (pc.0$1_0 0))
                                                            (let
                                                               ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                               (=>
                                                                  (not cmp2$1_0)
                                                                  (let
                                                                     ((retval.0$1_0 y.0$1_0))
                                                                     (let
                                                                        ((result$1 retval.0$1_0))
                                                                        (OUT_INV result$1 result$2)))))))))))))))))))))))))
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
                  (INV_REC_call1__2 call$2_0)
                  (let
                     ((cmp$2_0 (<= call$2_0 0))
                      (cmp1$2_0 (<= max$2_0 call$2_0)))
                     (let
                        ((or.cond$2_0 (or
                                          cmp$2_0
                                          cmp1$2_0)))
                        (=>
                           (not or.cond$2_0)
                           (let
                              ((y.0$2_0 0)
                               (i.0$2_0 0)
                               (pc.0$2_0 0))
                              (let
                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                 (=>
                                    cmp2$2_0
                                    (forall
                                       ((call$1_0 Int))
                                       (=>
                                          (INV_REC_call2__1 call$1_0)
                                          (let
                                             ((cmp$1_0 (<= call$1_0 0))
                                              (cmp1$1_0 (<= max$1_0 call$1_0)))
                                             (let
                                                ((or.cond$1_0 (or
                                                                  cmp$1_0
                                                                  cmp1$1_0)))
                                                (=>
                                                   (not or.cond$1_0)
                                                   (let
                                                      ((y.0$1_0 0)
                                                       (i.0$1_0 0)
                                                       (pc.0$1_0 0))
                                                      (let
                                                         ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                         (=>
                                                            cmp2$1_0
                                                            (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    (not cmp2$1_0)
                                    (let
                                       ((retval.0$1_0 y.0$1_0))
                                       (let
                                          ((result$1 retval.0$1_0)
                                           (call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   or.cond22$2_0
                                                   (let
                                                      ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                       (inc$2_0 (+ i.0$2_0 1)))
                                                      (let
                                                         ((y.0$2_0 add$2_0)
                                                          (i.0$2_0 inc$2_0)
                                                          (pc.0$2_0 pc.0$2_0))
                                                         (let
                                                            ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                            (=>
                                                               (not cmp2$2_0)
                                                               (let
                                                                  ((retval.0$2_0 y.0$2_0))
                                                                  (let
                                                                     ((result$2 retval.0$2_0))
                                                                     (OUT_INV result$1 result$2))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    (not cmp2$1_0)
                                    (let
                                       ((retval.0$1_0 y.0$1_0))
                                       (let
                                          ((result$1 retval.0$1_0)
                                           (call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   (not or.cond22$2_0)
                                                   (let
                                                      ((cmp7$2_0 (= pc.0$2_0 0))
                                                       (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                      (let
                                                         ((or.cond23$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp9$2_0)))
                                                         (=>
                                                            or.cond23$2_0
                                                            (let
                                                               ((y.0$2_0 y.0$2_0)
                                                                (i.0$2_0 i.0$2_0)
                                                                (pc.0$2_0 1))
                                                               (let
                                                                  ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                  (=>
                                                                     (not cmp2$2_0)
                                                                     (let
                                                                        ((retval.0$2_0 y.0$2_0))
                                                                        (let
                                                                           ((result$2 retval.0$2_0))
                                                                           (OUT_INV result$1 result$2))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    (not cmp2$1_0)
                                    (let
                                       ((retval.0$1_0 y.0$1_0))
                                       (let
                                          ((result$1 retval.0$1_0)
                                           (call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   (not or.cond22$2_0)
                                                   (let
                                                      ((cmp7$2_0 (= pc.0$2_0 0))
                                                       (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                      (let
                                                         ((or.cond23$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp9$2_0)))
                                                         (=>
                                                            (not or.cond23$2_0)
                                                            (let
                                                               ((cmp12$2_0 (= pc.0$2_0 1))
                                                                (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                               (let
                                                                  ((or.cond24$2_0 (and
                                                                                      cmp12$2_0
                                                                                      cmp14$2_0))
                                                                   (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                   (inc17$2_0 (+ i.0$2_0 1)))
                                                                  (let
                                                                     ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                      (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                     (let
                                                                        ((y.0$2_0 y.1$2_0)
                                                                         (i.0$2_0 i.1$2_0)
                                                                         (pc.0$2_0 pc.0$2_0))
                                                                        (let
                                                                           ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                           (=>
                                                                              (not cmp2$2_0)
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
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       (not cmp2$1_0)
                                       (let
                                          ((retval.0$1_0 y.0$1_0))
                                          (let
                                             ((result$1 retval.0$1_0)
                                              (call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      or.cond22$2_0
                                                      (let
                                                         ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                          (inc$2_0 (+ i.0$2_0 1)))
                                                         (let
                                                            ((y.0$2_0 add$2_0)
                                                             (i.0$2_0 inc$2_0)
                                                             (pc.0$2_0 pc.0$2_0))
                                                            (let
                                                               ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                               (=>
                                                                  (not cmp2$2_0)
                                                                  (let
                                                                     ((retval.0$2_0 y.0$2_0))
                                                                     (let
                                                                        ((result$2 retval.0$2_0))
                                                                        (OUT_INV result$1 result$2)))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       (not cmp2$1_0)
                                       (let
                                          ((retval.0$1_0 y.0$1_0))
                                          (let
                                             ((result$1 retval.0$1_0)
                                              (call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      (not or.cond22$2_0)
                                                      (let
                                                         ((cmp7$2_0 (= pc.0$2_0 0))
                                                          (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond23$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp9$2_0)))
                                                            (=>
                                                               or.cond23$2_0
                                                               (let
                                                                  ((y.0$2_0 y.0$2_0)
                                                                   (i.0$2_0 i.0$2_0)
                                                                   (pc.0$2_0 1))
                                                                  (let
                                                                     ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                     (=>
                                                                        (not cmp2$2_0)
                                                                        (let
                                                                           ((retval.0$2_0 y.0$2_0))
                                                                           (let
                                                                              ((result$2 retval.0$2_0))
                                                                              (OUT_INV result$1 result$2)))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       (not cmp2$1_0)
                                       (let
                                          ((retval.0$1_0 y.0$1_0))
                                          (let
                                             ((result$1 retval.0$1_0)
                                              (call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      (not or.cond22$2_0)
                                                      (let
                                                         ((cmp7$2_0 (= pc.0$2_0 0))
                                                          (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond23$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp9$2_0)))
                                                            (=>
                                                               (not or.cond23$2_0)
                                                               (let
                                                                  ((cmp12$2_0 (= pc.0$2_0 1))
                                                                   (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                  (let
                                                                     ((or.cond24$2_0 (and
                                                                                         cmp12$2_0
                                                                                         cmp14$2_0))
                                                                      (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                      (inc17$2_0 (+ i.0$2_0 1)))
                                                                     (let
                                                                        ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                         (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                        (let
                                                                           ((y.0$2_0 y.1$2_0)
                                                                            (i.0$2_0 i.1$2_0)
                                                                            (pc.0$2_0 pc.0$2_0))
                                                                           (let
                                                                              ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                              (=>
                                                                                 (not cmp2$2_0)
                                                                                 (let
                                                                                    ((retval.0$2_0 y.0$2_0))
                                                                                    (let
                                                                                       ((result$2 retval.0$2_0))
                                                                                       (OUT_INV result$1 result$2))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp2$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.0$2_0 pc.0$2_0_old))
                                                         (let
                                                            ((y.0$2_0 y.0$2_0_old)
                                                             (cmp4$2_0 (= pc.0$2_0 0))
                                                             (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                            (let
                                                               ((or.cond22$2_0 (and
                                                                                   cmp4$2_0
                                                                                   cmp5$2_0)))
                                                               (=>
                                                                  or.cond22$2_0
                                                                  (let
                                                                     ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                                      (inc$2_0 (+ i.0$2_0 1)))
                                                                     (let
                                                                        ((y.0$2_0 add$2_0)
                                                                         (i.0$2_0 inc$2_0)
                                                                         (pc.0$2_0 pc.0$2_0))
                                                                        (let
                                                                           ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                           (=>
                                                                              (not cmp2$2_0)
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
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp2$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.0$2_0 pc.0$2_0_old))
                                                         (let
                                                            ((y.0$2_0 y.0$2_0_old)
                                                             (cmp4$2_0 (= pc.0$2_0 0))
                                                             (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                            (let
                                                               ((or.cond22$2_0 (and
                                                                                   cmp4$2_0
                                                                                   cmp5$2_0)))
                                                               (=>
                                                                  (not or.cond22$2_0)
                                                                  (let
                                                                     ((cmp7$2_0 (= pc.0$2_0 0))
                                                                      (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                     (let
                                                                        ((or.cond23$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp9$2_0)))
                                                                        (=>
                                                                           or.cond23$2_0
                                                                           (let
                                                                              ((y.0$2_0 y.0$2_0)
                                                                               (i.0$2_0 i.0$2_0)
                                                                               (pc.0$2_0 1))
                                                                              (let
                                                                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                 (=>
                                                                                    (not cmp2$2_0)
                                                                                    (let
                                                                                       ((retval.0$2_0 y.0$2_0))
                                                                                       (let
                                                                                          ((result$2 retval.0$2_0))
                                                                                          (OUT_INV result$1 result$2)))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   (not cmp2$1_0)
                                                   (let
                                                      ((retval.0$1_0 y.0$1_0))
                                                      (let
                                                         ((result$1 retval.0$1_0)
                                                          (call$2_0 call$2_0_old)
                                                          (i.0$2_0 i.0$2_0_old)
                                                          (max$2_0 max$2_0_old)
                                                          (pc.0$2_0 pc.0$2_0_old))
                                                         (let
                                                            ((y.0$2_0 y.0$2_0_old)
                                                             (cmp4$2_0 (= pc.0$2_0 0))
                                                             (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                            (let
                                                               ((or.cond22$2_0 (and
                                                                                   cmp4$2_0
                                                                                   cmp5$2_0)))
                                                               (=>
                                                                  (not or.cond22$2_0)
                                                                  (let
                                                                     ((cmp7$2_0 (= pc.0$2_0 0))
                                                                      (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                     (let
                                                                        ((or.cond23$2_0 (and
                                                                                            cmp7$2_0
                                                                                            cmp9$2_0)))
                                                                        (=>
                                                                           (not or.cond23$2_0)
                                                                           (let
                                                                              ((cmp12$2_0 (= pc.0$2_0 1))
                                                                               (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                              (let
                                                                                 ((or.cond24$2_0 (and
                                                                                                     cmp12$2_0
                                                                                                     cmp14$2_0))
                                                                                  (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                                  (inc17$2_0 (+ i.0$2_0 1)))
                                                                                 (let
                                                                                    ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                                     (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                                    (let
                                                                                       ((y.0$2_0 y.1$2_0)
                                                                                        (i.0$2_0 i.1$2_0)
                                                                                        (pc.0$2_0 pc.0$2_0))
                                                                                       (let
                                                                                          ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                          (=>
                                                                                             (not cmp2$2_0)
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
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    cmp2$1_0
                                    (let
                                       ((call$2_0 call$2_0_old)
                                        (i.0$2_0 i.0$2_0_old)
                                        (max$2_0 max$2_0_old)
                                        (pc.0$2_0 pc.0$2_0_old))
                                       (let
                                          ((y.0$2_0 y.0$2_0_old)
                                           (cmp4$2_0 (= pc.0$2_0 0))
                                           (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                          (let
                                             ((or.cond22$2_0 (and
                                                                 cmp4$2_0
                                                                 cmp5$2_0)))
                                             (=>
                                                or.cond22$2_0
                                                (let
                                                   ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                    (inc$2_0 (+ i.0$2_0 1)))
                                                   (let
                                                      ((y.0$2_0 add$2_0)
                                                       (i.0$2_0 inc$2_0)
                                                       (pc.0$2_0 pc.0$2_0))
                                                      (let
                                                         ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                         (=>
                                                            cmp2$2_0
                                                            (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    cmp2$1_0
                                    (let
                                       ((call$2_0 call$2_0_old)
                                        (i.0$2_0 i.0$2_0_old)
                                        (max$2_0 max$2_0_old)
                                        (pc.0$2_0 pc.0$2_0_old))
                                       (let
                                          ((y.0$2_0 y.0$2_0_old)
                                           (cmp4$2_0 (= pc.0$2_0 0))
                                           (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                          (let
                                             ((or.cond22$2_0 (and
                                                                 cmp4$2_0
                                                                 cmp5$2_0)))
                                             (=>
                                                (not or.cond22$2_0)
                                                (let
                                                   ((cmp7$2_0 (= pc.0$2_0 0))
                                                    (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                   (let
                                                      ((or.cond23$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp9$2_0)))
                                                      (=>
                                                         or.cond23$2_0
                                                         (let
                                                            ((y.0$2_0 y.0$2_0)
                                                             (i.0$2_0 i.0$2_0)
                                                             (pc.0$2_0 1))
                                                            (let
                                                               ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                               (=>
                                                                  cmp2$2_0
                                                                  (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    cmp2$1_0
                                    (let
                                       ((call$2_0 call$2_0_old)
                                        (i.0$2_0 i.0$2_0_old)
                                        (max$2_0 max$2_0_old)
                                        (pc.0$2_0 pc.0$2_0_old))
                                       (let
                                          ((y.0$2_0 y.0$2_0_old)
                                           (cmp4$2_0 (= pc.0$2_0 0))
                                           (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                          (let
                                             ((or.cond22$2_0 (and
                                                                 cmp4$2_0
                                                                 cmp5$2_0)))
                                             (=>
                                                (not or.cond22$2_0)
                                                (let
                                                   ((cmp7$2_0 (= pc.0$2_0 0))
                                                    (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                   (let
                                                      ((or.cond23$2_0 (and
                                                                          cmp7$2_0
                                                                          cmp9$2_0)))
                                                      (=>
                                                         (not or.cond23$2_0)
                                                         (let
                                                            ((cmp12$2_0 (= pc.0$2_0 1))
                                                             (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                            (let
                                                               ((or.cond24$2_0 (and
                                                                                   cmp12$2_0
                                                                                   cmp14$2_0))
                                                                (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                (inc17$2_0 (+ i.0$2_0 1)))
                                                               (let
                                                                  ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                   (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                  (let
                                                                     ((y.0$2_0 y.1$2_0)
                                                                      (i.0$2_0 i.1$2_0)
                                                                      (pc.0$2_0 pc.0$2_0))
                                                                     (let
                                                                        ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                        (=>
                                                                           cmp2$2_0
                                                                           (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       cmp2$1_0
                                       (let
                                          ((call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   or.cond22$2_0
                                                   (let
                                                      ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                       (inc$2_0 (+ i.0$2_0 1)))
                                                      (let
                                                         ((y.0$2_0 add$2_0)
                                                          (i.0$2_0 inc$2_0)
                                                          (pc.0$2_0 pc.0$2_0))
                                                         (let
                                                            ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                            (=>
                                                               cmp2$2_0
                                                               (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       cmp2$1_0
                                       (let
                                          ((call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   (not or.cond22$2_0)
                                                   (let
                                                      ((cmp7$2_0 (= pc.0$2_0 0))
                                                       (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                      (let
                                                         ((or.cond23$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp9$2_0)))
                                                         (=>
                                                            or.cond23$2_0
                                                            (let
                                                               ((y.0$2_0 y.0$2_0)
                                                                (i.0$2_0 i.0$2_0)
                                                                (pc.0$2_0 1))
                                                               (let
                                                                  ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                  (=>
                                                                     cmp2$2_0
                                                                     (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       cmp2$1_0
                                       (let
                                          ((call$2_0 call$2_0_old)
                                           (i.0$2_0 i.0$2_0_old)
                                           (max$2_0 max$2_0_old)
                                           (pc.0$2_0 pc.0$2_0_old))
                                          (let
                                             ((y.0$2_0 y.0$2_0_old)
                                              (cmp4$2_0 (= pc.0$2_0 0))
                                              (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                             (let
                                                ((or.cond22$2_0 (and
                                                                    cmp4$2_0
                                                                    cmp5$2_0)))
                                                (=>
                                                   (not or.cond22$2_0)
                                                   (let
                                                      ((cmp7$2_0 (= pc.0$2_0 0))
                                                       (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                      (let
                                                         ((or.cond23$2_0 (and
                                                                             cmp7$2_0
                                                                             cmp9$2_0)))
                                                         (=>
                                                            (not or.cond23$2_0)
                                                            (let
                                                               ((cmp12$2_0 (= pc.0$2_0 1))
                                                                (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                               (let
                                                                  ((or.cond24$2_0 (and
                                                                                      cmp12$2_0
                                                                                      cmp14$2_0))
                                                                   (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                   (inc17$2_0 (+ i.0$2_0 1)))
                                                                  (let
                                                                     ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                      (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                     (let
                                                                        ((y.0$2_0 y.1$2_0)
                                                                         (i.0$2_0 i.1$2_0)
                                                                         (pc.0$2_0 pc.0$2_0))
                                                                        (let
                                                                           ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                           (=>
                                                                              cmp2$2_0
                                                                              (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp2$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.0$2_0 pc.0$2_0_old))
                                                      (let
                                                         ((y.0$2_0 y.0$2_0_old)
                                                          (cmp4$2_0 (= pc.0$2_0 0))
                                                          (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond22$2_0 (and
                                                                                cmp4$2_0
                                                                                cmp5$2_0)))
                                                            (=>
                                                               or.cond22$2_0
                                                               (let
                                                                  ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                                   (inc$2_0 (+ i.0$2_0 1)))
                                                                  (let
                                                                     ((y.0$2_0 add$2_0)
                                                                      (i.0$2_0 inc$2_0)
                                                                      (pc.0$2_0 pc.0$2_0))
                                                                     (let
                                                                        ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                        (=>
                                                                           cmp2$2_0
                                                                           (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp2$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.0$2_0 pc.0$2_0_old))
                                                      (let
                                                         ((y.0$2_0 y.0$2_0_old)
                                                          (cmp4$2_0 (= pc.0$2_0 0))
                                                          (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond22$2_0 (and
                                                                                cmp4$2_0
                                                                                cmp5$2_0)))
                                                            (=>
                                                               (not or.cond22$2_0)
                                                               (let
                                                                  ((cmp7$2_0 (= pc.0$2_0 0))
                                                                   (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                  (let
                                                                     ((or.cond23$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp9$2_0)))
                                                                     (=>
                                                                        or.cond23$2_0
                                                                        (let
                                                                           ((y.0$2_0 y.0$2_0)
                                                                            (i.0$2_0 i.0$2_0)
                                                                            (pc.0$2_0 1))
                                                                           (let
                                                                              ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                              (=>
                                                                                 cmp2$2_0
                                                                                 (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp2$1_0
                                                   (let
                                                      ((call$2_0 call$2_0_old)
                                                       (i.0$2_0 i.0$2_0_old)
                                                       (max$2_0 max$2_0_old)
                                                       (pc.0$2_0 pc.0$2_0_old))
                                                      (let
                                                         ((y.0$2_0 y.0$2_0_old)
                                                          (cmp4$2_0 (= pc.0$2_0 0))
                                                          (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond22$2_0 (and
                                                                                cmp4$2_0
                                                                                cmp5$2_0)))
                                                            (=>
                                                               (not or.cond22$2_0)
                                                               (let
                                                                  ((cmp7$2_0 (= pc.0$2_0 0))
                                                                   (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                  (let
                                                                     ((or.cond23$2_0 (and
                                                                                         cmp7$2_0
                                                                                         cmp9$2_0)))
                                                                     (=>
                                                                        (not or.cond23$2_0)
                                                                        (let
                                                                           ((cmp12$2_0 (= pc.0$2_0 1))
                                                                            (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                           (let
                                                                              ((or.cond24$2_0 (and
                                                                                                  cmp12$2_0
                                                                                                  cmp14$2_0))
                                                                               (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                               (inc17$2_0 (+ i.0$2_0 1)))
                                                                              (let
                                                                                 ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                                  (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                                 (let
                                                                                    ((y.0$2_0 y.1$2_0)
                                                                                     (i.0$2_0 i.1$2_0)
                                                                                     (pc.0$2_0 pc.0$2_0))
                                                                                    (let
                                                                                       ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                       (=>
                                                                                          cmp2$2_0
                                                                                          (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     or.cond22$1_0
                     (let
                        ((inc$1_0 (+ i.0$1_0 1)))
                        (let
                           ((add$1_0 (+ y.0$1_0 inc$1_0)))
                           (let
                              ((y.0$1_0 add$1_0)
                               (i.0$1_0 inc$1_0)
                               (pc.0$1_0 pc.0$1_0))
                              (let
                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                 (=>
                                    cmp2$1_0
                                    (=>
                                       (and
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      or.cond22$2_0
                                                      (let
                                                         ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                          (inc$2_0 (+ i.0$2_0 1)))
                                                         (let
                                                            ((y.0$2_0 add$2_0)
                                                             (i.0$2_0 inc$2_0)
                                                             (pc.0$2_0 pc.0$2_0))
                                                            (let
                                                               ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                               (not cmp2$2_0))))))))
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      (not or.cond22$2_0)
                                                      (let
                                                         ((cmp7$2_0 (= pc.0$2_0 0))
                                                          (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond23$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp9$2_0)))
                                                            (=>
                                                               or.cond23$2_0
                                                               (let
                                                                  ((y.0$2_0 y.0$2_0)
                                                                   (i.0$2_0 i.0$2_0)
                                                                   (pc.0$2_0 1))
                                                                  (let
                                                                     ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                     (not cmp2$2_0))))))))))
                                          (let
                                             ((call$2_0 call$2_0_old)
                                              (i.0$2_0 i.0$2_0_old)
                                              (max$2_0 max$2_0_old)
                                              (pc.0$2_0 pc.0$2_0_old))
                                             (let
                                                ((y.0$2_0 y.0$2_0_old)
                                                 (cmp4$2_0 (= pc.0$2_0 0))
                                                 (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                (let
                                                   ((or.cond22$2_0 (and
                                                                       cmp4$2_0
                                                                       cmp5$2_0)))
                                                   (=>
                                                      (not or.cond22$2_0)
                                                      (let
                                                         ((cmp7$2_0 (= pc.0$2_0 0))
                                                          (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                         (let
                                                            ((or.cond23$2_0 (and
                                                                                cmp7$2_0
                                                                                cmp9$2_0)))
                                                            (=>
                                                               (not or.cond23$2_0)
                                                               (let
                                                                  ((cmp12$2_0 (= pc.0$2_0 1))
                                                                   (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                  (let
                                                                     ((or.cond24$2_0 (and
                                                                                         cmp12$2_0
                                                                                         cmp14$2_0))
                                                                      (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                      (inc17$2_0 (+ i.0$2_0 1)))
                                                                     (let
                                                                        ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                         (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                        (let
                                                                           ((y.0$2_0 y.1$2_0)
                                                                            (i.0$2_0 i.1$2_0)
                                                                            (pc.0$2_0 pc.0$2_0))
                                                                           (let
                                                                              ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                              (not cmp2$2_0))))))))))))))
                                       (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              or.cond23$1_0
                              (let
                                 ((y.0$1_0 y.0$1_0)
                                  (i.0$1_0 i.0$1_0)
                                  (pc.0$1_0 1))
                                 (let
                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                    (=>
                                       cmp2$1_0
                                       (=>
                                          (and
                                             (let
                                                ((call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.0$2_0 pc.0$2_0_old))
                                                (let
                                                   ((y.0$2_0 y.0$2_0_old)
                                                    (cmp4$2_0 (= pc.0$2_0 0))
                                                    (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                   (let
                                                      ((or.cond22$2_0 (and
                                                                          cmp4$2_0
                                                                          cmp5$2_0)))
                                                      (=>
                                                         or.cond22$2_0
                                                         (let
                                                            ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                             (inc$2_0 (+ i.0$2_0 1)))
                                                            (let
                                                               ((y.0$2_0 add$2_0)
                                                                (i.0$2_0 inc$2_0)
                                                                (pc.0$2_0 pc.0$2_0))
                                                               (let
                                                                  ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                  (not cmp2$2_0))))))))
                                             (let
                                                ((call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.0$2_0 pc.0$2_0_old))
                                                (let
                                                   ((y.0$2_0 y.0$2_0_old)
                                                    (cmp4$2_0 (= pc.0$2_0 0))
                                                    (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                   (let
                                                      ((or.cond22$2_0 (and
                                                                          cmp4$2_0
                                                                          cmp5$2_0)))
                                                      (=>
                                                         (not or.cond22$2_0)
                                                         (let
                                                            ((cmp7$2_0 (= pc.0$2_0 0))
                                                             (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                            (let
                                                               ((or.cond23$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp9$2_0)))
                                                               (=>
                                                                  or.cond23$2_0
                                                                  (let
                                                                     ((y.0$2_0 y.0$2_0)
                                                                      (i.0$2_0 i.0$2_0)
                                                                      (pc.0$2_0 1))
                                                                     (let
                                                                        ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                        (not cmp2$2_0))))))))))
                                             (let
                                                ((call$2_0 call$2_0_old)
                                                 (i.0$2_0 i.0$2_0_old)
                                                 (max$2_0 max$2_0_old)
                                                 (pc.0$2_0 pc.0$2_0_old))
                                                (let
                                                   ((y.0$2_0 y.0$2_0_old)
                                                    (cmp4$2_0 (= pc.0$2_0 0))
                                                    (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                   (let
                                                      ((or.cond22$2_0 (and
                                                                          cmp4$2_0
                                                                          cmp5$2_0)))
                                                      (=>
                                                         (not or.cond22$2_0)
                                                         (let
                                                            ((cmp7$2_0 (= pc.0$2_0 0))
                                                             (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                            (let
                                                               ((or.cond23$2_0 (and
                                                                                   cmp7$2_0
                                                                                   cmp9$2_0)))
                                                               (=>
                                                                  (not or.cond23$2_0)
                                                                  (let
                                                                     ((cmp12$2_0 (= pc.0$2_0 1))
                                                                      (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                     (let
                                                                        ((or.cond24$2_0 (and
                                                                                            cmp12$2_0
                                                                                            cmp14$2_0))
                                                                         (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                         (inc17$2_0 (+ i.0$2_0 1)))
                                                                        (let
                                                                           ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                            (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                           (let
                                                                              ((y.0$2_0 y.1$2_0)
                                                                               (i.0$2_0 i.1$2_0)
                                                                               (pc.0$2_0 pc.0$2_0))
                                                                              (let
                                                                                 ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                 (not cmp2$2_0))))))))))))))
                                          (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$1_0 call$1_0_old)
             (i.0$1_0 i.0$1_0_old)
             (max$1_0 max$1_0_old)
             (pc.0$1_0 pc.0$1_0_old))
            (let
               ((y.0$1_0 y.0$1_0_old)
                (cmp4$1_0 (= pc.0$1_0 0))
                (cmp5$1_0 (< i.0$1_0 call$1_0)))
               (let
                  ((or.cond22$1_0 (and
                                      cmp4$1_0
                                      cmp5$1_0)))
                  (=>
                     (not or.cond22$1_0)
                     (let
                        ((cmp7$1_0 (= pc.0$1_0 0))
                         (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                        (let
                           ((or.cond23$1_0 (and
                                               cmp7$1_0
                                               cmp9$1_0)))
                           (=>
                              (not or.cond23$1_0)
                              (let
                                 ((cmp12$1_0 (= pc.0$1_0 1))
                                  (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                 (let
                                    ((or.cond24$1_0 (and
                                                        cmp12$1_0
                                                        cmp14$1_0))
                                     (inc16$1_0 (+ i.0$1_0 1)))
                                    (let
                                       ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                       (let
                                          ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                           (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                          (let
                                             ((y.0$1_0 y.1$1_0)
                                              (i.0$1_0 i.1$1_0)
                                              (pc.0$1_0 pc.0$1_0))
                                             (let
                                                ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                (=>
                                                   cmp2$1_0
                                                   (=>
                                                      (and
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.0$2_0 pc.0$2_0_old))
                                                            (let
                                                               ((y.0$2_0 y.0$2_0_old)
                                                                (cmp4$2_0 (= pc.0$2_0 0))
                                                                (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond22$2_0 (and
                                                                                      cmp4$2_0
                                                                                      cmp5$2_0)))
                                                                  (=>
                                                                     or.cond22$2_0
                                                                     (let
                                                                        ((add$2_0 (+ y.0$2_0 i.0$2_0))
                                                                         (inc$2_0 (+ i.0$2_0 1)))
                                                                        (let
                                                                           ((y.0$2_0 add$2_0)
                                                                            (i.0$2_0 inc$2_0)
                                                                            (pc.0$2_0 pc.0$2_0))
                                                                           (let
                                                                              ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                              (not cmp2$2_0))))))))
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.0$2_0 pc.0$2_0_old))
                                                            (let
                                                               ((y.0$2_0 y.0$2_0_old)
                                                                (cmp4$2_0 (= pc.0$2_0 0))
                                                                (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond22$2_0 (and
                                                                                      cmp4$2_0
                                                                                      cmp5$2_0)))
                                                                  (=>
                                                                     (not or.cond22$2_0)
                                                                     (let
                                                                        ((cmp7$2_0 (= pc.0$2_0 0))
                                                                         (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                        (let
                                                                           ((or.cond23$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp9$2_0)))
                                                                           (=>
                                                                              or.cond23$2_0
                                                                              (let
                                                                                 ((y.0$2_0 y.0$2_0)
                                                                                  (i.0$2_0 i.0$2_0)
                                                                                  (pc.0$2_0 1))
                                                                                 (let
                                                                                    ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                    (not cmp2$2_0))))))))))
                                                         (let
                                                            ((call$2_0 call$2_0_old)
                                                             (i.0$2_0 i.0$2_0_old)
                                                             (max$2_0 max$2_0_old)
                                                             (pc.0$2_0 pc.0$2_0_old))
                                                            (let
                                                               ((y.0$2_0 y.0$2_0_old)
                                                                (cmp4$2_0 (= pc.0$2_0 0))
                                                                (cmp5$2_0 (< i.0$2_0 call$2_0)))
                                                               (let
                                                                  ((or.cond22$2_0 (and
                                                                                      cmp4$2_0
                                                                                      cmp5$2_0)))
                                                                  (=>
                                                                     (not or.cond22$2_0)
                                                                     (let
                                                                        ((cmp7$2_0 (= pc.0$2_0 0))
                                                                         (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                                                                        (let
                                                                           ((or.cond23$2_0 (and
                                                                                               cmp7$2_0
                                                                                               cmp9$2_0)))
                                                                           (=>
                                                                              (not or.cond23$2_0)
                                                                              (let
                                                                                 ((cmp12$2_0 (= pc.0$2_0 1))
                                                                                  (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                                                                 (let
                                                                                    ((or.cond24$2_0 (and
                                                                                                        cmp12$2_0
                                                                                                        cmp14$2_0))
                                                                                     (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                                                                     (inc17$2_0 (+ i.0$2_0 1)))
                                                                                    (let
                                                                                       ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                                                                        (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                                                                       (let
                                                                                          ((y.0$2_0 y.1$2_0)
                                                                                           (i.0$2_0 i.1$2_0)
                                                                                           (pc.0$2_0 pc.0$2_0))
                                                                                          (let
                                                                                             ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                                                                             (not cmp2$2_0))))))))))))))
                                                      (INV_MAIN_42 call$1_0 i.0$1_0 max$1_0 pc.0$1_0 y.0$1_0 call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)))))))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.0$2_0 pc.0$2_0_old))
            (let
               ((y.0$2_0 y.0$2_0_old)
                (cmp4$2_0 (= pc.0$2_0 0))
                (cmp5$2_0 (< i.0$2_0 call$2_0)))
               (let
                  ((or.cond22$2_0 (and
                                      cmp4$2_0
                                      cmp5$2_0)))
                  (=>
                     or.cond22$2_0
                     (let
                        ((add$2_0 (+ y.0$2_0 i.0$2_0))
                         (inc$2_0 (+ i.0$2_0 1)))
                        (let
                           ((y.0$2_0 add$2_0)
                            (i.0$2_0 inc$2_0)
                            (pc.0$2_0 pc.0$2_0))
                           (let
                              ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                              (=>
                                 cmp2$2_0
                                 (=>
                                    (and
                                       (let
                                          ((call$1_0 call$1_0_old)
                                           (i.0$1_0 i.0$1_0_old)
                                           (max$1_0 max$1_0_old)
                                           (pc.0$1_0 pc.0$1_0_old))
                                          (let
                                             ((y.0$1_0 y.0$1_0_old)
                                              (cmp4$1_0 (= pc.0$1_0 0))
                                              (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                             (let
                                                ((or.cond22$1_0 (and
                                                                    cmp4$1_0
                                                                    cmp5$1_0)))
                                                (=>
                                                   or.cond22$1_0
                                                   (let
                                                      ((inc$1_0 (+ i.0$1_0 1)))
                                                      (let
                                                         ((add$1_0 (+ y.0$1_0 inc$1_0)))
                                                         (let
                                                            ((y.0$1_0 add$1_0)
                                                             (i.0$1_0 inc$1_0)
                                                             (pc.0$1_0 pc.0$1_0))
                                                            (let
                                                               ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                               (not cmp2$1_0)))))))))
                                       (let
                                          ((call$1_0 call$1_0_old)
                                           (i.0$1_0 i.0$1_0_old)
                                           (max$1_0 max$1_0_old)
                                           (pc.0$1_0 pc.0$1_0_old))
                                          (let
                                             ((y.0$1_0 y.0$1_0_old)
                                              (cmp4$1_0 (= pc.0$1_0 0))
                                              (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                             (let
                                                ((or.cond22$1_0 (and
                                                                    cmp4$1_0
                                                                    cmp5$1_0)))
                                                (=>
                                                   (not or.cond22$1_0)
                                                   (let
                                                      ((cmp7$1_0 (= pc.0$1_0 0))
                                                       (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                      (let
                                                         ((or.cond23$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp9$1_0)))
                                                         (=>
                                                            or.cond23$1_0
                                                            (let
                                                               ((y.0$1_0 y.0$1_0)
                                                                (i.0$1_0 i.0$1_0)
                                                                (pc.0$1_0 1))
                                                               (let
                                                                  ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                  (not cmp2$1_0))))))))))
                                       (let
                                          ((call$1_0 call$1_0_old)
                                           (i.0$1_0 i.0$1_0_old)
                                           (max$1_0 max$1_0_old)
                                           (pc.0$1_0 pc.0$1_0_old))
                                          (let
                                             ((y.0$1_0 y.0$1_0_old)
                                              (cmp4$1_0 (= pc.0$1_0 0))
                                              (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                             (let
                                                ((or.cond22$1_0 (and
                                                                    cmp4$1_0
                                                                    cmp5$1_0)))
                                                (=>
                                                   (not or.cond22$1_0)
                                                   (let
                                                      ((cmp7$1_0 (= pc.0$1_0 0))
                                                       (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                      (let
                                                         ((or.cond23$1_0 (and
                                                                             cmp7$1_0
                                                                             cmp9$1_0)))
                                                         (=>
                                                            (not or.cond23$1_0)
                                                            (let
                                                               ((cmp12$1_0 (= pc.0$1_0 1))
                                                                (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                                               (let
                                                                  ((or.cond24$1_0 (and
                                                                                      cmp12$1_0
                                                                                      cmp14$1_0))
                                                                   (inc16$1_0 (+ i.0$1_0 1)))
                                                                  (let
                                                                     ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                                                     (let
                                                                        ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                                                         (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                                                        (let
                                                                           ((y.0$1_0 y.1$1_0)
                                                                            (i.0$1_0 i.1$1_0)
                                                                            (pc.0$1_0 pc.0$1_0))
                                                                           (let
                                                                              ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                              (not cmp2$1_0)))))))))))))))
                                    (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.0$2_0 pc.0$2_0_old))
            (let
               ((y.0$2_0 y.0$2_0_old)
                (cmp4$2_0 (= pc.0$2_0 0))
                (cmp5$2_0 (< i.0$2_0 call$2_0)))
               (let
                  ((or.cond22$2_0 (and
                                      cmp4$2_0
                                      cmp5$2_0)))
                  (=>
                     (not or.cond22$2_0)
                     (let
                        ((cmp7$2_0 (= pc.0$2_0 0))
                         (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                        (let
                           ((or.cond23$2_0 (and
                                               cmp7$2_0
                                               cmp9$2_0)))
                           (=>
                              or.cond23$2_0
                              (let
                                 ((y.0$2_0 y.0$2_0)
                                  (i.0$2_0 i.0$2_0)
                                  (pc.0$2_0 1))
                                 (let
                                    ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                    (=>
                                       cmp2$2_0
                                       (=>
                                          (and
                                             (let
                                                ((call$1_0 call$1_0_old)
                                                 (i.0$1_0 i.0$1_0_old)
                                                 (max$1_0 max$1_0_old)
                                                 (pc.0$1_0 pc.0$1_0_old))
                                                (let
                                                   ((y.0$1_0 y.0$1_0_old)
                                                    (cmp4$1_0 (= pc.0$1_0 0))
                                                    (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond22$1_0 (and
                                                                          cmp4$1_0
                                                                          cmp5$1_0)))
                                                      (=>
                                                         or.cond22$1_0
                                                         (let
                                                            ((inc$1_0 (+ i.0$1_0 1)))
                                                            (let
                                                               ((add$1_0 (+ y.0$1_0 inc$1_0)))
                                                               (let
                                                                  ((y.0$1_0 add$1_0)
                                                                   (i.0$1_0 inc$1_0)
                                                                   (pc.0$1_0 pc.0$1_0))
                                                                  (let
                                                                     ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                     (not cmp2$1_0)))))))))
                                             (let
                                                ((call$1_0 call$1_0_old)
                                                 (i.0$1_0 i.0$1_0_old)
                                                 (max$1_0 max$1_0_old)
                                                 (pc.0$1_0 pc.0$1_0_old))
                                                (let
                                                   ((y.0$1_0 y.0$1_0_old)
                                                    (cmp4$1_0 (= pc.0$1_0 0))
                                                    (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond22$1_0 (and
                                                                          cmp4$1_0
                                                                          cmp5$1_0)))
                                                      (=>
                                                         (not or.cond22$1_0)
                                                         (let
                                                            ((cmp7$1_0 (= pc.0$1_0 0))
                                                             (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                            (let
                                                               ((or.cond23$1_0 (and
                                                                                   cmp7$1_0
                                                                                   cmp9$1_0)))
                                                               (=>
                                                                  or.cond23$1_0
                                                                  (let
                                                                     ((y.0$1_0 y.0$1_0)
                                                                      (i.0$1_0 i.0$1_0)
                                                                      (pc.0$1_0 1))
                                                                     (let
                                                                        ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                        (not cmp2$1_0))))))))))
                                             (let
                                                ((call$1_0 call$1_0_old)
                                                 (i.0$1_0 i.0$1_0_old)
                                                 (max$1_0 max$1_0_old)
                                                 (pc.0$1_0 pc.0$1_0_old))
                                                (let
                                                   ((y.0$1_0 y.0$1_0_old)
                                                    (cmp4$1_0 (= pc.0$1_0 0))
                                                    (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                   (let
                                                      ((or.cond22$1_0 (and
                                                                          cmp4$1_0
                                                                          cmp5$1_0)))
                                                      (=>
                                                         (not or.cond22$1_0)
                                                         (let
                                                            ((cmp7$1_0 (= pc.0$1_0 0))
                                                             (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                            (let
                                                               ((or.cond23$1_0 (and
                                                                                   cmp7$1_0
                                                                                   cmp9$1_0)))
                                                               (=>
                                                                  (not or.cond23$1_0)
                                                                  (let
                                                                     ((cmp12$1_0 (= pc.0$1_0 1))
                                                                      (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                                                     (let
                                                                        ((or.cond24$1_0 (and
                                                                                            cmp12$1_0
                                                                                            cmp14$1_0))
                                                                         (inc16$1_0 (+ i.0$1_0 1)))
                                                                        (let
                                                                           ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                                                           (let
                                                                              ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                                                               (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                                                              (let
                                                                                 ((y.0$1_0 y.1$1_0)
                                                                                  (i.0$1_0 i.1$1_0)
                                                                                  (pc.0$1_0 pc.0$1_0))
                                                                                 (let
                                                                                    ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                                    (not cmp2$1_0)))))))))))))))
                                          (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0)))))))))))))))
(assert
   (forall
      ((call$1_0_old Int)
       (i.0$1_0_old Int)
       (max$1_0_old Int)
       (pc.0$1_0_old Int)
       (y.0$1_0_old Int)
       (call$2_0_old Int)
       (i.0$2_0_old Int)
       (max$2_0_old Int)
       (pc.0$2_0_old Int)
       (y.0$2_0_old Int))
      (=>
         (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0_old i.0$2_0_old max$2_0_old pc.0$2_0_old y.0$2_0_old)
         (let
            ((call$2_0 call$2_0_old)
             (i.0$2_0 i.0$2_0_old)
             (max$2_0 max$2_0_old)
             (pc.0$2_0 pc.0$2_0_old))
            (let
               ((y.0$2_0 y.0$2_0_old)
                (cmp4$2_0 (= pc.0$2_0 0))
                (cmp5$2_0 (< i.0$2_0 call$2_0)))
               (let
                  ((or.cond22$2_0 (and
                                      cmp4$2_0
                                      cmp5$2_0)))
                  (=>
                     (not or.cond22$2_0)
                     (let
                        ((cmp7$2_0 (= pc.0$2_0 0))
                         (cmp9$2_0 (>= i.0$2_0 call$2_0)))
                        (let
                           ((or.cond23$2_0 (and
                                               cmp7$2_0
                                               cmp9$2_0)))
                           (=>
                              (not or.cond23$2_0)
                              (let
                                 ((cmp12$2_0 (= pc.0$2_0 1))
                                  (cmp14$2_0 (< i.0$2_0 max$2_0)))
                                 (let
                                    ((or.cond24$2_0 (and
                                                        cmp12$2_0
                                                        cmp14$2_0))
                                     (add16$2_0 (+ y.0$2_0 i.0$2_0))
                                     (inc17$2_0 (+ i.0$2_0 1)))
                                    (let
                                       ((i.1$2_0 (ite or.cond24$2_0 inc17$2_0 i.0$2_0))
                                        (y.1$2_0 (ite or.cond24$2_0 add16$2_0 y.0$2_0)))
                                       (let
                                          ((y.0$2_0 y.1$2_0)
                                           (i.0$2_0 i.1$2_0)
                                           (pc.0$2_0 pc.0$2_0))
                                          (let
                                             ((cmp2$2_0 (< i.0$2_0 max$2_0)))
                                             (=>
                                                cmp2$2_0
                                                (=>
                                                   (and
                                                      (let
                                                         ((call$1_0 call$1_0_old)
                                                          (i.0$1_0 i.0$1_0_old)
                                                          (max$1_0 max$1_0_old)
                                                          (pc.0$1_0 pc.0$1_0_old))
                                                         (let
                                                            ((y.0$1_0 y.0$1_0_old)
                                                             (cmp4$1_0 (= pc.0$1_0 0))
                                                             (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                            (let
                                                               ((or.cond22$1_0 (and
                                                                                   cmp4$1_0
                                                                                   cmp5$1_0)))
                                                               (=>
                                                                  or.cond22$1_0
                                                                  (let
                                                                     ((inc$1_0 (+ i.0$1_0 1)))
                                                                     (let
                                                                        ((add$1_0 (+ y.0$1_0 inc$1_0)))
                                                                        (let
                                                                           ((y.0$1_0 add$1_0)
                                                                            (i.0$1_0 inc$1_0)
                                                                            (pc.0$1_0 pc.0$1_0))
                                                                           (let
                                                                              ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                              (not cmp2$1_0)))))))))
                                                      (let
                                                         ((call$1_0 call$1_0_old)
                                                          (i.0$1_0 i.0$1_0_old)
                                                          (max$1_0 max$1_0_old)
                                                          (pc.0$1_0 pc.0$1_0_old))
                                                         (let
                                                            ((y.0$1_0 y.0$1_0_old)
                                                             (cmp4$1_0 (= pc.0$1_0 0))
                                                             (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                            (let
                                                               ((or.cond22$1_0 (and
                                                                                   cmp4$1_0
                                                                                   cmp5$1_0)))
                                                               (=>
                                                                  (not or.cond22$1_0)
                                                                  (let
                                                                     ((cmp7$1_0 (= pc.0$1_0 0))
                                                                      (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                                     (let
                                                                        ((or.cond23$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp9$1_0)))
                                                                        (=>
                                                                           or.cond23$1_0
                                                                           (let
                                                                              ((y.0$1_0 y.0$1_0)
                                                                               (i.0$1_0 i.0$1_0)
                                                                               (pc.0$1_0 1))
                                                                              (let
                                                                                 ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                                 (not cmp2$1_0))))))))))
                                                      (let
                                                         ((call$1_0 call$1_0_old)
                                                          (i.0$1_0 i.0$1_0_old)
                                                          (max$1_0 max$1_0_old)
                                                          (pc.0$1_0 pc.0$1_0_old))
                                                         (let
                                                            ((y.0$1_0 y.0$1_0_old)
                                                             (cmp4$1_0 (= pc.0$1_0 0))
                                                             (cmp5$1_0 (< i.0$1_0 call$1_0)))
                                                            (let
                                                               ((or.cond22$1_0 (and
                                                                                   cmp4$1_0
                                                                                   cmp5$1_0)))
                                                               (=>
                                                                  (not or.cond22$1_0)
                                                                  (let
                                                                     ((cmp7$1_0 (= pc.0$1_0 0))
                                                                      (cmp9$1_0 (>= i.0$1_0 call$1_0)))
                                                                     (let
                                                                        ((or.cond23$1_0 (and
                                                                                            cmp7$1_0
                                                                                            cmp9$1_0)))
                                                                        (=>
                                                                           (not or.cond23$1_0)
                                                                           (let
                                                                              ((cmp12$1_0 (= pc.0$1_0 1))
                                                                               (cmp14$1_0 (< i.0$1_0 max$1_0)))
                                                                              (let
                                                                                 ((or.cond24$1_0 (and
                                                                                                     cmp12$1_0
                                                                                                     cmp14$1_0))
                                                                                  (inc16$1_0 (+ i.0$1_0 1)))
                                                                                 (let
                                                                                    ((add17$1_0 (+ y.0$1_0 inc16$1_0)))
                                                                                    (let
                                                                                       ((i.1$1_0 (ite or.cond24$1_0 inc16$1_0 i.0$1_0))
                                                                                        (y.1$1_0 (ite or.cond24$1_0 add17$1_0 y.0$1_0)))
                                                                                       (let
                                                                                          ((y.0$1_0 y.1$1_0)
                                                                                           (i.0$1_0 i.1$1_0)
                                                                                           (pc.0$1_0 pc.0$1_0))
                                                                                          (let
                                                                                             ((cmp2$1_0 (< i.0$1_0 max$1_0)))
                                                                                             (not cmp2$1_0)))))))))))))))
                                                   (INV_MAIN_42 call$1_0_old i.0$1_0_old max$1_0_old pc.0$1_0_old y.0$1_0_old call$2_0 i.0$2_0 max$2_0 pc.0$2_0 y.0$2_0))))))))))))))))))
(check-sat)
(get-model)
