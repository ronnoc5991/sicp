;; tree-map

(define my-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

(define (square x) (* x x))

(define (square-tree-three tree) (tree-map square tree))

(square-tree-three my-tree) ;; (1 (4 (9 16) 25) (36 49))