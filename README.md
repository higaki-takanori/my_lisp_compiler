# my lisp compiler

自作の lisp コンパイラもどき（インタープリターもどき）

ruby で書いています。

以下で実行できます。

```
ruby rlisp.rb sample.lisp
```

ファイル読み込みのみ対応です。

```
(if (= 3 3)
  (println 'same')
  (println 'same')
)

(def hoge(x)
  (println x)
  (println x)
)

(hoge 'hi')
(set fuge "hello,lisp")
(println fuge)

(def fizzbuzz (x)
  (if (= (% x 3) 0) (print 'fizz'))
  (if (= (% x 5) 0) (print 'buzz'))
  (println nil)
)

(fizzbuzz 3)
(fizzbuzz 5)
(fizzbuzz 15)
```

に対する出力は

```
same
same
hi
hi
hello,lisp
fizz
buzz
fizzbuzz
```

となります。

その際のプログラムの内部を記載すると

```
$hash_set #{"fuge"=>"\"hello,lisp\""}

$hash_def #{"hoge"=>[["x"], [["println", "x"], ["println", "x"]]], "fizzbuzz"=>[["x"], [["if", ["=", ["%", "x", "3"], "0"], ["print", "'fizz'"]], ["if", ["=", ["%", "x", "5"], "0"], ["print", "'buzz'"]], ["println", "nil"]]]}

$hash_arg #{"x"=>"15"}
```
