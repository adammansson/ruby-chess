# frozen_string_literal: true

require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'empty'
require_relative 'off_board'
require_relative 'position'

# Chess board
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
        position = Position.new(7 - rank_nbr, file_nbr)
        piece = Piece.from_char(char, position)
        file_nbr += char.between?('1', '8') ? char.to_i : 1
        piece
      end.flatten
    end
  end

  def self.pad_squares(position_array)
    horizontal_pad =
      position_array.map { |rank| [OffBoard.new] * 2 + rank + [OffBoard.new] * 2 }
    [[OffBoard.new] * 12] * 2 + horizontal_pad + [[OffBoard.new] * 12] * 2
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
    p piece.moves(self)
    piece.moves(self).include?(dest)
  end

  def make_move(piece, dest)
    set(piece.position, Empty.new)
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
