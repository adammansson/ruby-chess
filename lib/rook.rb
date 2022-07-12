# frozen_string_literal: true

class Rook
  def initialize(color)
    @color = color
  end

  def to_s
    if @color == 'white'
      "\u265C".encode('utf-8')
    else
      "\u2656".encode('utf-8')
    end
  end
end
