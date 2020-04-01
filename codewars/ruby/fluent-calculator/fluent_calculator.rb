class Calc
  def method_missing(digit_method)
    number = sym_to_num(digit_method)
    OperationPending.new(number)
  end
end

class OperationPending
  def initialize(operand1)
    @operand1 = operand1
  end

  def method_missing(op_method)
    operation = get_op(op_method)
    Operand2Pending.new(@operand1, operation)
  end

  def get_op(op_method)
    {
      :plus => :+,
      :minus => :-,
      :times => :*,
      :divided_by => :/
    }[op_method]
  end
end

class Operand2Pending
  def initialize(operand1, operation)
    @operand1 = operand1
    @operation = operation
  end

  def method_missing(digit_method)
    operand2 = sym_to_num(digit_method)
    @operand1.send(@operation, operand2)
  end
end

def sym_to_num(sym)
  {
    :zero => 0,
    :one => 1,
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9
  }[sym]
end
