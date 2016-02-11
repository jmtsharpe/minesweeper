class Board

  attr_reader :grid

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) {Tile.new} }
  end

  def lay_mines

    @grid.each do |row|
      row.each do |col|
        mine_or_not = rand(3)
        col.make_mine if mine_or_not == 2
      end
    end
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

class Game

  attr_reader :board

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def adj_array(arr)
    row, col = arr[0], arr[1]

    rows = [row, row - 1, row + 1]
    cols = [col, col - 1, col + 1]

    size = board.grid.length - 1
    adj_array = []
    rows.each do |el|
      if el >= 0 && el <= size
        cols.each do |el2|
          adj_array << board.grid[el][el2] if el2 >= 0 && el2 <= size
        end
      end
    end

    adj_array[1..-1]
  end

end
