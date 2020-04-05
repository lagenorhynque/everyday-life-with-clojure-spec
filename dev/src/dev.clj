(ns dev
  (:require [clojure.java.io :as io]
            [clojure.repl :refer :all]
            [clojure.spec.alpha :as s]
            [clojure.test :as test]
            [clojure.tools.namespace.repl :refer [refresh]]
            [clojure.spec.test.alpha :as stest]
            [expound.alpha :as expound]
            [orchestra.spec.test :as orchestra.stest]))

(comment

  ;; Enable Expound custom explain printer
  (set! s/*explain-out* (expound/custom-printer {:theme :figwheel-theme}))

  ;; Enable default explain printer
  (set! s/*explain-out* s/explain-printer)

  )
