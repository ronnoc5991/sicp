;; constructors

(define (make-mobile left right)
(list left right))

(define (make-branch length structure)
(list length structure))

;; Part A: selectors

(define (left-branch mobile)
(car mobile))

(define (right-branch mobile)
(car (cdr mobile)))

(define (branch-length branch)
(car branch))

(define (branch-structure branch)
(car (cdr branch)))

;; Part B: basic tree recursion (probably a more clever way to do this)

(define (is-mobile mobile)
    (pair? mobile))

(define (total-weight mobile)
    (cond ((not (is-mobile mobile)) mobile)
      ((and (pair? (branch-structure (left-branch mobile))) (pair? (branch-structure (right-branch mobile))))
        (+ (total-weight (branch-structure (left-branch mobile))) (total-weight (branch-structure (right-branch mobile)))))
       ((and (pair? (branch-structure (left-branch mobile))) (not (pair? (branch-structure (right-branch mobile)))))
        (+ (total-weight (branch-structure (left-branch mobile))) (branch-structure (right-branch mobile))))
       ((and (not (pair? (branch-structure (left-branch mobile)))) (pair? (branch-structure (right-branch mobile))))
        (+ (branch-structure (left-branch mobile)) (total-weight (branch-structure (right-branch mobile)))))
       (else (+ (branch-structure (left-branch mobile)) (branch-structure (right-branch mobile))))))

;; Testing Part B:

(define branch-one (make-branch 1 1))
(define branch-two (make-branch 1 1))

(define branch-four (make-branch 1 1))
(define branch-five (make-branch 1 1))

(define my-mobile-one (make-mobile branch-one branch-two))
(define branch-three (make-branch 1 my-mobile-one))

(define my-mobile-two (make-mobile branch-four branch-five))
(define branch-six (make-branch 1 my-mobile-two))

(define my-mobile (make-mobile branch-three branch-six))

(total-weight my-mobile)
(total-weight my-mobile-one)
(total-weight my-mobile-two)
(total-weight (branch-structure branch-one))

;; Part C: Write a predicate to test if a mobile is balanced
;; a mobile is balanced if the product of the length and weight of the left branch is equal to the product of the length and weight of the right branch
;; and if each of the submobiles is balanced

(define (is-balanced mobile)
    (and (= (* (branch-length (left-branch mobile)) (total-weight (branch-structure (left-branch mobile))))
        (* (branch-length (right-branch mobile)) (total-weight (branch-structure (right-branch mobile)))))
     (and (or (not (pair? (branch-structure (left-branch mobile))))
              (is-balanced (branch-structure (left-branch mobile))))
          (or (not (pair? (branch-structure (right-branch mobile))))
              (is-balanced (branch-structure (right-branch mobile)))))))


;; Testing Part C:

(is-balanced my-mobile) ;; true

(define unbalanced-mobile (make-mobile branch-three branch-five))

(is-balanced unbalanced-mobile) ;; false

;; Part D: if we update the branch and mobile constructors to make use of cons instead of list
;; how much would we need to change in our program?

;; we would only need to udpate the selectors for the branch-structure and the right-branch to exclude the car