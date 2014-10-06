require 'pry'
class Board
  attr_accessor :moves, :options
  def  initialize
    @moves = {}
    (1..9).each {|position| @moves[position] = ' '}
    @moves
    @options = *(1..9)
  end

  def draw
    divider = "\t\t -----+-----+-----"
    puts "\t\t   A     B     C  "
    puts "\t\t1  #{@moves[1]}  |  #{@moves[2]}  |  #{@moves[3]}  "
    puts divider
    puts "\t\t2  #{@moves[4]}  |  #{@moves[5]}  |  #{@moves[6]}  "
    puts divider
    puts "\t\t3  #{@moves[7]}  |  #{@moves[8]}  |  #{@moves[9]}  "
    puts "\nA1 - 1, B1 - 2, C1 - 3, A2 - 4, B2 - 5, C2 - 6, A3 - 7, B3 - 8, C3 - 9"
  end
end

class Player
  attr_accessor :name, :move, :position
  def initialize(name)
    @name = name
  end

  def move(board)
    puts "\t\t#{name}, choose a position (from 1 to 9):"
    @position = gets.chomp.to_i

    until board.options.include? position
      puts "\t\tPlease choose from one of the remaining options."
     @position = gets.chomp.to_i
    end

    board.moves[position] = "X"
    board.options.delete(position)
  end
end

class Computer
  attr_accessor :move, :position
  def initialize
  end

  def move(board)
    if (board.moves[2] == "X" && board.moves[3] == "X" && board.moves[1] == " ") ||
      (board.moves[4] == "X" && board.moves[7] == "X" && board.moves[1] == " ") ||
      (board.moves[5] == "X" && board.moves[9] == "X" && board.moves[1] == " ")
      @position = 1
    elsif (board.moves[1] == "X" && board.moves[3] == "X" && board.moves[2] == " ") ||
      (board.moves[5] == "X" && board.moves[8] == "X" && board.moves[2] == " ") ||
      (board.moves[5] == "X" && board.moves[9] == "X" && board.moves[2] == " ")
      @position = 2
    elsif (board.moves[2] == "X" && board.moves[1] == "X" && board.moves[3] == " ") ||
      (board.moves[6] == "X" && board.moves[9] == "X" && board.moves[3] == " ") ||
      (board.moves[5] == "X" && board.moves[7] == "X" && board.moves[3] == " ")
      @position = 3
    elsif (board.moves[5] == "X" && board.moves[6] == "X" && board.moves[4] == " ") ||
      (board.moves[1] == "X" && board.moves[7] == "X" && board.moves[4] == " ")
      @position = 4
    elsif (board.moves[4] == "X" && board.moves[6] == "X" && board.moves[5] == " ") ||
      (board.moves[2] == "X" && board.moves[8] == "X" && board.moves[5] == " ") ||
      (board.moves[1] == "X" && board.moves[9] == "X" && board.moves[5] == " ") ||
      (board.moves[3] == "X" && board.moves[7] == "X" && board.moves[5] == " ")
      @position = 5
    elsif (board.moves[4] == "X" && board.moves[5] == "X" && board.moves[6] == " ") ||
      (board.moves[3] == "X" && board.moves[9] == "X" && board.moves[6] == " ")
      @position = 6
    elsif (board.moves[8] == "X" && board.moves[9] == "X" && board.moves[7] == " ") ||
      (board.moves[1] == "X" && board.moves[4] == "X" && board.moves[7] == " ") ||
      (board.moves[5] == "X" && board.moves[3] == "X" && board.moves[7] == " ")
      @position = 7
    elsif (board.moves[7] == "X" && board.moves[9] == "X" && board.moves[8] == " ") ||
      (board.moves[2] == "X" && board.moves[5] == "X" && board.moves[8] == " ")
      @position = 8
    elsif (board.moves[7] == "X" && board.moves[8] == "X" && board.moves[9] == " ") ||
      (board.moves[6] == "X" && board.moves[3] == "X" && board.moves[9] == " ") ||
      (board.moves[5] == "X" && board.moves[1] == "X" && board.moves[9] == " ")
      @position = 9
    elsif board.moves.values.include? " "
      @position = board.options.sample
    end

    board.moves[position] = "O"
    board.options.delete(position)
  end
end

class Tic_Tac_Toe
  attr_accessor :board, :player, :computer, :name, :game
  def initialize
    puts "\t\tLet's play Tic-Tac-Toe!\n\t\tPlayer 1, Enter your name:"
    @name = gets.chomp.capitalize
    @board = Board.new
    board.draw
    @player = Player.new(name)
    @computer = Computer.new
  end

  def run
    player.move(board)
    board.draw
    computer.move(board)
    sleep(1)
    board.draw
    check_winner(board)
  end

  def check_winner(board)
    if (board.moves[1] == "X" && board.moves[2] == "X" && board.moves[3] == "X") ||
      (board.moves[4] == "X" && board.moves[5] == "X" && board.moves[6] == "X") ||
      (board.moves[7] == "X" && board.moves[8] == "X" && board.moves[9] == "X") ||
      (board.moves[1] == "X" && board.moves[4] == "X" && board.moves[7] == "X") ||
      (board.moves[2] == "X" && board.moves[5] == "X" && board.moves[8] == "X") ||
      (board.moves[3] == "X" && board.moves[6] == "X" && board.moves[9] == "X") ||
      (board.moves[1] == "X" && board.moves[5] == "X" && board.moves[9] == "X") ||
      (board.moves[3] == "X" && board.moves[5] == "X" && board.moves[7] == "X")
      puts "\t\tYou won!"
      play_again?(board)
    elsif (board.moves[1] == "O" && board.moves[2] == "O" && board.moves[3] == "O") ||
      (board.moves[4] == "O" && board.moves[5] == "O" && board.moves[6] == "O") ||
      (board.moves[7] == "O" && board.moves[8] == "O" && board.moves[9] == "O") ||
      (board.moves[1] == "O" && board.moves[4] == "O" && board.moves[7] == "O") ||
      (board.moves[2] == "O" && board.moves[5] == "O" && board.moves[8] == "O") ||
      (board.moves[3] == "O" && board.moves[6] == "O" && board.moves[9] == "O") ||
      (board.moves[1] == "O" && board.moves[5] == "O" && board.moves[9] == "O") ||
      (board.moves[3] == "O" && board.moves[5] == "O" && board.moves[7] == "O")
      puts "\t\tWomp, Womp, Womp... You lost.."
      play_again?(board)
    elsif board.moves.values.include? " "
      run
    else
      puts "\t\tIt's a draw!"
      play_again?(board)
    end
  end

    def play_again?(board)
    puts "\t\tWould you like to play again?"
    response = gets.chomp.upcase

    if response.include? 'Y'
      game = Tic_Tac_Toe.new
      game.run
    else
      puts "\t\tI'll take that as a no.. Thanks for playing!"
    end
  end
end

game = Tic_Tac_Toe.new
game.run