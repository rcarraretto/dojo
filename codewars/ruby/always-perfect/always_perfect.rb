def check_root(string)
  begin
    numbers = parse_numbers(string)
    perfect_square = numbers.reduce(:*) + 1
    square_root = Math.sqrt(perfect_square).ceil
    return "#{perfect_square}, #{square_root}"
  rescue => e
    e.message
  end
end

def parse_numbers(string)
  raise 'incorrect input' unless four_numbers_comma_separated? string
  numbers = string.split(',').map(&:to_i)
  raise 'not consecutive' if non_consecutive? numbers
  numbers
end

def four_numbers_comma_separated?(string)
  string =~ /^([-0-9]+,){3}[-0-9]+$/
end

def non_consecutive?(numbers)
  numbers != (numbers[0].. numbers[-1]).to_a
end
