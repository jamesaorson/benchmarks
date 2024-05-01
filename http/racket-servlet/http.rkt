#lang racket
(require web-server/servlet
         web-server/servlet-env)
 
(define (start req)
  (response/xexpr "hello"))
 
(serve/servlet start
               #:port 8080
               #:servlet-path ""
               #:servlet-regexp #rx"")
