(ql:quickload :numcl)

(defun and-opp (x1 x2)
  (let ((x (numcl:asarray `(,x1 ,x2)))
        (w (numcl:asarray `(0.5 0.5)))
        (b -0.7))
    (if (<= (+ (numcl:sum (numcl:* x w))  b) 0)
        0
        1)))

(defun or-opp (x1 x2)
  (let ((x (numcl:asarray `(,x1 ,x2)))
        (w (numcl:asarray `(0.5 0.5)))
        (b -0.3))
    (if (<= (+ (numcl:sum (numcl:* x w))  b) 0)
        0
        1)))

(defun nand-opp (x1 x2)
  (let ((x (numcl:asarray `(,x1 ,x2)))
        (w (numcl:asarray `(-0.5 -0.5)))
        (b 0.7))
    (if (<= (+ (numcl:sum (numcl:* x w))  b) 0)
        0
        1)))


(defun xor-opp (x1 x2)
  (let ((s1 (nand-opp x1 x2))
        (s2 (or-opp x1 x2)))
    (and-opp s1 s2)))


(or-opp 0 0)
(or-opp 0 1)
(or-opp 1 0)
(or-opp 1 1)

(and-opp 0 0)
(and-opp 0 1)
(and-opp 1 0)
(and-opp 1 1)

(nand-opp 0 0)
(nand-opp 0 1)
(nand-opp 1 0)
(nand-opp 1 1)

(xor-opp 0 0)
(xor-opp 0 1)
(xor-opp 1 0)
(xor-opp 1 1)

(numcl:arange -10 10 3)
(numcl:sum (numcl:arange 5))
(numcl:sum (numcl:asarray '(5 1)))
(numcl:sum (nand-opp 1 2))

(and-opp 1 0)
(and-opp 1 1)
(and-opp 0 0)

