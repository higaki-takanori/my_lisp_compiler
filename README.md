# my lisp compiler

自作の lisp コンパイラもどき（インタープリターもどき）です。

ruby で書いています。

以下で実行できます。

```
(terminal)% ruby rlisp.rb sample.lisp
```

ファイル読み込みのみ対応です。

例）
入力

```lisp
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

出力

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

その際のプログラム内のグローバル変数の中身を記載すると

```
# setで定義した変数の一覧
# 今回はfugeにhello,lispを定義
$hash_set #{"fuge"=>"\"hello,lisp\""}

# defで定義した関数の一覧
# 今回は以下の感じ
# hoge関数 引数:x 処理:(println x)(println x)
# fizzbuzz関数 引数:x 処理:(if (= (% x 3) 0) (print 'fizz'))(if (= (% x 5) 0) (print 'buzz'))(println nil)
$hash_def #{"hoge"=>[["x"], [["println", "x"], ["println", "x"]]],
            "fizzbuzz"=>[["x"], [["if", ["=", ["%", "x", "3"], "0"], ["print", "'fizz'"]], ["if", ["=", ["%", "x", "5"], "0"], ["print", "'buzz'"]], ["println", "nil"]]]}

# defで定義した関数を実行する際に使用する実引数の一覧
# 今回は最終的にx=15が代入されている
$hash_arg #{"x"=>"15"}
```

となります。
