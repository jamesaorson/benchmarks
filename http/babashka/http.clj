#!/usr/bin/env bb

(require '[org.httpkit.server :as srv]
         '[clojure.java.browse :as browse]
         '[ruuter.core :as ruuter])

(def port 8080)

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

(when (= *file* (System/getProperty "babashka.file"))
  (let [url (str "http://localhost:" port "/")]
    (srv/run-server #(ruuter/route routes %) {:port port})
    (println "serving" url)
    (browse/browse-url url)
    @(promise)))
