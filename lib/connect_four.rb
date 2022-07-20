class ConnectFour
  attr_accessor :board

  def initialize
    @board = self.create_board
    @player_input = nil
  end

  def create_board
    Array.new(6) { Array.new(7,"\u25ef") }
  end

  def print_board
    @board.each do |array|
      print "| "
      array.each do |item|
        print "#{item} | "
      end
      print "\n"
      print " --------------------------- "
      print "\n"
    end
  end

  def play_game
    until game_over?
      puts "Please enter a value corresponding to your chosen column"
      get_player_input
      if column_full?(@player_input)
        puts "That column is already full. Please choose a different column"
        get_player_input
      end
    end
  end

  def get_player_input
    loop do
      player_input = gets.chomp.to_i
      if player_input >= 1 && player_input <= 7
        @player_input == player_input
        return
      else
        puts 'That number is invalid. Please enter a number between 1 and 7'
      end
    end
  end

  def column_full?(input)
    @board[0][input-1] != "\u25ef"
  end
end

#player1 symbol: "\u26aa"
#player2 symbol: "\u26ab"