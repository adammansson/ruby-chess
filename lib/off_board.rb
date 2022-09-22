# frozen_string_literal: true

# Off board chess piece
class OffBoard
  attr_reader :color

  def initialize
    @color = :off_board
  end
end
