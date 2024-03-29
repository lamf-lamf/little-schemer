;; Is x an atom
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

;; Is a in the list of atoms
(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (else (or (equal? (car lat) a)
               (member? a (cdr lat)))))))


;; Take an atom and a list of atoms and makes a new list of atoms with
;; the first occurence of the atom in the old list removed.
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) (quote ()))
     ((eq? (car lat) a) (cdr lat))
     (else (cons (car lat)
                 (rember a (cdr lat)))))))

;; Take a list and build another list composed of the first sexp
;; within each internal sublist
(define firsts
  (lambda (l)
    (cond
     ((null? l) '())
     (else (cons (car (car l))
                 (firsts (cdr l)))))))

;; Build a lat with new inserted to the right of the first occurance
;; of old.
(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else (cond
            ((eq? (car lat) old)
             (cons old
                   (cons new (cdr lat))))
            (else (cons (car lat)
                        (insertR new old
                                 (cdr lat)))))))))

;; Build a lat with new inserted to the left  of the first occurance of old.
(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else (cond
            ((eq? (car lat) old)
             (cons new lat))
            (else (cons (car lat)
                        (insertL new old
                                 (cdr lat)))))))))

;; Replaces the first occurrence of old in the lat with new.
(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else (cond
            ((eq? (car lat) old)
             (cons new (cdr lat)))
            (else (cons (car lat)
                        (subst new old
                               (cdr lat)))))))))

;; Replaces the first occurrence of o1 or the first occurrence of o2 by new
(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) (quote ()))
     (else (cond
            ((or (eq? (car lat) o1)
                 (eq? (car lat) o2))
             (cons new (cdr lat)))
            (else (cons (car lat)
                        (subst2 new o1 o2 (cdr lat)))))))))

;; Remove all occurrences of the a from lat
(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) (quote ()))
     (else
      (cond
       ((eq? (car lat) a)
        (multirember a (cdr lat)))
       (else (cons (car lat)
                   (multirember a  (cdr lat)))))))))

;; Insert new to the right of each occurrence of old
(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else
      (cond
       ((eq? (car lat) old)
        (cons (car lat)
              (cons new
                    (multiinsertR new old
                                  (cdr lat)))))
       (else (cons (car lat)
                   (multiinsertR new old (cdr lat)))))))))

;; Insert new to the left of each occurrence of old
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else
      (cond
       ((eq? (car lat) old)
        (cons new
              (cons old
                    (multiinsertL new old
                                  (cdr lat)))))
       (else (cons (car lat)
                   (multiinsertL new old (cdr lat)))))))))

;; Replace all occurrences of old with new within lat.
(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     (else (cond
            ((eq? (car lat) old)
             (cons new
                   (multisubst new old
                               (cdr lat))))
            (else (cons (car lat)
                        (multisubst new old
                                    (cdr lat)))))))))
