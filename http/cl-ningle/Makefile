.PHONY: all build run

all: build

build: http.cl
	echo "install quicklisp"
	curl -O https://beta.quicklisp.org/quicklisp.lisp
	sbcl --disable-debugger --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --quit
	echo "install cl-ningle"
	sbcl --disable-debugger --load quicklisp.lisp --eval "(ql:quickload '(:ningle :clack))" --quit

run:
	sbcl --disable-debugger --load http.cl
