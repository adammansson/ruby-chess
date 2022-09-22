# frozen_string_literal: true

require_relative 'util'

# Superclass for all chess pieces
class Piece
  attr_reader :color, :position

  ORTHOGONALS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
  DIAGONALS   = [[1, 1], [-1, 1], [-1, -1], [1, -1]].freeze

  SYMBOLS     = {
    whiteking: '♚',
    whitequeen: '♛',
    whiterook: '♜',
    whitebishop: '♝',
    whiteknight: '♞',
    whitepawn: '♟',
    blackking: '♔',
    blackqueen: '♕',
    blackrook: '♖',
    blackbishop: '♗',
    blackknight: '♘',
    blackpawn: '♙'
  }.freeze

  def self.from_char(char, position)
    color = Util.upper?(char) ? :white : :black
    case char.upcase
    when 'K'
      King.new(color, position)
    when 'Q'
      Queen.new(color, position)
    when 'R'
      Rook.new(color, position)
    when 'B'
      Bishop.new(color, position)
    when 'N'
      Knight.new(color, position)
    when 'P'
      Pawn.new(color, position)
    else
      [Empty.new] * char.to_i
    end
  end

  def initialize(color, position)
    @color = color
    @position = position
  end

  def opposite_color
    @color == :white ? :black : :white
  end

  def to_s
    SYMBOLS[symname.to_sym]
  end
end

# Pawn chess piece
class Pawn < Piece
  def moves(board)
    moves = []
    if @color == :white
      if board.get(@position.add(1, 0)).is_a?(Empty)
        moves << @position.add(1, 0)
        moves << @position.add(2, 0) if @position.rank == 1 && board.get(@position.add(2, 0)).is_a?(Empty)
      end
      moves << @position.add(1, 1) if board.get(@position.add(1, 1)).color == opposite_color
      moves << @position.add(1, -1) if board.get(@position.add(1, -1)).color == opposite_color
    else
      if board.get(@position.add(-1, 0)).is_a?(Empty)
        moves << @position.add(-1, 0)
        moves << @position.add(-2, 0) if @position.rank == 6 && board.get(@position.add(-2, 0)).is_a?(Empty)
      end
      moves << @position.add(-1, 1) if board.get(@position.add(-1, 1)).color == opposite_color
      moves << @position.add(-1, -1) if board.get(@position.add(-1, -1)).color == opposite_color
    end
    moves
  end

  def symname
    @color.to_s + self.class.name.downcase
  end
end
