{:user {:plugins [[lein-ancient "0.6.8"]
                  [lein-auto "0.1.2"]
                  [lein-autoreload "0.1.1"]
                  [venantius/ultra "0.5.0"]]}
        :dependencies [[org.clojure/tools.trace "0.7.9"]
                       [clj-stacktrace "0.2.8"]]
        :repl-options {:init (do
                               (alter-var-root #'*out* (constantly *out*))
                               (require '[clojure.tools.trace :refer [trace]]))
                       :caught clj-stacktrace.repl/pst+}
 :repl {:repl-options {:prompt (fn [ns]
                                 (str "\033[1;32m"
                                      ns "=>"
                                      "\033[0m "))}}}
