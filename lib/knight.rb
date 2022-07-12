# frozen_string_literal: true

class Knight
  def initialize(color)
    @color = color
  end

  def to_s
    if @color == 'white'
      "\u265E".encode('utf-8')
    else
      "\u2658".encode('utf-8')
    end
  end
end
