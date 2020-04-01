def get_socks(name, socks)
  count_socks_per_color = group_socks_by_color(socks)
  pair_of_socks(name, count_socks_per_color)
end

def pair_of_socks(name, count_socks_per_color)
  if name == 'Henry'
    return pair_of_socks_with_same_color(count_socks_per_color)
  end
  pair_of_socks_with_distinct_color(count_socks_per_color)
end

def group_socks_by_color(socks)
  socks.inject({}) do |count_socks_per_color, color|
    count_socks_per_color[color] ||= 0
    count_socks_per_color[color] += 1
    count_socks_per_color
  end
end

def pair_of_socks_with_same_color(count_socks_per_color)
  colors_with_pair = count_socks_per_color
    .select { |color, count| count >= 2 }
    .keys
  return [] if colors_with_pair.empty?
  Array.new(2, colors_with_pair.first)
end

def pair_of_socks_with_distinct_color(count_socks_per_color)
  distinct_colors = count_socks_per_color.keys
  return [] if distinct_colors.length < 2
  distinct_colors.shift(2)
end
