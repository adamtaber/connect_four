class ConnectFour
  attr_accessor :board 
  attr_accessor :turn_number

  def initialize
    @board = self.create_board
    @player_input = nil
    @turn_number = 0
    @player_symbol = nil
  end

  def create_board
    Array.new(6) { Array.new(7,"\u26AB") }
  end

  def print_board
    @board.each do |array|
      print "| "
      array.each do |item|
        print "#{item} | "
      end
      print "\n ---------------------------------- \n"
    end
    print "   1    2    3    4    5    6    7  \n"
  end

  def play_game
    puts "Welcome to Connect Four \n"
    print_board
    until game_over?
      if @turn_number % 2 == 0
        puts "Please enter a value corresponding to your chosen column, Player 1"
      elsif @turn_number % 2 == 1
        puts "Please enter a value corresponding to your chosen column, Player 2"
      end
      get_player_input
      if column_full?(@player_input)
        puts "That column is already full. Please choose a different column"
        get_player_input
      end
      if @turn_number % 2 == 0
        @player_symbol = "\u2B55"
        place_tile(@player_input, @player_symbol)
      elsif @turn_number % 2 == 1
        @player_symbol = "\u26aa"
        place_tile(@player_input, @player_symbol)
      end
      @turn_number += 1
      print_board
    end
    display_winner
  end

  def get_player_input
    loop do
      player_input = gets.chomp.to_i
      if player_input >= 1 && player_input <= 7
        @player_input = player_input
        return
      else
        puts 'That number is invalid. Please enter a number between 1 and 7'
      end
    end
  end

  def column_full?(column)
    @board[0][column-1] != "\u26AB"
  end

  def place_tile(column, player)
    found_location = false
    column_arr = @board.transpose[column-1].reverse
    new_column = column_arr.map do |n|
      if found_location == false && n == "\u26AB"
        found_location = true
        n = player
      else
        n = n
      end
    end
    temp_board = @board.transpose
    temp_board.delete_at(column-1)
    temp_board.insert(column-1, new_column.reverse)
    #temp_board.unshift(new_column.reverse)
    @board = temp_board.transpose
  end

  def game_over?
    true if connect_four?(@player_symbol) || last_turn?
  end

  def connect_four?(player)
    true if connect_row?(player) || connect_column?(player) || connect_plus_slope?(player) || connect_neg_slope?(player)
  end

  def connect_row?(player)
    connect_four = false
    count = 0
    @board.each do |arr|
      arr.each do |n|
        if count == 4
          connect_four = true
        elsif n == player
          count += 1
        else
          count = 0
        end
      end
    end
    connect_four
  end

  def connect_column?(player)
    connect_four = false
    count = 0
    @board.transpose.each do |arr|
      arr.each do |n|
        if count == 4
          connect_four = true
        elsif n == player
          count += 1
        else
          count = 0
        end
      end
    end
    connect_four
  end

  def connect_plus_slope?(player)
    connect_four = false
    5.downto(3) do |x|
      0.upto(3) do |y|
        if @board[x][y] == @board[x-1][y+1] && @board[x][y] == @board[x-2][y+2] && @board[x][y] == @board[x-3][y+3] && @board[x][y] == player
          connect_four = true
        end
      end
    end
    connect_four
  end

  def connect_neg_slope?(player)
    connect_four = false
    0.upto(2) do |x|
      0.upto(3) do |y|
        if @board[x][y] == @board[x+1][y+1] && @board[x][y] == @board[x+2][y+2] && @board[x][y] == @board[x+3][y+3] && @board[x][y] == player
          connect_four = true
        end
      end
    end
    connect_four
  end

  def last_turn?
    @turn_number == 42
  end

  def display_winner
    if last_turn? && !connect_four?(@player_symbol)
      puts "It's a tie!"
    elsif (@turn_number - 1) % 2 == 0
      puts "Player 1 is the winner!"
    elsif (@turn_number - 1) % 2 == 1
      puts "Player 2 is the winner!"
    end
  end

end
test = ConnectFour.new
test.play_game

#default symbol: "\u25ef"
#player1 symbol: "\u26aa"
#player2 symbol: "\u26ab"

#\u2B55
#\u2B24