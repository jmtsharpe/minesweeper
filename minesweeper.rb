require 'colorize'

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
        mine_or_not = rand(2)
        col.make_mine if mine_or_not == 1
      end
    end
  end

  def render
    puts " - 1   2   3   4   5   6   7   8   9 -"
    puts " -------------------------------------"
    @grid.each_with_index do |el,idx|
      print idx + 1
      el.each do |el2|
        print el2.revealed ? " | #{el2.adj_mines} ".colorize(:color => :blue) : "|" + " ? ".colorize(:background => :light_white)
      end
      print "|"
      puts "\n"
      puts " -------------------------------------"
    end
  end

  def lose_render
    puts " - 1   2   3   4   5   6   7   8   9 -"
    puts " -------------------------------------"
    @grid.each_with_index do |el,idx|
      print idx + 1
      el.each do |el2|
        print el2.mine ? "|" + " ! ".colorize(:background => :red) : "|" + "   ".colorize(:color => :blue)
      end
      print "|"
      puts "\n"
      puts " -------------------------------------"
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
    board.lay_mines
  end

  def play
    system("clear")
    board.render

    coords = parse_input(get_input)
    row, col = coords[0].to_i - 1, coords[1].to_i - 1
    tile = board.grid[row][col]

    if tile.mine
      lose
    else
      reveal(tile)
      play
    end

  end

  def lose
    system("clear")
    board.grid.each do |row|
      row.each do |col|
        col.reveal
      end
    end

    board.lose_render
    puts "You lose"

  end

  def parse_input(string)
    string.split(",")
  end

  def get_input
    puts "Choose your tile."
    gets.chomp
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


    perp_tiles = perp_array([tile.row,tile.col])


    perp_tiles.each do |tile|
      reveal(tile)
    end


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

if __FILE__ == $PROGRAM_NAME
  new_game = Game.new(9)
  new_game.play
end
