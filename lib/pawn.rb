# frozen_string_literal: true

class Pawn
  def initialize(color)
    @color = color
  end

  def to_s
    if @color == 'white'
      "\u265F".encode('utf-8')
    else
      "\u2659".encode('utf-8')
    end
  end
end
