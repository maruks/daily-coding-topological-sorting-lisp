(defpackage :topological-tests
  (:use :cl :cacau :assert-p :topological))

(in-package :topological-tests)

(deftest "foo-test" ()
  (eql-p 1 (foo 1)))
