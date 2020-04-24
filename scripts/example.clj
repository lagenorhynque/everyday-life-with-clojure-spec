#!/usr/bin/env bb
(ns example
  (:require [clojure.core :as core]
            [clojure.pprint :refer [pprint print-table]]
            [clojure.string :as str]
            [clojure.tools.cli :refer [parse-opts]]
            [next.jdbc :as jdbc]))

(def db-spec
  {:jdbcUrl "jdbc:postgresql://localhost:5442/aqoursql?user=aqoursql_dev&password=password123"})

(defn ds []
  (jdbc/get-datasource db-spec))

(defn merge-sql [sql clause v]
  (update sql clause conj v))

(defn format-sql [{:keys [sql where order-by]}]
  (cond-> [sql]
    where ((fn [[sql]]
             (apply vector
                    (str sql " WHERE " (->> where
                                            (map :query)
                                            (str/join " AND ")))
                    (->> where
                         (map :params)
                         (apply concat)))))
    order-by ((fn [[sql & args]]
                (apply vector
                       (str sql " ORDER BY " (->> order-by
                                                  (map :queries)
                                                  (apply concat)
                                                  (str/join ", ")))
                       args)))))

(defn find-artists [ds {:keys [name ids sort-order]}]
  (jdbc/execute! ds (cond-> {:sql "SELECT * FROM artist"}
                      name (merge-sql :where {:query "name LIKE ?"
                                              :params [(str \% name \%)]})
                      (seq ids) (merge-sql :where {:query (str "id IN ("
                                                               (->> (repeat (count ids) \?)
                                                                    (str/join ", "))
                                                               ")")
                                                   :params ids})
                      (seq sort-order) (merge-sql :order-by {:queries (->> sort-order
                                                                           (map (fn [[col ord]]
                                                                                  (str (core/name col)
                                                                                       " "
                                                                                       (core/name ord)))))})
                      (empty? sort-order) (merge-sql :order-by {:queries ["id ASC"]})
                      true format-sql
                      true (doto pprint))))

(def cli-options
  [["-n" "--name NAME" "filter by artist name"]
   ["-i" "--ids IDS" "filter by artist ids"
    :parse-fn (fn [v]
                (map #(Long/parseLong %)
                     (str/split v #",")))
    :validate [#(every? int? %)
               "Must be in the form of `id1,id2,...`"]]
   ["-s" "--sort-order SORT_ORDER" "sort"
    :parse-fn (fn [v]
                (map (fn [s]
                       (let [[_  col ord] (re-matches #"(\w+):(\w+)" s)]
                         [(keyword col) (keyword ord)]))
                     (str/split v #",")))
    :validate [#(every? (fn [[col ord]]
                          (and (contains? #{:id :type :name} col)
                               (contains? #{:asc :desc} ord)))
                        %)
               "Must be in the form of `col1:asc,col2:desc,...`"]]])

(let [{:keys [options errors]} (parse-opts *command-line-args* cli-options)]
  (when errors
    (run! println errors)
    (System/exit 1))
  (print-table (find-artists (ds)
                             (doto options
                               pprint))))
