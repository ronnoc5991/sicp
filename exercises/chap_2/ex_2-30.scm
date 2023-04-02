(define my-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))


;; direct definintion:

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree)) (square-tree (cdr tree))))))

(square-tree my-tree) ;; (1 (4 (9 16) 25) (36 49))

;; using map and recursion

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square-tree-alt tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-alt sub-tree)
             (* sub-tree sub-tree)))
       tree))

(square-tree-alt my-tree) ;; (1 (4 (9 16) 25) (36 49))