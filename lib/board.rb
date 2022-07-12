# frozen_string_literal: true

require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
require_relative 'empty'
require_relative 'off_board'

class Board
  def initialize(
    squares,
    active_color,
    castling_availability,
    en_passant_target_square,
    halfmove_clock,
    fullmove_number
  )

    # A 12x12 board, to deal with off the board problems during move generation.
    @squares = squares
    @active_color = active_color
    @castling_availability = castling_availability
    @en_passant_target_square = en_passant_target_square
    @halfmove_clock = halfmove_clock
    @fullmove_number = fullmove_number
  end

  def self.from_fen(fen_string)
    fen_array = fen_string.split(' ')
    fen_array[0] = pad_squares(position_from_fen(fen_array[0]))
    Board.new(*fen_array)
  end

  def self.position_from_fen(position_string)
    position_string.split('/').map do |rank|
      rank.split('').map do |char|
        case char
        when 'K'
          King.new('white')
        when 'k'
          King.new('black')
        when 'Q'
          Queen.new('white')
        when 'q'
          Queen.new('black')
        when 'R'
          Rook.new('white')
        when 'r'
          Rook.new('black')
        when 'B'
          Bishop.new('white')
        when 'b'
          Bishop.new('black')
        when 'N'
          Knight.new('white')
        when 'n'
          Knight.new('black')
        when 'P'
          Pawn.new('white')
        when 'p'
          Pawn.new('black')
        else
          [Empty.new] * char.to_i
        end
      end.flatten
    end
  end

  def self.pad_squares(position_array)
    horizontal_pad =
      position_array.map { |rank| [OffBoard.new] * 2 + rank + [OffBoard.new] * 2 }
    [[OffBoard.new] * 12] * 2 + horizontal_pad + [[OffBoard.new] * 12] * 2
  end

  def to_s
    @squares.map do |rank|
      rank.map(&:to_s).join(' ')
    end.join("\n")
  end
end
