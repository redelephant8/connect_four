# frozen_string_literal: true

# class for the main mechanics of the connect four game
class Board
  attr_reader :game_board

  def initialize(game_board = Array.new(6) { Array.new(7) { '⚪' } })
    @game_board = game_board
  end

  def print_board(game_board)
    game_board.reverse_each do |row|
      row.each do |cell|
        print " #{cell} "
      end
      puts "\n\n"
    end
  end

  def add_piece(game_board, column, symbol)
    column -= 1
    row = choose_row(game_board, column)
    game_board[row][column] = symbol
    game_board
  end

  def choose_row(game_board, column)
    game_board.each_with_index do |row, idx|
      return idx if row[column] == '⚪'
    end
  end

  def row_free?(column, game_board)
    game_board.each do |row|
      return true if row[column - 1] == '⚪'
    end
    return false
  end

  def check_win(game_board, symbol)
    return true if check_vertically(game_board, symbol) || check_horizontally(game_board, symbol) || check_diagonally(game_board, symbol)
    false
  end

  def check_vertically(game_board, symbol)
    column = 0
    loop do
      row = 0
      until row > 2
        if game_board[row][column] == symbol && game_board[row + 1][column] == symbol && game_board[row + 2][column] == symbol && game_board[row + 3][column] == symbol
          return true
        end

        row += 1
      end
      column == 6 ? break : column += 1
    end
    false
  end

  def check_horizontally(game_board, symbol)
    row = 0
    loop do
      column = 0
      until column > 3
        if game_board[row][column] == symbol && game_board[row][column + 1] == symbol && game_board[row][column + 2] == symbol && game_board[row][column + 3] == symbol
          return true
        end

        column += 1
      end
      row == 5 ? break : row += 1
    end
    false
  end

  def check_diagonally(game_board, symbol)
    row = 0
    loop do
      return true if check_diagonally_right(game_board, row, symbol) == true || check_diagonally_left(game_board, row, symbol) == true

      row == 2 ? break : row += 1
    end
    false
  end


  def check_diagonally_right(game_board, row, symbol)
    column = 0
    loop do
      if game_board[row][column] == symbol && game_board[row + 1][column + 1] == symbol && game_board[row + 2][column + 2] == symbol && game_board[row + 3][column + 3] == symbol
        return true
      end

      column == 4 ? break : column += 1
    end
    false
  end

  def check_diagonally_left(game_board, row, symbol)
    column = game_board[0].length - 1
    loop do
      if game_board[row][column] == symbol && game_board[row + 1][column - 1] == symbol && game_board[row + 2][column - 2] == symbol && game_board[row + 3][column - 3] == symbol
        return true
      end

      column == 2 ? break : column -= 1
    end
    false
  end

  def check_full(game_board)
    game_board.each do |row|
      return false if row.include?('⚪')
    end
    true
  end
end

