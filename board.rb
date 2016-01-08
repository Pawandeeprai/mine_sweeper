require_relative 'tile.rb'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
    place_bombs_randomly
    fill_non_bomb_tiles
    adjacent_bombs
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, bomb)
    @grid[row][col] = bomb
  end

  def place_bombs_randomly
    bombs = 0
    while bombs < 10
      row = rand(0...9)
      col = rand(0...9)
      if self[row, col].nil?
        self[row, col] = Tile.new(:bomb)
        bombs += 1
      end
    end
  end

  def fill_non_bomb_tiles
    @grid.each do |tile|
      tile = Tile.new if tile.nil?
    end
  end

  def adjacent_bombs
    adjacent = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    @grid.each do |row|
      row.each do |el|
        if el.bomb_status == :bomb

          adjacent.each do |pos|
            new_spot = [row + pos[0], col + pos[1]]
            if new_spot[0..1] >= 0 && new_spot[0..1] <=8 && self.[](*new_spot).bomb_status != :bomb
              self.[](*new_spot).bomb_status += 1
            end
          end
        end
      end
    end
  end

  # def not_a_bomb?
  #   return false if
  #
  #
  # end

end
