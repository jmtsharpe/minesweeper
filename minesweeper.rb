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

  # def adj_array(arr)
  #   row, col = arr[0], arr[1]
  #
  #   rows = [row, row - 1, row + 1]
  #   cols = [col, col - 1, col + 1]
  #
  #   size = board.grid.length - 1
  #   adj_array = []
  #   rows.each do |el|
  #     if el >= 0 && el <= size
  #       cols.each do |el2|
  #         adj_array << board.grid[el][el2] if el2 >= 0 && el2 <= size
  #       end
  #     end
  #   end
  #
  #   adj_array[1..-1]
  # end

  def perp_array(arr)
    size = board.grid.length
    row, col = arr[0], arr[1]
    coord_array = [[row, col + 1], [row, col - 1], [row - 1, col], [row + 1, col]]
    coord_array = coord_array.select {|row, col| row >= 0 && row < size && col >= 0 && col < size }
    perp_array = coord_array.map { |row, col| board.grid[row][col] }

  end

  def diag_array(arr)
    size = board.grid.length
    row, col = arr[0], arr[1]
    coord_array = [[row + 1, col + 1], [row - 1, col - 1], [row - 1, col + 1], [row + 1, col - 1]]
    coord_array = coord_array.select {|row, col| row >= 0 && row < size && col >= 0 && col < size }
    diag_array = coord_array.map { |row, col| board.grid[row][col] }
  end

  def find_mine(arr)


  end



end
