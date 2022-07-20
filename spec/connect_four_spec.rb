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
end






