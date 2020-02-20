# topological

https://en.wikipedia.org/wiki/Topological_sorting

### Test

    sbcl --non-interactive --eval "(ql:quickload :topological/tests)" --eval "(asdf:test-system :topological)"


![Graph](https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Directed_acyclic_graph_2.svg/270px-Directed_acyclic_graph_2.svg.png)


```
(defparameter *graph-2* '((5 . (11))
            			  (7 . (11 8))
		            	  (3 . (8 10))
		            	  (11 . (2 9 10))
		            	  (8 . (9))))

(top-sort-kahn *graph-2*)
(5 7 3 11 8 10 2 9)
(top-sort-dfs *graph-2*)
(7 3 8 5 11 2 9 10)
```
