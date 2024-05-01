(ql:quickload '(:ningle :clack))

(defvar *app* (make-instance 'ningle:app))

(setf (ningle:route *app* "/")
      "hello")

(clack:clackup *app* :port 8080)
