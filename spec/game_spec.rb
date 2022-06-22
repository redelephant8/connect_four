# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#switch_player' do
    subject(:game_beginning) { described_class.new }

    it 'returns player2 when current is player1' do
      player1 = game_beginning.instance_variable_get(:@player1)
      player2 = game_beginning.instance_variable_get(:@player2)
      current_player = player1
      current_player = game_beginning.switch_player(current_player)
      expect(current_player).to eq(player2)
    end

    it 'returns player 1 when current is player2' do
      player1 = game_beginning.instance_variable_get(:@player1)
      player2 = game_beginning.instance_variable_get(:@player2)
      current_player = player2
      current_player = game_beginning.switch_player(current_player)
      expect(current_player).to eq(player1)
    end
  end

  describe '#verify_input' do
    subject(:game_mid) { described_class.new }

    it 'returns true when player inputs 5' do
      column = 5
      expect(game_mid.verify_input(column, game_mid.board.board, game_mid)).to eq(true)
    end

    it 'returns true when player inputs 7' do
      column = 7
      expect(game_mid.verify_input(column, game_mid)).to eq(true)
    end

    it 'returns false when player inputs 8' do
      column = 8
      expect(game_mid.verify_input(column, game_mid)).to eq(false)
    end

    it 'returns false when player inputs -1' do
      column = -1
      expect(game_mid.verify_input(column, game_mid)).to eq(false)
    end
  end

  describe '#player_input' do
    subject(:game_mid) { described_class.new }

    context 'input is valid' do

      before do
        valid_column = '5'
        allow(game_mid).to receive(:gets).and_return(valid_column)
      end

      it 'stops loop and does not show error message' do
        player1 = game_mid.instance_variable_get(:@player1)
        error_message = 'Please enter a number between 1 and 7'
        expect(game_mid).not_to receive(:puts).with(error_message)
        game_mid.player_input(player1)
      end
    end

    context 'input is invalid twice and then valid' do
      before do
        invalid_column = '%'
        invalid_number = '8'
        valid_column = '1'
        allow(game_mid).to receive(:gets).and_return(invalid_column, invalid_number, valid_column)
      end

      it 'shows error message twice and stops loop' do
        player1 = game_mid.instance_variable_get(:@player1)
        error_message = 'Please enter a number between 1 and 7'
        expect(game_mid).to receive(:puts).with(error_message).twice
        game_mid.player_input(player1)
      end
    end
  end

end
