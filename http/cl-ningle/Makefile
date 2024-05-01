.PHONY: all build run

all: build

build: http.cl
	echo "install quicklisp"
	curl -O https://beta.quicklisp.org/quicklisp.lisp
	sbcl --disable-debugger --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --quit
	echo "installing dependencies"
	sbcl --disable-debugger --userinit $(shell pwd)/.sbclrc --eval "(ql:quickload '(:ningle :clack))" --quit

run:
	sbcl --disable-debugger --userinit $(shell pwd)/.sbclrc --load http.cl

clean:
	rm -rf ~/quicklisp
	rm -f ~/.sbclrc
