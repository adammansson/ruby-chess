# frozen_string_literal: true

class Queen
  def initialize(color)
    @color = color
  end

  def to_s
    if @color == 'white'
      "\u265B".encode('utf-8')
    else
      "\u2655".encode('utf-8')
    end
  end
end
