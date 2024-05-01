.PHONY: all build run

all: build

build: http.cl
	echo "install quicklisp"
	curl -O https://beta.quicklisp.org/quicklisp.lisp
	sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(ql:add-to-init-file)' --quit
	echo "install cl-ningle"
	sbcl --eval '(ql:quickload :cl-ningle)' --quit
	echo "build http.cl"
	sbcl --load http.cl --eval '(quit)'

run:
	sbcl --script http.cl &
