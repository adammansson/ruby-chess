# frozen_string_literal: true

class Pawn
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_moves(board)
    moves = []
    if @color == 'w'
      if board.get(@position.add(1, 0)).is_a?(Empty)
        moves << @position.add(1, 0)
        moves << @position.add(2, 0) if @position.rank == 1 && board.get(@position.add(2, 0)).is_a?(Empty)
      end
      moves << @position.add(1, 1) if board.get(@position.add(1, 1)).color == 'b'
      moves << @position.add(1, -1) if board.get(@position.add(1, -1)).color == 'b'
    else
      if board.get(@position.add(-1, 0)).is_a?(Empty)
        moves << @position.add(-1, 0)
        moves << @position.add(-2, 0) if @position.rank == 6 && board.get(@position.add(-2, 0)).is_a?(Empty)
      end
      moves << @position.add(-1, 1) if board.get(@position.add(-1, 1)).color == 'w'
      moves << @position.add(-1, -1) if board.get(@position.add(-1, -1)).color == 'w'
    end
    moves
  end

  def to_s
    if @color == 'w'
      "\u265F".encode('utf-8')
    else
      "\u2659".encode('utf-8')
    end
  end
end
