(ql:quickload :numcl)
(ql:quickload :closer-mop)

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

(defclass perceptron () 
  ((w1 :initarg :w1 :accessor w1)
   (w2 :initarg :w2 :accessor w2)
   (bias :initarg :bias :accessor bias))
  (:metaclass c2mop:funcallable-standard-class))

(defmethod initialize-instance :after ((o perceptron) &key function)
  (c2mop:set-funcallable-instance-function o function))

(defmacro define-perceptron ((name &rest initargs) lambda-list &body body)
  `(progn
     (setf (symbol-function ',name)
           (make-instance 'perceptron ,@initargs :function
                          (lambda ,lambda-list
                            (with-slots (w1 w2 bias) (symbol-function ',name)
                              (declare (ignorable w1 w2 bias))
                              ,@body))))
     ',name))

(define-perceptron (|and| :w1 0.5 :w2 0.5 :bias 0.7) (x1 x2)
  (if (<= (+ (* w1 x1) (* w2 x2)) bias)
      0
      1))

(define-perceptron (|nand| :w1 -0.5 :w2 -0.5 :bias -0.7) (x1 x2)
  (if (<= (+ (* w1 x1) (* w2 x2)) bias)
      0
      1))

(define-perceptron (|or| :w1 0.5 :w2 0.5 :bias 0.4) (x1 x2)
  (if (<= (+ (* w1 x1) (* w2 x2)) bias)
      0
      1))

(define-perceptron (|xor|) (x1 x2)
  (|and| (|nand| x1 x2)
         (|or| x1 x2)))

(defvar *x* (numcl:asarray '(0 1)))

(defvar *w* (numcl:asarray '(0.5 0.5)))

(defvar *b* -0.7)

(numcl:* *w* *x*)

(numcl:sum (numcl:* *w* *x*))

(numcl:+ (numcl:sum (numcl:* *w* *x*)) *b*)
