# frozen_string_literal: true

class Rook
  attr_reader :color, :position

  @@TRANSFORMATIONS =
    [[1, 0],
     [-1, 0],
     [0, 1],
     [0, -1]]

  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_moves(board)
    moves = []
    @@TRANSFORMATIONS.each do |tform|
      dir = tform
      loop do
        if @color == 'w'
          break if %w[w o].include?(board.get(@position.add(dir[0], dir[1])).color)
        elsif %w[b o].include?(board.get(@position.add(dir[0], dir[1])).color)
          break
        end
        moves << @position.add(dir[0], dir[1])
        dir = [dir[0] + tform[0], dir[1] + tform[1]]
      end
    end
    moves
  end

  def to_s
    if @color == 'w'
      "\u265C".encode('utf-8')
    else
      "\u2656".encode('utf-8')
    end
  end
end
