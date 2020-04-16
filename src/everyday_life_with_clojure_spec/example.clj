(ns everyday-life-with-clojure-spec.example
  (:require [clojure.spec.alpha :as s]
            [honeysql.core :as sql]
            [honeysql.helpers :refer [merge-order-by merge-where]]
            [next.jdbc :as jdbc])
  (:import (javax.sql DataSource)))

(def db-spec
  {:jdbcUrl "jdbc:postgresql://localhost:5442/aqoursql?user=aqoursql_dev&password=password123"})

(defn ds []
  (jdbc/get-datasource db-spec))

(s/def :artist/id nat-int?)
(s/def :artist/type #{1 2})
(s/def :artist/name string?)
(s/def ::artist (s/keys :req [:artist/id
                              :artist/type
                              :artist/name]))

(s/def ::ids (s/coll-of :artist/id
                        :min-count 1))
(s/def ::sort-order (s/and (s/coll-of (s/tuple #{:id :type :name}
                                               #{:asc :desc})
                                      :min-count 1)
                           #(apply distinct? (map first %))))

(s/fdef find-artists
  :args (s/cat :ds #(instance? DataSource %)
               :condition (s/keys :opt-un [:artist/name
                                           ::ids
                                           ::sort-order]))
  :ret (s/coll-of ::artist))

(defn find-artists [ds {:keys [name ids sort-order]}]
  (jdbc/execute! ds (cond-> (sql/build
                             :select :*
                             :from :artist)
                      name (merge-where [:like :name (str \% name \%)])
                      (seq ids) (merge-where [:in :id ids])
                      (seq sort-order) (#(apply merge-order-by % sort-order))
                      (empty? sort-order) (merge-order-by [:id :asc])
                      true sql/format)))

(comment

  (require '[clojure.spec.test.alpha :as stest]
           '[orchestra.spec.test :as orchestra.stest])

  (stest/instrument `find-artists)

  (orchestra.stest/instrument `find-artists)

  (find-artists (ds) {:name "Aq"})

  (find-artists (ds) {:ids [2 4]})

  (find-artists (ds) {:sort-order [[:name :asc]
                                   [:id :desc]]})

  )
