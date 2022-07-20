require_relative '../lib/connect_four'

describe ConnectFour do

  describe '#get_player_input' do
    subject { described_class.new }

    context 'when input is in the acceptable range' do
      before do
        valid_input = '1'
        allow(subject).to receive(:gets).and_return(valid_input)
      end

      it 'ends loop and does not display error message' do
        error_message = 'That number is invalid. Please enter a number between 1 and 7'
        expect(subject).not_to receive(:puts).with(error_message)
        subject.get_player_input
      end
    end

    context 'when first input is outside the accepted range, followed by an accepted input' do
      before do
        invalid_input = '0'
        valid_input = '1'
        allow(subject).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'ends the loop after displaying the error message once' do
        error_message = 'That number is invalid. Please enter a number between 1 and 7'
        expect(subject).to receive(:puts).with(error_message).once
        subject.get_player_input
      end
    end

    context 'when first input is not an integer, followed by an accepted input' do
      before do
        invalid_input = 'hello'
        valid_input = '1'
        allow(subject).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'ends the loop after displaying the error message once' do
        error_message = 'That number is invalid. Please enter a number between 1 and 7'
        expect(subject).to receive(:puts).with(error_message).once
        subject.get_player_input
      end
    end
  end

  describe '#column_full?' do
    subject { described_class.new }

    context 'when column is not full' do
      it 'returns false' do
        column = subject.column_full?(1)
        expect(column).to be(false)
      end
    end

    context 'when column is full' do
      it 'returns true' do
        new_array = subject.board.transpose
        new_array.shift
        full_column = Array.new(6, "\u26aa")
        new_array.unshift(full_column)
        subject.board = new_array.transpose
        column = subject.column_full?(1)
        expect(column).to be(true)
      end
    end 
  end

  describe '#place_tile' do
    subject { described_class.new }

    it 'places the tile in an empty column' do
      subject.place_tile(1, "\u26aa")
      expect(subject.board[5][0]).to eq("\u26aa")
    end

    context "when placing multiple tiles" do
      before do
        subject.place_tile(1, "\u26aa")
        subject.place_tile(1, "\u2b55")
      end

      it 'shows the first tile in the lowest position' do
        expect(subject.board[5][0]).to eq("\u26aa")
      end

      it 'shows the second tile in the second lowest position' do
        expect(subject.board[4][0]).to eq("\u2b55")
      end
    end
  end

  describe '#last_turn?' do
    subject { described_class.new }
    it 'returns true if it is the last turn' do
      subject.turn_number = 42
      expect(subject.last_turn?).to be(true)
    end

    it 'returns false if it is not the last turn' do
      subject.turn_number = 4
      expect(subject.last_turn?).to be(false)
    end
  end

  describe '#connect_four?' do
    subject { described_class.new }
    it 'returns true if 4 of the same symbol in a row' do
      subject.board[5][0] = "\u2B55"
      subject.board[5][1] = "\u2B55"
      subject.board[5][2] = "\u2B55"
      subject.board[5][3] = "\u2B55"
      expect(subject.connect_four?("\u2B55")).to be(true)
    end

    it 'returns true if 4 of the same symbol in a column' do
      subject.board[5][0] = "\u2B55"
      subject.board[4][0] = "\u2B55"
      subject.board[3][0] = "\u2B55"
      subject.board[2][0] = "\u2B55"
      expect(subject.connect_four?("\u2B55")).to be(true)
    end

    it 'returns true if 4 of the same symbol in a positive slope' do
      subject.board[0][3] = "\u2B55"
      subject.board[1][2] = "\u2B55"
      subject.board[2][1] = "\u2B55"
      subject.board[3][0] = "\u2B55"
      expect(subject.connect_four?("\u2B55")).to be(true)
    end

    it 'returns true if 4 of the same symbol in a negative slope' do
      subject.board[0][0] = "\u2B55"
      subject.board[1][1] = "\u2B55"
      subject.board[2][2] = "\u2B55"
      subject.board[3][3] = "\u2B55"
      expect(subject.connect_four?("\u2B55")).to be(true)
    end
  end
end






