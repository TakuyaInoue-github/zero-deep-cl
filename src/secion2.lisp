(ql:quickload :numcl)

(defun and-opp (x1 x2)
  (let ((w1 0.5)
        (w2 0.5)
        (theta 0.7))
    (if (<= (+ (* w1 x1) (* w2 x2)) theta)
            0
            1)))

(and-opp 1 0)
(and-opp 1 1)
(and-opp 0 0)

