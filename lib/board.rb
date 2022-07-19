# frozen_string_literal: true

require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
require_relative 'empty'
require_relative 'off_board'
require_relative 'position'

class Board
  attr_reader :active_color, :castling_availability, :en_passant_target_square

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
    position_string.split('/').map.with_index do |rank, rank_nbr|
      file_nbr = 0
      rank.split('').map do |char|
        piece = piece_from_char(char, 7 - rank_nbr, file_nbr)
        file_nbr += char.between?('1', '8') ? char.to_i : 1
        piece
      end.flatten
    end
  end

  def self.piece_from_char(char, rank, file)
    position = Position.new(rank, file)
    case char
    when 'K'
      King.new('w', position)
    when 'k'
      King.new('b', position)
    when 'Q'
      Queen.new('w', position)
    when 'q'
      Queen.new('b', position)
    when 'R'
      Rook.new('w', position)
    when 'r'
      Rook.new('b', position)
    when 'B'
      Bishop.new('w', position)
    when 'b'
      Bishop.new('b', position)
    when 'N'
      Knight.new('w', position)
    when 'n'
      Knight.new('b', position)
    when 'P'
      Pawn.new('w', position)
    when 'p'
      Pawn.new('b', position)
    else
      [Empty.new('e')] * char.to_i
    end
  end

  def self.pad_squares(position_array)
    horizontal_pad =
      position_array.map { |rank| [OffBoard.new('o')] * 2 + rank + [OffBoard.new('o')] * 2 }
    [[OffBoard.new('o')] * 12] * 2 + horizontal_pad + [[OffBoard.new('o')] * 12] * 2
  end

  def get(position)
    # Taking into account OffBoard and reverse order of ranks
    @squares[9 - position.rank][position.file + 2]
  end

  def set(position, piece)
    # Taking into account OffBoard and reverse order of ranks
    @squares[9 - position.rank][position.file + 2] = piece
    piece
  end

  def valid_move?(piece, dest)
    p piece.valid_moves(self)
    p dest
    piece.valid_moves(self).include?(dest)
  end

  def make_move(piece, dest)
    set(piece.position, Empty.new('e'))
    set(dest, piece)
    piece.position.update(dest)
    @active_color = if @active_color == 'w'
                      'b'
                    else
                      'w'
                    end
  end

  def to_s
    @squares[2..9].map.with_index do |rank, rank_nbr|
      "#{8 - rank_nbr} #{rank[2..9].map(&:to_s).join(' ')}"
    end.join("\n") + "\n  A B C D E F G H"
  end
end
