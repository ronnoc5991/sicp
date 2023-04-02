(define my-list (list 1 2 3))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (item) (cons (car s) item)) rest)))))

(subsets my-list)

(define my-list (list 1 2))

;; the subsets of a set is equal to:
;; the set of subsets of the rest of the set
;; and the set made by combining the current item (car of the set) with each member of that set