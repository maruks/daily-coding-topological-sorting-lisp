(defpackage :topological
  (:use :cl :alexandria :iterate)
  (:export top-sort-kahn))

(in-package :topological)

(defun adjacent (graph vertex)
  (cdr (assoc vertex graph)))

(defun has-no-incoming-edges (graph vertex)
  (let ((vals (mappend #'cdr graph)))
    (not (member vertex vals))))

(defun nodes-with-no-incoming-edge (graph)
  (let* ((keyz (mapcar #'car graph))
	 (vals (mappend #'cdr graph)))
    (remove-if (lambda (x) (member x vals)) keyz)))

(defun remove-edge (graph from to)
  (let* ((ms (adjacent graph from))
	 (removed (remove to ms)))
    (rplacd (assoc from graph) removed)
    (has-no-incoming-edges graph to)))

(defun remove-edges (to-nodes from graph &optional result)
  (if to-nodes
      (let* ((n (car to-nodes))
	     (no-other-edges? (remove-edge graph from n)))
	(remove-edges (cdr to-nodes) from graph (if no-other-edges? (cons n result) result)))
      result))

;; Kahn's algorithm
(defun kahn (nodes graph &optional result)
  (if nodes
      (let* ((n (car nodes))
	     (ms (adjacent graph n))
	     (no-other-edges (remove-edges ms n graph)))
	(kahn (append (cdr nodes) no-other-edges) graph (cons n result)))
      (reverse result)))

(defun top-sort-kahn (graph)
  (kahn (nodes-with-no-incoming-edge graph) (copy-alist graph)))

(defparameter *graph* '((5 . (2 0))
			(4 . (0 1))
			(2 . (3))
			(3 . (1))))

(defparameter *graph-2* '((5 . (11))
			  (7 . (11 8))
			  (3 . (8 10))
			  (11 . (2 9 10))
			  (8 . (9))))

;; DFS
(defparameter *visited* nil)

(defun all-nodes (graph)
  (let* ((keyz (mapcar #'car graph))
	 (vals (mappend #'cdr graph)))
    (remove-duplicates (append keyz vals))))

(defun dfs (node graph)
  (when (not (member node *visited*))
    (iter
      (for n :in (adjacent graph node))
      (dfs n graph))
    (setq *visited* (cons node *visited*))))

(defun top-sort-dfs (graph)
  (let ((*visited* nil))
    (iter
      (with nodes = (all-nodes graph))
      (for selected = (set-difference nodes *visited*))
      (while selected)
      (dfs (car selected) graph))
    *visited*))
