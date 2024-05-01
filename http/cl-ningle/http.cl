(ql:quickload '(:ningle :clack))

(defvar *app* (make-instance 'ningle:app))

(setf (ningle:route *app* "/")
      "hello")

(clack:clackup *app* :port 8080)
;; NOTE: Allows SBCL to run in background, like when running in systemd
;; or via & in the shell
(bt:join-thread (find-if (lambda (th)
                               (search "hunchentoot" (bt:thread-name th)))
                             (bt:all-threads)))
