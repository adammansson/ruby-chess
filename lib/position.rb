# frozen_string_literal: true

class Position
  attr_reader :rank, :file

  def initialize(rank, file)
    @rank = rank
    @file = file
  end

  def self.from_string(string)
    array = string.split('')
    rank = array[1].to_i - 1
    file = array[0].ord - 'a'.ord
    Position.new(rank, file)
  end

  def self.valid?(position)
    array = position.split('')
    if array.length != 2
      puts "Input wasn't a rank and a file"
      false
    elsif !array[0].between?('a', 'h')
      puts 'Rank out of range'
      false
    elsif !array[1].between?('1', '8')
      puts 'File out of range'
      false
    else
      true
    end
  end

  def ==(other)
    @rank == other.rank && @file == other.file
  end

  def add(rank, file)
    Position.new(@rank + rank, @file + file)
  end

  def update(position)
    @rank = position.rank
    @file = position.file
  end

  def to_s
    "#{('a'.ord + @file).chr}#{@rank + 1}"
  end
end
