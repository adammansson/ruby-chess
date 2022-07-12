# frozen_string_literal: true

class Pawn
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    if @color == 'white'
      "\u265F".encode('utf-8')
    else
      "\u2659".encode('utf-8')
    end
  end
end
