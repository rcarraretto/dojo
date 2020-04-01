require 'matrix'

def validSolution(board)
  segs = rows(board) + cols(board) + blocks(board)
  segs.all? { |seg| valid?(seg) }
end

def rows(board)
  board
end

def cols(board)
  board.transpose
end

def blocks(board)
  num_blocks = 9
  (0..num_blocks - 1).map { |index| block(board, index) }
end

def block(board, index)
  size = 3
  row = (index / size) * size
  col = (index % size) * size
  return Matrix[*board].minor(row, size, col, size).to_a.flatten
end

def valid?(numbers)
  numbers.sort == (1..9).to_a
end
