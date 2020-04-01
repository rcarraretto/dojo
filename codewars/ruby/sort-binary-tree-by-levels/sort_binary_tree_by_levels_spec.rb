it "returns empty list for empty tree" do
  Test.assert_equals([], tree_by_levels(nil))
end

it "sorts root only" do
  root = TreeNode.new(1)
  Test.assert_equals(tree_by_levels(root), [1])
end

it "sorts 2 levels" do
  c1_left = TreeNode.new(2)
  c1_right = TreeNode.new(3)
  root = TreeNode.new(1, c1_left, c1_right)
  Test.assert_equals(tree_by_levels(root), [1, 2, 3])
end

it "sorts 3 levels" do
  c_left_right = TreeNode.new(3)
  c_left = TreeNode.new(8, nil, c_left_right)

  c_right_right_right = TreeNode.new(7)
  c_right_right = TreeNode.new(5, nil, c_right_right_right)
  c_right = TreeNode.new(4, c_right_right)
  root = TreeNode.new(1, c_left, c_right)
  Test.assert_equals(tree_by_levels(root), [1, 8, 4, 3, 5, 7])
end
