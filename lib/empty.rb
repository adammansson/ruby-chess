# frozen_string_literal: true

class Empty
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    ' '
  end
end
