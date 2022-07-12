# frozen_string_literal: true

class King
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    if @color == 'white'
      "\u265A".encode('utf-8')
    else
      "\u2654".encode('utf-8')
    end
  end
end
