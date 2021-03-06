require_relative "board.rb"
require_relative "tile.rb"

class Minesweeper
  def initialize
    @board = Board.new
    print @board.render
  end

  def play_turn
    @board.print

    until over?
      player_input = get_player_input

      if player_input.first == "flag"
        @board[*player_input.drop(1)].flagged = true
        @board.print
        next
      elsif player_input.first == "unflag"
        @board[*player_input.drop(1)].flagged = false
        @board.print
        next
      else
        reveal([*player_input.drop(1)])
        @board.print
      end
    end

    print "You won!!!" if won? == true
    print "You're a loser :(" if lose? == true
  end



  def get_player_input
    valid_actions = ["flag", "unflag", "reveal"]
    in_bounds = (0...9).to_a
    action = nil
    row = nil
    col = nil

    loop do
      puts "\nChoose an action: flag, unflag, or reveal"
      action = gets.chomp.downcase
      puts "Choose row:"
      row = gets.chomp.to_i
      puts "Choose column:"
      col = gets.chomp.to_i
      if valid_actions.include?(action) && in_bounds.include?(row) && in_bounds.include?(col)
        break
      else
        puts "Input Error"
      end
    end

    [action,row,col]
  end

  def reveal(pos)
    @board[*pos].hidden = false

    if @board[*pos].bomb_status == 0
      adjacent = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
      adjacent.each do |diff|
        new_spot = [diff[0] + pos[0], diff[1] + pos[1]]
        if in_bounds?(new_spot) && @board[*new_spot].hidden == true
          reveal(new_spot)
        end
      end
    end
  end

  def in_bounds(pos)
    pos[0] >= 0 && pos[1] >= 0 && pos[0] <=8 && pos[1] <=8
  end

  def over?
    lose? || won?
  end

  def won?
    # @board.won?
    hidden_count = 0
    @board.each do |tile|
      hidden_count += 1 if tile.hidden == true
    end
    return true if hidden_count <= 10
    false
  end

  def lose?
    @board.each do |tile|
      return true if tile.bomb_status == :bomb && tile.hidden == false
    end
    false
  end


end
