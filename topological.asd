;;;; topological.asd

(defsystem "topological"
  :description "Describe topological here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :version "0.0.1"
  :depends-on (:alexandria :iterate)
  :serial t
  :components ((:module "src"
		:components ((:file "topological"))))
  :in-order-to ((test-op (test-op "topological/tests"))))

(defsystem "topological/tests"
  :license "Specify license here"
  :depends-on (:topological
	       :cacau
	       :assert-p)
  :serial t
  :components ((:module "tests"
		:components ((:file "topological-tests"))))
  :perform (test-op (o c) (symbol-call 'cacau 'run :colorful t :reporter :list)))
