# frozen_string_literal: true

class King
  def initialize(color)
    @color = color
  end

  def to_s
    if @color == 'white'
      "\u265A".encode('utf-8')
    else
      "\u2654".encode('utf-8')
    end
  end
end
