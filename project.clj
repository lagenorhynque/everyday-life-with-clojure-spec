(defproject everyday-life-with-clojure-spec "0.1.0-SNAPSHOT"
  :description "Everyday Life with clojure.spec"
  :url "https://github.com/lagenorhynque/everyday-life-with-clojure-spec"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[honeysql "0.9.10"]
                 [org.clojure/clojure "1.10.1"]
                 [org.postgresql/postgresql "42.2.12"]
                 [seancorfield/next.jdbc "1.0.424"]]
  :main ^:skip-aot everyday-life-with-clojure-spec.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}
             :repl {:repl-options {:init-ns user}}
             :dev {:source-paths ["dev/src"]
                   :dependencies [[expound "0.8.4"]
                                  [orchestra "2019.02.06-1"]
                                  [org.clojure/test.check "1.0.0"]
                                  [org.clojure/tools.namespace "1.0.0"]]}})
