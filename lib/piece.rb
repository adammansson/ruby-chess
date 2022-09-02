# frozen_string_literal: true

class Piece
  attr_reader :color, :position

  ORTHOGONALS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS   = [[1, 1], [-1, 1], [-1, -1], [1, -1]]

  def initialize(color, position)
    @color = color
    @position = position
  end

  def opposite_color
    return :black if @color == :white

    :white
  end
end

class Pawn < Piece
  def moves(board)
    moves = []
    if @color == :white
      if board.get(@position.add(1, 0)).is_a?(Empty)
        moves << @position.add(1, 0)
        moves << @position.add(2, 0) if @position.rank == 1 && board.get(@position.add(2, 0)).is_a?(Empty)
      end
      moves << @position.add(1, 1) if board.get(@position.add(1, 1)).color == opposite_color
      moves << @position.add(1, -1) if board.get(@position.add(1, -1)).color == opposite_color
    else
      if board.get(@position.add(-1, 0)).is_a?(Empty)
        moves << @position.add(-1, 0)
        moves << @position.add(-2, 0) if @position.rank == 6 && board.get(@position.add(-2, 0)).is_a?(Empty)
      end
      moves << @position.add(-1, 1) if board.get(@position.add(-1, 1)).color == opposite_color
      moves << @position.add(-1, -1) if board.get(@position.add(-1, -1)).color == opposite_color
    end
    moves
  end

  def to_s
    if @color == :white
      "\u265F".encode('utf-8')
    else
      "\u2659".encode('utf-8')
    end
  end
end
