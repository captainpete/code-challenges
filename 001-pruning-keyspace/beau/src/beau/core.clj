(ns beau.core)

(def possibles '(A B C D E F 1 2 3 4 5 6 7 8 9))

(defn filter-by-previous [prev-char]
  (filter (fn [possible]
            (cond
              (and (number? prev-char) (number? possible)) false
              (and (symbol? prev-char) (symbol? possible)) false
              (= prev-char possible) false
              :else true))
          possibles))

(defn space []
  (filter #(some symbol? %)
          (apply interleave
                 (pmap (fn [char1] (for [char2 (filter-by-previous char1)
                                         char3 (filter-by-previous char2)
                                         char4 (filter-by-previous char3)
                                         char5 (filter-by-previous char4)
                                         char6 (filter-by-previous char5)
                                         char7 (filter-by-previous char6)
                                         char8 (filter-by-previous char7)]

                                     [char1 char2 char3 char4 char5 char6 char7 char8]))
                       possibles))))
