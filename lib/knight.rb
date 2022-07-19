# frozen_string_literal: true

class Knight
  attr_reader :color, :position

  @@TRANSFORMATIONS =
    [[2, 1],
     [1, 2],
     [2, -1],
     [1, -2],
     [-1, -2],
     [-2, -1],
     [-2, 1],
     [-1, 2]]

  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_moves(board)
    moves = []
    @@TRANSFORMATIONS.each do |tform|
      if @color == 'w'
        if %w[b e].include?(board.get(@position.add(tform[0], tform[1])).color)
          moves << @position.add(tform[0], tform[1])
        end
      else
        if %w[w e].include?(board.get(@position.add(tform[0], tform[1])).color)
          moves << @position.add(tform[0], tform[1])
        end
      end
    end
    moves
  end

  def to_s
    if @color == 'w'
      "\u265E".encode('utf-8')
    else
      "\u2658".encode('utf-8')
    end
  end
end
