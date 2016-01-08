require_relative "board.rb"
require_relative "tile.rb"

class Minesweeper
  def initialize
    @board = Board.new
  end

  def play_turn
    loop do
      player_input
      if player_input.first == "flag"
        @board[*player_input.drop(1)].flagged = true
        @board.render
        next
      elsif player_input.first == "unflag"
        @board[*player_input.drop(1)].flagged = false
        @board.render
        next
      else
        reveal(@board[*player_input.drop(1)])
        @board.render
        break if over?
      end
    end
  end

  def player_input
    valid_actions = ["flag", "unflag", "reveal"]
    in_bounds = (0...9).to_a
    action = nil
    row = nil
    col = nil
    loop do
      puts "Choose an action: flag, unflag, or reveal"
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

  def over?
    hidden_count = 0
    @board.each do |tile|
      return true if tile.bomb_status == :bomb && tile.hidden == false
      hidden_count += 1 if tile.hidden == true
    end
    return true if hidden_count <= 10
    false
  end

end
