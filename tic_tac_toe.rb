class Board
  attr_reader :squares, :player_turn, :winning_combos, :winner

  def initialize
    @squares = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @player_turn = 1
    @winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
                       [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @winner = nil
  end

  private

  def place(square)
    if @squares[square] == 'X' || @squares[square] == 'O'
      puts "That square is occupied. Please try again."
    elsif @player_turn == 1
      @squares[square] = 'X'
      show_board
      @player_turn = 2
    else
      @squares[square] = 'O'
      show_board
      @player_turn = 1
    end
  end

  def show_board
    puts "Behold the board:"
    puts "#{@squares[0]} #{@squares[1]} #{@squares[2]}"
    puts "#{@squares[3]} #{@squares[4]} #{@squares[5]}"
    puts "#{@squares[6]} #{@squares[7]} #{@squares[8]}"
  end

  def prompt(player)
    if player == 'Player 1'
      puts "Player 1, where would you like to place your X?"
    else
      puts "Player 2, where would you like to place your O?"
    end

    player = gets.chomp.to_i

    if player < 1 || player > 9
      puts "Invalid entry."
    else
      player -= 1
      winner?(player)
      place(player)
    end
  end

  def winner?(num)
    @winning_combos.each_with_index do |v, i|
      v.each_with_index do |e, j|
        if @player_turn == 1
          @winning_combos[i][j] = 'X' if e.eql? num
        else
          @winning_combos[i][j] = 'O' if e.eql? num
        end
        if v == %w[X X X]
          @winner = 'Player 1'
        elsif v == %w[O O O]
          @winner = 'Player 2'
        end
      end
    end
  end

  public

  def play_game
    show_board

    @keep_going = 0

    while @keep_going < 10
      if @winner
        puts "#{winner} wins!"
        @keep_going = 10
      elsif @player_turn == 1
        prompt('Player 1')
      else
        prompt('Player 2')
      end
      @keep_going += 1
    end
  end
end

game = Board.new
game.play_game
