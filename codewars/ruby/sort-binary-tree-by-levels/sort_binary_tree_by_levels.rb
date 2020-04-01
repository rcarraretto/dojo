def tree_by_levels(node)
  level = [node]
  all_values(level)
end

def all_values(level)
  values = []
  while level.any?
    values += values_of_level(level)
    level = next_level(level)
  end
  return values
end

def values_of_level(nodes)
  nodes.map(&:value)
end

def next_level(nodes)
  nodes.reduce([]) do |next_level, node|
    next_level + [node.left, node.right].compact
  end
end

class TreeNode
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end
