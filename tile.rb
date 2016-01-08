class Tile
  attr_accessor :bomb_status, :hidden, :flagged

  def initialize(bomb_status = 0)
    @bomb_status = bomb_status
    @hidden = true
    @flagged = false
  end


end
