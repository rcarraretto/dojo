def longest_slide_down(pyramid)
  max = pyramid.pop
  return pyramid.reverse.reduce(max) do |max, tops|
    sum_pairs(tops, best_for_each_top(max))
  end.first
end

def sum_pairs(array1, array2)
  [array1, array2].transpose.map { |pairs| pairs.reduce(:+) }
end

def best_for_each_top(max)
  max.each_cons(2).map { |pair| pair.max }
end
