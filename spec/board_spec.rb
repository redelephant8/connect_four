# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#choose_row' do
    subject(:game_beginning) { described_class.new }

    it 'choses the final row when column is empty' do
      board = game_beginning.instance_variable_get(:@board)
      column = 1
      row = game_beginning.choose_row(board, column)
      expect(row).to eq(0)
    end
  end

  describe '#add_piece' do
    subject(:game_beginning) { described_class.new }

    it 'adds piece to the 1st column' do
      board = game_beginning.instance_variable_get(:@board)
      column = 1
      symbol = 'o'
      game_beginning.add_piece(board, column, symbol)
      expect(game_beginning.board[0]).to eq(%w[o ⚪ ⚪ ⚪ ⚪ ⚪ ⚪])
    end

    it 'stacks pieces when two are placed in the same column' do
      board = game_beginning.instance_variable_get(:@board)
      column = 1
      symbol = 'o'
      game_beginning.add_piece(board, column, symbol)
      game_beginning.add_piece(board, column, symbol)
      expect(game_beginning.board[1]).to eq(%w[o ⚪ ⚪ ⚪ ⚪ ⚪ ⚪])
    end
  end

  describe '#check_vertically' do
    subject(:game_mid) { described_class.new }

    it 'returns true when 4 of the same are vertical' do
      board = game_mid.instance_variable_get(:@board)
      column = 2
      symbol = 'x'
      4.times { game_mid.add_piece(board, column, symbol) }
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end

    it 'returns false when no vertical are the same' do
      board = game_mid.instance_variable_get(:@board)
      column = 3
      symbol = 'x'
      3.times { game_mid.add_piece(board, column, symbol) }
      game_mid.add_piece(board, column, 'o')
      # game_mid.print_board(board)
      expect(game_mid.check_win(board, symbol)).to eq(false)
    end
  end

  describe '#check_horizontally' do
    subject(:game_mid) { described_class.new }

    it 'returns true when 4 of the same are horizontal' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      game_mid.add_piece(board, 1, symbol)
      game_mid.add_piece(board, 2, symbol)
      game_mid.add_piece(board, 3, symbol)
      game_mid.add_piece(board, 4, symbol)
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end

    it 'returns false when no horizontal are the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      game_mid.add_piece(board, 1, symbol)
      game_mid.add_piece(board, 2, symbol)
      game_mid.add_piece(board, 3, symbol)
      expect(game_mid.check_win(board, symbol)).to eq(false)
    end
  end

  describe '#check_diagonally_right' do
    subject(:game_mid) { described_class.new }

    it 'returns true when 4 diagonally right are the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[3] = [0, 0, 0, 'x', 0, 0, 0]
      board[2] = [0, 0, 'x', 0, 0, 0, 0]
      board[1] = [0, 'x', 0, 0, 0, 0, 0]
      board[0] = ['x', 0, 0, 0, 0, 0, 0]
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end

    it 'returns false when 4 diagonally right are not the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[3] = [0, 0, 0, 'x', 0, 0, 0]
      board[2] = [0, 0, 'x', 0, 0, 0, 0]
      board[1] = [0, 'x', 0, 0, 0, 0, 0]
      expect(game_mid.check_win(board, symbol)).to eq(false)
    end

    it 'returns true when higher 4 diagonally right are the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[5] = [0, 0, 0, 'x', 0, 0, 0]
      board[4] = [0, 0, 'x', 0, 0, 0, 0]
      board[3] = [0, 'x', 0, 0, 0, 0, 0]
      board[2] = ['x', 0, 0, 0, 0, 0, 0]
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end
  end

  describe '#check_diagonally_left' do
    subject(:game_mid) { described_class.new }

    it 'returns true when 4 diagonally left are the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[3] = [0, 0, 0, 'x', 0, 0, 0]
      board[2] = [0, 0, 0, 0, 'x', 0, 0]
      board[1] = [0, 0, 0, 0, 0, 'x', 0]
      board[0] = [0, 0, 0, 0, 0, 0, 'x']
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end

    it 'returns false when 4 diagonally left are not the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[3] = [0, 0, 0, 'x', 0, 0, 0]
      board[2] = [0, 0, 0, 0, 'x', 0, 0]
      board[1] = [0, 0, 0, 0, 0, 'x', 0]
      expect(game_mid.check_win(board, symbol)).to eq(false)
    end

    it 'returns true when higher 4 diagonally left are the same' do
      board = game_mid.instance_variable_get(:@board)
      symbol = 'x'
      board[5] = [0, 0, 0, 'x', 0, 0, 0]
      board[4] = [0, 0, 0, 0, 'x', 0, 0]
      board[3] = [0, 0, 0, 0, 0, 'x', 0]
      board[2] = [0, 0, 0, 0, 0, 0, 'x']
      expect(game_mid.check_win(board, symbol)).to eq(true)
    end
  end

  describe '#check_full' do
    subject(:game_end) { described_class.new }

    it 'returns true when all cells are filled' do
      board = game_end.instance_variable_get(:@board)
      board[5] = %w[x x x x x x x]
      board[4] = %w[x x x x x x x]
      board[3] = %w[x x x x x x x]
      board[2] = %w[x x x x x x x]
      board[1] = %w[x x x x x x x]
      board[0] = %w[x x x x x x x]
      expect(game_end.check_full(board)).to eq(true)
    end

    it 'returns false when not all cells are filled' do
      board = game_end.instance_variable_get(:@board)
      board[5] = %w[x x x x x x x]
      board[4] = %w[x x x x x x x]
      expect(game_end.check_full(board)).to eq(false)
    end
  end
end
