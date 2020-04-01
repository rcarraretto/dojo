def s(minemap, miner, exit)
  minemap = minemap.transpose
  miner = { 'x' => miner[1], 'y' => miner[0] }
  exit = { 'x' => exit[1], 'y' => exit[0] }
  solve(minemap, miner, exit)
end

Test.describe('A trivial map (1x1)') do
  m = [
    [true]
  ]
  Test.assert_equals(s(m, [0, 0], [0, 0]), [])
end

Test.describe('top left wall') do
  m = [
    [false, true],
    [true, true]
  ]
  Test.assert_equals(s(m, [0, 1], [1, 0]), ['down', 'left'])
  Test.assert_equals(s(m, [1, 0], [0, 1]), ['right', 'up'])
end

Test.describe('top right wall') do
  m = [
    [true, false],
    [true, true]
  ]
  Test.assert_equals(s(m, [1, 1], [0, 0]), ['left', 'up'])
  Test.assert_equals(s(m, [0, 0], [1, 1]), ['down', 'right'])
end

Test.describe('bottom left wall') do
  m = [
    [true, true],
    [false, true]
  ]
  Test.assert_equals(s(m, [0, 0], [1, 1]), ['right', 'down'])
  Test.assert_equals(s(m, [1, 1], [0, 0]), ['up', 'left'])
end

Test.describe('bottom right wall') do
  m = [
    [true, true],
    [true, false]
  ]
  Test.assert_equals(s(m, [1, 0], [0, 1]), ['up', 'right'])
  Test.assert_equals(s(m, [0, 1], [1, 0]), ['left', 'down'])
end

Test.describe('A linear map(1x4)') do
  minemap = [
    [true],
    [true],
    [true],
    [true]
  ]

  Test.it('Should return a chain of moves to the right') do
    Test.assert_equals(solve(minemap, {'x'=>0,'y'=>0}, {'x'=>3,'y'=>0}), ['right', 'right', 'right'])
  end

  Test.it('Should return a chain of moves to the left') do
    Test.assert_equals(solve(minemap, {'x'=>3,'y'=>0}, {'x'=>0,'y'=>0}), ['left', 'left', 'left'])
  end
end

Test.describe('Should walk around an obstacle (3x3 map)') do
  m = [
    [true, false, true],
    [true, false, true],
    [true, true, true]
  ]
  solution = ['down', 'down', 'right', 'right', 'up', 'up']
  Test.assert_equals(s(m, [0, 0], [0, 2]), solution)
end

Test.describe('Dead end') do
  m = [
    [true, true, true],
    [false, true, false],
  ]
  Test.assert_equals(s(m, [1, 1], [0, 0]), ['up', 'left'])
  Test.assert_equals(s(m, [1, 1], [0, 2]), ['up', 'right'])
end
