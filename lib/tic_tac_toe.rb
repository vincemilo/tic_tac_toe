class Board
  attr_reader :squares, :player_turn, :winning_combos, :winner

  def initialize
    @squares = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @player_turn = 1
    @winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
                       [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @winner = nil
  end

  def place(square)
    return unless valid_move?(square)

    update_board(square)
    @player_turn = if @player_turn == 1
                     2
                   else
                     1
                   end
  end

  def valid_move?(square)
    return true unless @squares[square] == 'X' || @squares[square] == 'O'

    puts 'That square is occupied. Please try again.'
    false
  end

  def update_board(square)
    @squares[square] = if @player_turn == 1
                         'X'
                       else
                         'O'
                       end
    show_board
    return unless winner?

    game_over
  end

  def game_over
    @winner = if @player_turn == 1
                'Player 1'
              else
                'Player 2'
              end
  end

  def show_board
    puts 'Behold the board:'
    puts "#{@squares[0]} #{@squares[1]} #{@squares[2]}"
    puts "#{@squares[3]} #{@squares[4]} #{@squares[5]}"
    puts "#{@squares[6]} #{@squares[7]} #{@squares[8]}"
  end

  def prompt
    display
    num = gets.chomp.to_i

    if num < 1 || num > 9 || num =~ /\D/
      puts 'Invalid entry.'
    else
      num -= 1
      place(num)
    end
  end

  def display
    if @player_turn == 1
      puts 'Player 1, where would you like to place your X?'
    else
      puts 'Player 2, where would you like to place your O?'
    end
  end

  def winner?
    @winning_combos.any? do |combo|
      [@squares[combo[0]], @squares[combo[1]], @squares[combo[2]]].uniq.length == 1
    end
  end

  def play_game
    puts 'Welcome to Tic-Tac-Toe!'
    show_board
    @keep_going = 0

    while @keep_going < 10
      if @winner
        puts "#{winner} wins!"
        @keep_going = 10
      else
        prompt
      end
      @keep_going += 1
    end
  end
end

game = Board.new
game.play_game
# game.place(1)
# p game.squares
