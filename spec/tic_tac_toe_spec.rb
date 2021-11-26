require_relative '../lib/tic_tac_toe.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#place' do
    context 'when the space is unoccupied and it is player 1\'s turn' do
      it 'places an X on the board' do
        allow(board).to receive(:show_board)
        player_input = 0
        board.place(player_input)
        updated_board = board.squares
        updated_index_zero = ['X', 2, 3, 4, 5, 6, 7, 8, 9]
        expect(updated_board).to eq(updated_index_zero)
      end
    end

    context 'when the space is already occupied' do
      before do
        allow(board).to receive(:show_board)
        player_input = 0
        board.place(player_input)
      end
      it 'returns an error message' do
        player_input = 0
        error_message = 'That square is occupied. Please try again.'
        expect(board).to receive(:puts).with(error_message)
        board.place(player_input)
      end
    end
  end
end
