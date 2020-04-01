def int_to_english(number)
  return 'zero' if number.zero?
  tokens = []
  groups = to_groups(number)
  groups.each_with_index do |number, i|
    tokens.push(group_to_eng(number))
    tokens.push(group_name(groups.length - i))
  end
  tokens.join(' ').strip
end

def to_groups(number)
  memo = number
  groups = []
  begin
    memo, mod = memo.divmod(1000)
    groups.unshift(mod)
  end while memo > 0
  groups
end

def group_to_eng(number)
  hundreds, num_2d = number.divmod(100)
  eng = num_to_eng(num_2d) || num_2d_to_eng(num_2d)
  if not hundreds.zero?
    eng = num_to_eng(hundreds) + ' hundred ' + eng
  end
  eng
end

def num_2d_to_eng(number)
  tens, ones = number.divmod(10)
  num_to_eng(tens * 10) + ' ' + num_to_eng(ones)
end

def num_to_eng(number)
  {
    0 => '',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninty',
  }[number]
end

def group_name(i)
  [
    '',
    '',
    'thousand',
    'million',
    'billion',
    'trillion',
    'quadrillion',
    'quintillion',
    'sextillion',
    'septillion'
  ][i]
end
