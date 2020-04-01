require_relative 'simpler_interactive_interpreter'

interpreter = Interpreter.new

describe 'when empty input' do
  it 'outputs empty string' do
    expect(interpreter.input('')).to eq('')
  end
end

describe 'Factor: number' do
  it 'prints the number' do
    expect(interpreter.input('1')).to eq(1)
    expect(interpreter.input('1.52')).to eq(1.52)
  end
end

describe 'Operations' do
  it 'handles 1 operation with int' do
    expect(interpreter.input('1 + 1')).to eq(2)
    expect(interpreter.input('2 - 1')).to eq(1)
    expect(interpreter.input('2 * 3')).to eq(6)
    expect(interpreter.input('8 / 4')).to eq(2)
    expect(interpreter.input('7 % 4')).to eq(3)
  end

  it 'handles 1 operation with float' do
    expect(interpreter.input('1.5 + 1.5')).to eq(3.0)
    expect(interpreter.input('1.5 - 1')).to eq(0.5)
    expect(interpreter.input('2.5 * 2.5')).to eq(6.25)
    expect(interpreter.input('2.5 / 2.5')).to eq(1)
  end

  it 'handles 1 operation with float and int' do
    expect(interpreter.input('1.5 + 3')).to eq(4.5)
  end

  it 'handles 2 operations with same precedence' do
    expect(interpreter.input('1 + 1 + 1')).to eq(3)
    expect(interpreter.input('1 + 1 - 1')).to eq(1)
  end

  it 'handles 3 operands' do
    expect(interpreter.input('4 + 2 * 3')).to eq(10)
    expect(interpreter.input('4 / 2 * 3')).to eq(6)
    #expect(interpreter.input('7 % 2 * 8')).to eq(8)
  end
end

describe 'Factor: identifier' do
  it 'works' do
    expect(interpreter.input('x = 1')).to eq(1)
    expect(interpreter.input('x')).to eq(1)
    expect(interpreter.input('x + 3')).to eq(4)
    expect(interpreter.input('3 + x')).to eq(4)
    expect { interpreter.input('y') }.to raise_error(
      "ERROR: Invalid identifier. No variable with name 'y' was found."
    )
  end
end
