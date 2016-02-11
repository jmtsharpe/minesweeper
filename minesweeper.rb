class Board

  attr_reader :grid

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) {Tile.new} }
  end

  def lay_mines

    @grid.each_with_index do |row, idx1|
      row.each_with_index do |col, idx2|

        col.col = idx2
        col.row = idx1
        mine_or_not = rand(3)
        col.make_mine if mine_or_not == 2
      end
    end
  end

  def test_render
    @grid.each do |el|
      el.each do |el2|
        print el2.revealed ? "true " : "false "
      end
      puts "\n"
    end
  end



end


class Tile
  attr_accessor :row, :col, :mine, :adj_mines, :revealed 
  def initialize
    @mine = false
    @revealed = false
    @flagged = false
    @row, @col, @adj_mines = nil
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

  def perp_array(arr)
    size = board.grid.length
    row, col = arr[0], arr[1]
    coord_array = [[row, col + 1], [row, col - 1], [row - 1, col], [row + 1, col]]
    coord_array = coord_array.select {|row, col| row >= 0 && row < size && col >= 0 && col < size }
    coord_array.map { |row, col| board.grid[row][col] }
  end

  def diag_array(arr)
    size = board.grid.length
    row, col = arr[0], arr[1]
    coord_array = [[row + 1, col + 1], [row - 1, col - 1], [row - 1, col + 1], [row + 1, col - 1]]
    coord_array = coord_array.select {|row, col| row >= 0 && row < size && col >= 0 && col < size }
    coord_array.map { |row, col| board.grid[row][col] }
  end

  def find_mines(arr)
    arr.select { |tile| tile.mine == true }
  end

  def reveal(tile)
    return if tile.revealed
    return if tile.mine

    tile.reveal

    diagonal_tiles = diag_array([tile.row, tile.col])
    puts "diag"

    perp_tiles = perp_array([tile.row,tile.col])
    puts "perp"

    perp_tiles.each do |tile|
      reveal(tile)
    end
    puts "perp tiles iterator"

    tile.adj_mines = find_mines(diagonal_tiles + perp_tiles).length
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


end
