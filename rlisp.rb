require 'pry'

def lambda(code)
  $hash_set = Hash.new if not defined? $hash_set
  $hash_def = Hash.new if not defined? $hash_def
  $hash_arg = Hash.new 

  abstrees = []
  tokens = tokenize(code)
  until tokens[0].nil?
    abstrees << abstree = parse(tokens)
  end
  abstrees.each do |element|
    calc(element)
  end

end

def tokenize(code)
  # // 正規表現, (a|b|c) "a","b","c"のどれか, \s 空白文字
  code.split(/(\s|\(|\))/).select{|e| e !~ /\s/ && e != ""}
end

def parse(tokens)
  token = tokens.shift

  if token == "("
    abstree = []
    until tokens[0] == ")"
      abstree << parse(tokens)
    end
    tokens.shift
    return abstree
  else
    return token
  end
end

def calc(exp)
  if exp.instance_of?(Array)
    calc_one_operate(exp).to_s
  elsif $hash_arg.key?(exp)
    calc($hash_arg[exp])
  elsif $hash_set.key?(exp)
    calc($hash_set[exp])
  else
    eval(exp)
  end
end

def calc_if(exp)
  case exp[0]
  when "="
    calc(exp[1]).to_i == calc(exp[2]).to_i
  when ">"
    calc(exp[1]).to_i > calc(exp[2]).to_i
  when "<"
    calc(exp[1]).to_i < calc(exp[2]).to_i
  when "<="
    calc(exp[1]).to_i <= calc(exp[2]).to_i
  when ">="
    calc(exp[1]).to_i >= calc(exp[2]).to_i
  end
end

def calc_one_operate(exp)
  case exp[0]
  when "+"
    calc(exp[1]).to_i + calc(exp[2]).to_i
  when "-"
    calc(exp[1]).to_i - calc(exp[2]).to_i
  when "*"
    calc(exp[1]).to_i * calc(exp[2]).to_i
  when "/"
    calc(exp[1]).to_f / calc(exp[2]).to_i
  when "%"
    calc(exp[1]).to_f % calc(exp[2]).to_i
  when "set"
    eval("$#{exp[1]} = #{exp[2]} ")
    $hash_set.store(exp[1], exp[2])
  when "print"
    print calc(exp[1])
  when "println"
    puts calc(exp[1])
  when "def"
    # (def hoge (x) (print x))
    # > {"hoge" => [["x"], [["print", "x"]] }
    abstrees = []
    exp[3..-1].each do |abstree|
      abstrees << abstree
    end
    $hash_def.store(exp[1], [exp[2], abstrees])
  when $hash_def.key($hash_def[exp[0]])
    def_func = $hash_def[exp[0]]
    def_func[0].each.with_index do |arg, i|
      $hash_arg.store(arg, exp[i+1])
    end
    def_func[1].each do |abstree|
      calc(abstree)
    end
  when "if"
    if calc_if(exp[1])
      exp[2..-1].each do |abstree|
        calc(abstree)
      end
    end
  else
  end

end

file = open(ARGV[0])
data = file.read
lambda(data)
file.close