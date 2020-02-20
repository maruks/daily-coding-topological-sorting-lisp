(defpackage :topological
  (:use :cl :alexandria :iterate)
  (:export top-sort-kahn top-sort-dfs))

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

;; DFS
(defun all-nodes (graph)
  (let* ((keyz (mapcar #'car graph))
	 (vals (mappend #'cdr graph)))
    (remove-duplicates (append keyz vals))))

(defun dfs (node graph visited)
  (when (not (member node visited))
    (cons node (mappend (lambda (n) (dfs n graph visited)) (adjacent graph node)))))

(defun top-sort-dfs (graph &optional result)
  (let* ((nodes (all-nodes graph))
	 (selected (set-difference nodes result)))
    (if selected
	(top-sort-dfs graph (append (dfs (car selected) graph result) result))
	result)))
