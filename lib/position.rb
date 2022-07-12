# frozen_string_literal: true

class Position
  attr_reader :rank, :file

  def initialize(rank, file)
    @rank = rank
    @file = file
  end

  def to_s
    "#{('a'.ord + @file).chr}#{@rank + 1}"
  end
end
