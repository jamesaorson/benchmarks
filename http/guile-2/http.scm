(use-modules (web server))

(define (hello request request-body)
  (values '((content-type . (text/plain)))
          "hello"))

(if (member "--build" (command-line))
  (begin
    (write "Only building")
    (exit))
  (run-server hello))
