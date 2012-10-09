(ns beau.core)

(def possibles '(A B C D E F 1 2 3 4 5 6 7 8 9))

(defn filter-by-previous [prev-char]
  (remove #{prev-char} possibles))

(defn filter-by-previous2 [prev-char second-last-char]
  (filter (fn [possible]
            (cond
              (every? number? [prev-char second-last-char possible]) false
              (every? symbol? [prev-char second-last-char possible]) false
              :else true))
          (filter-by-previous prev-char)))

(def fast-filter (memoize filter-by-previous2))


(defn space []
  (reduce concat
          (pmap (fn [char1] (for [char2 (filter-by-previous char1)
                                  char3 (fast-filter char2 char1)
                                  char4 (fast-filter char3 char2)
                                  char5 (fast-filter char4 char3)
                                  char6 (fast-filter char5 char4)
                                  char7 (fast-filter char6 char5)
                                  char8 (fast-filter char7 char6)]

                              [char1 char2 char3 char4 char5 char6 char7 char8]))
                possibles)))
