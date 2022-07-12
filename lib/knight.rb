# frozen_string_literal: true

class Knight
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    if @color == 'white'
      "\u265E".encode('utf-8')
    else
      "\u2658".encode('utf-8')
    end
  end
end
