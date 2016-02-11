class Board

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) {Tile.new} }
  end

  def lay_mines
    total_mines = [false,false,false,true]
    @grid.each do |row|
      row.each do |col|
        col -- 


  end

end


class Tile

  def initialize
    @mine = false
    @revealed = false
    @flagged = false
  end

  def make_mine
    @mine = true
  end

  def reveal
    @revealed = true
  end

  def flag
    @flagged ? @flagged = false : @flagged = true
  end

end
