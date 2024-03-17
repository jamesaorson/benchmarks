#!/usr/bin/env bb

(require '[org.httpkit.server :as srv]
         '[clojure.java.browse :as browse]
         '[ruuter.core :as ruuter])

(def BASE-URL "http://localhost")
(def PORT 8080)

(defn render-text [text & [status]]
  {:status (or status 200)
   :body text})

(defn route-index [{:keys [query-string headers]}]
  (render-text "hello"))

(def routes [{:path     "/"
              :method   :get
              :response route-index}])

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Server
;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn serve [base-url port]
  (let [url (str base-url ":" port "/")]
    (srv/run-server #(ruuter/route routes %) {:port port})
    (println "serving" url)
    (browse/browse-url url)
    @(promise)))

(when (= *file* (System/getProperty "babashka.file"))
  (if (some #(= % "--only-download-deps") *command-line-args*)
    (System/exit 0)
    (serve BASE-URL PORT)))
