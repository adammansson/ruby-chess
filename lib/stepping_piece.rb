# frozen_string_literal: true

require_relative 'piece'

# Superclass for stepping chess pieces
class SteppingPiece < Piece
  def moves(board)
    moves = []
    self.class.transformations.each do |tform|
      if [opposite_color, :empty].include?(board.get(@position.add(tform[0], tform[1])).color)
        moves << @position.add(tform[0], tform[1])
      end
    end
    moves
  end
end

# Knight chess piece
class Knight < SteppingPiece
  def self.transformations
    [[2, 1], [1, 2], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end

  def to_s
    @color == :white ? '♞' : '♘'
  end
end

# King chess piece
class King < SteppingPiece
  def self.transformations
    DIAGONALS + ORTHOGONALS
  end

  def to_s
    @color == :white ? '♚' : '♔'
  end
end
