# frozen_string_literal: true

# Empty chess piece
class Empty
  attr_reader :color

  def initialize
    @color = :empty
  end

  def to_s
    ' '
  end
end
