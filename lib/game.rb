# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  def initialize(player1 = Player.new('🔴'), player2 = Player.new('🟡'))
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def game_loop
    beginning
    current = @player2
    loop do
      current = switch_player(current)
      column = player_input(current)
      symbol = current.symbol
      @board.add_piece(@board.game_board, column, symbol)
      @board.print_board(@board.game_board)
      break if @board.check_win(@board.game_board, symbol) || @board.check_full(@board.game_board)
    end
    @board.check_full(@board.game_board) ? win : win(current)
  end

  def beginning
    intro
    enter_names
    @board.print_board(@board.game_board)
  end

  def switch_player(current)
    current == @player1 ? @player2 : @player1
  end

  def player_input(current)
    puts "#{current.name}, please enter a number between 1 and 7: "
    loop do
      input = gets.chomp
      if input.match?(/^\d+$/)
        verified = verify_input(input.to_i, @board)
      end
      return input.to_i if verified
      puts 'Error! Please enter a number between 1 and 7 for a column not yet full'
    end
  end

  def verify_input(input, board)
    if input.between?(1, 7)
      if board.row_free?(input, board.game_board)
        return true
      end
    end
    false
  end

  def enter_names
    puts 'Player 1, please enter your name:'
    @player1.name = gets.chomp
    puts ''
    puts 'Player 2, please enter your name:'
    @player2.name = gets.chomp
    puts "\n\n"
  end

  def intro
    puts <<~HEREDOC
      Welcome to Connect Four!

      Every turn, the current player will choose which column to place a tile in and
      the tile will fall and stack on other tiles in the same column.

      Player 1 is represented with 🔴
      Player 2 is represented with 🟡

      The first player to have 4 tiles in a row, horizontally, vertically, or
      diagonally wins!

      Who's ready for some Connect Four!?
    HEREDOC
  end

  def win(winner = 0)
    if winner == @player1
      puts "#{@player1.name} has won the game"
    elsif winner == @player2
      puts "#{@player2.name} has won the game"
    else
      puts 'The game has ended in a tie'
    end
    puts "\n"
    play_again
  end

  def play_again
    puts 'Would you like to play again? (y/n)'
    answer = gets.chomp
    if answer.downcase == 'y'
      game = Game.new
      game.game_loop
    else
      puts 'Thanks for playing'
    end
  end
end
