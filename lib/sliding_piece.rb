# frozen_string_literal: true

require_relative 'piece'

# Superclass for sliding chess pieces
class SlidingPiece < Piece
  def moves(board)
    moves = []
    self.class.transformations.each do |tform|
      dir = tform
      loop do
        dest = @position.add(dir[0], dir[1])
        break if [@color, :off_board].include?(board.get(dest).color)

        moves << dest
        break if board.get(dest).color == opposite_color

        dir = [dir[0] + tform[0], dir[1] + tform[1]]
      end
    end
    moves
  end
end

# Bishop chess piece
class Bishop < SlidingPiece
  def self.transformations
    DIAGONALS
  end
end

# Rook chess piece
class Rook < SlidingPiece
  def self.transformations
    ORTHOGONALS
  end
end

# Queen chess piece
class Queen < SlidingPiece
  def self.transformations
    DIAGONALS + ORTHOGONALS
  end
end
