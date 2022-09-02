# frozen_string_literal: true

require_relative 'board'
require_relative 'position'

class Game
  def initialize
    @board = Board.from_fen('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
  end

  def self.get_position(prompt)
    loop do
      print prompt
      input = gets.chomp
      if %w[q quit].include?(input)
        exit
      elsif Position.valid?(input)
        return Position.from_string(input)
      end
    end
  end

  def valid_piece_to_move?(piece)
    if piece.is_a?(Empty)
      puts 'No piece on that square'
      false
    elsif piece.color == :black && @board.active_color == 'w'
      puts "You can't move a black piece"
      false
    elsif piece.color == :white && @board.active_color == 'b'
      puts "You can't move a white piece"
      false
    else
      true
    end
  end

  def make_move
    loop do
      start = self.class.get_position('Enter the square of the piece you want to move (eg. e2): ')
      piece = @board.get(start)
      next unless valid_piece_to_move?(piece)

      dest = self.class.get_position('Enter the square you want to move the piece to (eg. e4): ')
      unless @board.valid_move?(piece, dest)
        puts 'Invalid move'
        next
      end
      @board.make_move(piece, dest)
      break
    end
  end

  def play
    loop do
      puts "\nBoard:"
      puts @board
      make_move
    end
  end
end
