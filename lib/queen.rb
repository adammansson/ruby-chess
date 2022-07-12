# frozen_string_literal: true

class Queen
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    if @color == 'white'
      "\u265B".encode('utf-8')
    else
      "\u2655".encode('utf-8')
    end
  end
end
