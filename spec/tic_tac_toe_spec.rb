# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    context 'when the space is unoccupied' do
      it 'returns true' do
        player_input = 0
        expect(board.valid_move?(player_input)).to be true
      end
    end

    context 'when the space is already occupied' do
      before do
        allow(board).to receive(:puts)
        board.instance_variable_set(:@squares, ['X', 2, 3, 4, 5, 6, 7, 8, 9])
      end

      it 'returns an error message' do
        player_input = 0
        error_message = 'That square is occupied. Please try again.'
        expect(board).to receive(:puts).with(error_message)
        board.valid_move?(player_input)
      end

      it 'returns false' do
        player_input = 0
        expect(board.valid_move?(player_input)).to be false
      end
    end
  end

  describe '#update_board' do
    context 'when it is player 1\'s turn' do
      before do
        allow(board).to receive(:show_board)
        player_input = 0
        board.update_board(player_input)
      end

      it 'places an X on square 1' do
        updated_board = board.squares
        updated_index_zero = ['X', 2, 3, 4, 5, 6, 7, 8, 9]
        expect(updated_board).to eq(updated_index_zero)
      end
    end

    context 'when it is player 2\'s turn' do
      before do
        allow(board).to receive(:show_board)
        board.instance_variable_set(:@player_turn, 2)
        player_input = 0
        board.update_board(player_input)
      end

      it 'places an O on square 1' do
        updated_board = board.squares
        updated_index_zero = ['O', 2, 3, 4, 5, 6, 7, 8, 9]
        expect(updated_board).to eq(updated_index_zero)
      end
    end
  end

  describe '#prompt' do
    context 'when a player enters a valid entry' do
      before do
        allow(board).to receive(:puts)
        allow(board).to receive(:gets).and_return('3')
        allow(board).to receive(:place)
      end

      it 'proceeds to the next method' do
        expect(board).to receive(:place)
        board.prompt
      end
    end

    context 'when a player puts enters an invalid entry' do
      before do
        allow(board).to receive(:puts)
        allow(board).to receive(:gets).and_return('$')
      end

      it 'returns an error message' do
        error_message = 'Invalid entry.'
        expect(board).to receive(:puts).with(error_message)
        board.prompt
      end
    end
  end

  describe '#winner?' do
    context 'when there are three Os or Xs in a row' do
      before do
        board.instance_variable_set(:@squares, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
      end

      it 'returns true' do
        expect(board).to be_winner
      end
    end

    context 'when there are not three in a row' do
      it 'returns false' do
        expect(board).to_not be_winner
      end
    end
  end

  describe '#play_game' do
    # to do
  end
end
