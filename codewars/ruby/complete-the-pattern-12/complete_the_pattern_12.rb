def pattern(n)
  return "" if n <= 0
  pattern_with_line_breaks(n)
end

def pattern_with_line_breaks(n)
  all_lines(n).join("\n")
end

def all_lines(n)
  v_lines(n) + [center_line(n)] + v_lines(n).reverse
end

def v_lines(n)
  1.upto(n - 1).map { |i| sym_line(i, n) }
end

def sym_line(i, n)
  edge(i) + digit(i) + center(i, n) + digit(i) + edge(i)
end

def center_line(n)
  edge(n) + digit(n) + edge(n)
end

def edge(n)
  " " * (n - 1)
end

def digit(n)
  (n % 10).to_s
end

def center(i, n)
  num_cols = n * 2 - 1
  num_edge_cols = 2 * i
  " " * (num_cols - num_edge_cols)
end
