{:user {:plugins [[org.clojure/tools.trace "0.7.9"]
                  [clj-stacktrace "0.2.8"]
                  [lein-ancient "0.6.8"]
                  [lein-auto "0.1.2"]]}
        :repl-options {:init (do
                               (alter-var-root #'*out* (constantly *out*))
                               (require '[clojure.tools.trace :refer [trace]]))
                       :caught clj-stacktrace.repl/pst+}}
