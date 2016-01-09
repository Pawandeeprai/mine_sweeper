class Tile
  attr_accessor :bomb_status, :hidden, :flagged

  def initialize(bomb_status = 0)
    @bomb_status = bomb_status
    @hidden = true
    @flagged = false
  end

  def bomb?
    :bomb == bomb_status
  end

  def render
    if flagged
      "F"
    elsif hidden
      "H"
    elsif bomb_status == :bomb
      "B"
    elsif bomb_status == 0
      " "
    else
      bomb_status.to_s
    end
  end

end
