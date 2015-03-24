# Game Class
# ==========
# This is the class that controls the entire TicTacToe game in the back-end
# The class will track all the moves that players make as well as their names
# and the entire play field.
#
# The play field is going to be stored in a 3x3 Array to avoid too much variable clutter.
# As we only need to check specific patterns, the amount of checking here can be done in a single
# for-loop.
#
# Player one will be tracked using "O" as value, and player two will be tracked as "X".
# These values will be defined as class constants to ensure that they cannot be tampered with.
#
class Game
  PLAYER_1_SYMBOL = "O"
  PLAYER_2_SYMBOL = "X"
  attr_accessor :player_1, :player_2, :grid, :moves, :winner, :active_player
  attr_accessor :player_1_score, :player_2_score

  # Initializes a new instance of the game, and stores the provided information in the
  # internal variables.
  # The following information needs to be provided:
  #
  # - player_1: The name of the first player
  # - player_2: The name of the second player
  def initialize(player_1 = "player 1", player_2 = "player 2")
    @player_1 = player_1
    @player_2 = player_2
    @player_1_score = 0
    @player_2_score = 0
    init_game
  end

  # Sets the provided value in the specified row and column of the board.
  # If the set operation succeeds, true is returned; otherwise false.
  def set(row, col, val)
    if [PLAYER_1_SYMBOL, PLAYER_2_SYMBOL].include?(val) && @grid[row][col] == nil
      @active_player = val.eql?(PLAYER_1_SYMBOL) ? @player_2 : @player_1
      @grid[row][col] = val
      @moves += 1
      true
    else
      false
    end
  rescue
    false
  end

  # Determines if the game has a winner, and configures the instance when this is the case.
  # The function returns true if the game has a winner; and sets the @winner var to this player.
  # If no winner is there for the game, false is returned instead.
  def winner?
    return true if @winner # if the winner is already set don't recalculate.

    @grid.each do |row| # iterate each row
      if horizontal_conditions(row)
        puts "matched row"
        set_winner(row[0])
        return true
      end
    end

    (0..3).each do |col|  # Iterate each column
      if vertical_conditions(col)
        puts "matches column"
        set_winner(@grid[0][col])
        return true
      end
    end

    if cross_conditions # Check the diagonals
      puts "matches cross"
      set_winner(@grid[1][1])
      return true
    end

    false # no winner
  end

  # Initializes the variables of the game, either setting or resetting them to their
  # default values needed for a fresh game.
  # Can also be used to reset the ongoing game.
  def init_game
    @moves = 0
    @winner = nil
    @grid = Array[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    @active_player = @player_1
  end

  protected
  # Sets the winner based on the provided field to check for the winning value.
  def set_winner(field)
    @winner = field.eql?(PLAYER_1_SYMBOL) ? @player_1 : @player_2

    if @winner.eql?(@player_1)
      @player_1_score += 1
    else
      @player_2_score += 1
    end
  end

  # Determines if the provided row has winning conditions for the game.
  # A row is considered winning when all values in the row match.
  # Returns true if the row is a winner; otherwise false.
  def horizontal_conditions(row)
    row[0] != nil && row[0] == row[1] && row[0] == row[2]
  end

  # Determines if the provided column has winning conditions for the game.
  # A column is considered winning when all values in the column match.
  # Returns true if the column is a winner; otherwise false.
  def vertical_conditions(col)
    @grid[0][col] != nil && @grid[0][col].eql?(@grid[1][col]) && @grid[0][col].eql?(@grid[2][col])
  end

  # Determines if the cross conditions applies for the game.
  # The cross checks both Diagonals for matching symbols and returns true
  # if this is the case; otherwise false.
  def cross_conditions
    return true if @grid[0][0] != nil && @grid[0][0].eql?(@grid[1][1]) && @grid[0][0].eql?(@grid[2][2])
    return true if @grid[0][2] != nil && @grid[0][2].eql?(@grid[1][1]) && @grid[0][2].eql?(@grid[2][0])
    false
  end
end