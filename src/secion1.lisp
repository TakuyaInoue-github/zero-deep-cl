(ql:quickload :numcl)

(numcl:asarray '(1.0 2.0 3.0))
(defvar *a* (numcl:asarray '(1.0 2.0 3.0)))
(defvar *b* (numcl:asarray '(3.0 4.0 5.0)))

(numcl:+ *A* *B*)
(numcl:- *A* *B*)
(numcl:* *A* *B*)

(defvar *mul-arrays* (numcl:asarray '((1 2) (2 4))))
*mul-arrays*

(numcl:shape *mul-arrays*)
(numcl:dtype *mul-arrays*)