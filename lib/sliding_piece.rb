# frozen_string_literal: true

require_relative 'piece'

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

class Bishop < SlidingPiece
  def self.transformations
    DIAGONALS
  end

  def to_s
    if @color == :white
      "\u265D".encode('utf-8')
    else
      "\u2657".encode('utf-8')
    end
  end
end

class Rook < SlidingPiece
  def self.transformations
    ORTHOGONALS
  end

  def to_s
    if @color == :white
      "\u265C".encode('utf-8')
    else
      "\u2656".encode('utf-8')
    end
  end
end

class Queen < SlidingPiece
  def self.transformations
    DIAGONALS + ORTHOGONALS
  end

  def to_s
    if @color == :white
      "\u265B".encode('utf-8')
    else
      "\u2655".encode('utf-8')
    end
  end
end
