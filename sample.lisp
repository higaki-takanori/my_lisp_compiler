(if (= 3 3)
  (println 'same')
  (println 'same')
)

(def hoge(x)
  (println x)
  (println x)
)

(hoge 'hi')

(def fizzbuzz (x)
  (if (= (% x 3) 0) (print 'fizz'))
  (if (= (% x 5) 0) (print 'buzz'))
  (println nil)
)

(fizzbuzz 3)
(fizzbuzz 5)
(fizzbuzz 15)