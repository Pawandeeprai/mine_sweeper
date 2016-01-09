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

  def won?
    @grid.flatten.all? { |tile| tile.hidden == tile.bomb? }
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
    i = 0
    while i < @grid.length
      idx = 0
      while idx < @grid[i].length
        self[i,idx] = Tile.new if self[i,idx].nil?
        idx +=1
      end
      i += 1
    end
  end

  def adjacent_bombs
    adjacent = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]

    @grid.each_with_index do |array, row|
      array.each_with_index do |el, col|
        if el.bomb_status == :bomb

          adjacent.each do |pos|
            new_spot = [row + pos[0], col + pos[1]]
            if new_spot[0] >= 0 && new_spot[1] >= 0 && new_spot[0] <=8 && new_spot[1] <=8 && self.[](*new_spot).bomb_status != :bomb
              self.[](*new_spot).bomb_status += 1
            end
          end
        end
      end
    end
  end

  def render
    @grid.map do |row|
      row.map do |tile|
        tile.render
      end
    end
  end

  def print
    board_state = render
    board_state.each do |row|
      p row
    end
  end

  def each(&block)
    @grid.each do |row|
      row.each do |tile|
        block.call(tile)
      end
    end
  end

end
