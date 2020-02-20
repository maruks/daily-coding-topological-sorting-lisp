(defpackage :topological-tests
  (:use :cl :cacau :assert-p :topological))

(in-package :topological-tests)

(defparameter *graph* '((5 . (2 0))
			(4 . (0 1))
			(2 . (3))
			(3 . (1))))

(defparameter *graph-2* '((5 . (11))
			  (7 . (11 8))
			  (3 . (8 10))
			  (11 . (2 9 10))
			  (8 . (9))))

(deftest "topological kahn sort test" ()
  (equalp-p '(5 4 2 0 3 1) (top-sort-kahn *graph*))
  (equalp-p '(5 7 3 11 8 10 2 9) (top-sort-kahn *graph-2*)))

(deftest "topological dfs sort dfs test" ()
  (equalp-p '(4 5 2 3 1 0) (top-sort-dfs *graph*))
  (equalp-p '(7 3 8 5 11 2 9 10) (top-sort-dfs *graph-2*)))
