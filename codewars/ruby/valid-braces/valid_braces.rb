def validBraces(braces)
  scopes = []
  braces.chars.reduce(scopes) do |scopes, char|
    valid = parse_char(scopes, char)
    break if not valid
    scopes
  end
  scopes.empty?
end

def parse_char(scopes, char)
  if opening_char?(char)
    scopes.push(char)
    return true
  end

  if closing_char?(char)
    opening_char = scopes.pop
    return true if match?(opening_char, char)
    scopes.push(opening_char)
    return false
  end

  return true
end

def match?(opening_char, closing_char)
  brackets[opening_char] == closing_char
end

def opening_char?(char)
  brackets.keys.include?(char)
end

def closing_char?(char)
  brackets.values.include?(char)
end

def brackets
  { '(' => ')', '[' => ']', '{' => '}' }
end
