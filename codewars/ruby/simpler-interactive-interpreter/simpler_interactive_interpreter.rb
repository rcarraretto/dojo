class Interpreter

  def initialize
    @vars = {}
  end

  def input(expr)
    return '' if expr.empty?
    tokens = tokenize(expr).map{ |a| a[0] }
    if tokens.length == 1
      return factor(tokens[0]).evaluate
    end
    if tokens[1] == '='
      @vars[tokens[0]] = tokens[2].to_i
      return tokens[2].to_i
    end
    expression = parse_expression(tokens)
    return expression.evaluate
  end

  private

  def parse_expression(tokens)
    # * and / and % should have same precedence
    ['*', '/', '+', '-', '%'].each do |op|
      tokens = process_op(op, tokens)
    end
    tokens.first
  end

  def process_op(op, tokens)
    ptokens = []
    tokens.each_with_index do |token, index|
      if token == op
        operand1 = ptokens.pop
        operand2 = tokens[index+1]
        tokens.delete_at(index+1)
        operation = Operation.new(token, factor(operand1), factor(operand2))
        ptokens << operation
        next
      end
      ptokens << token
    end
    ptokens
  end

  def factor(token)
      if token.class != String
        return token
      end
      if is_float?(token)
        return FactorFloat.new(token)
      end
      if is_int?(token)
        return FactorInt.new(token)
      end
      return FactorIdentifier.new(token, @vars)
  end

  def is_int?(factor)
    factor =~ /\A[-+]?\d+\z/
  end

  def is_float?(factor)
    !!Float(factor) rescue false
  end

  def tokenize(program)
    return [] if program == ''
    regex = /\s*([-+*\/\%=\(\)]|[A-Za-z_][A-Za-z0-9_]*|[0-9]*\.?[0-9]+)\s*/
    program.scan(regex).select { |s| !(s =~ /^\s*$/) }
  end
end

class FactorIdentifier
  def initialize(token, vars)
    @var_name = token
    @vars = vars
  end

  def evaluate
    unless @vars.has_key?(@var_name)
      raise "ERROR: Invalid identifier. No variable with name '#{@var_name}' was found."
    end
    return @vars[@var_name]
  end
end

class FactorInt
  def initialize(token)
    @token = token
  end

  def evaluate
    @token.to_i
  end
end

class FactorFloat
  def initialize(token)
    @token = token
  end

  def evaluate
    @token.to_f
  end
end

class Operation
  def initialize(op, exp1, exp2)
    @op = op
    @exp1 = exp1
    @exp2 = exp2
  end

  def evaluate
    operand1 = @exp1.evaluate
    operand2 = @exp2.evaluate
    operand1.send(@op, operand2)
  end
end
