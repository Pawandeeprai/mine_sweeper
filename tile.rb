class Tile
  attr_accessor :bomb_status, :hidden

  def initialize(bomb_status = 0)
    @bomb_status = bomb_status
    @hidden = true
  end


end
