class Crossword
  attr_accessor :grid, :word_list

  def initialize
    @grid = [
      ['_', '_', '_', '_', '_'],
      ['_', '_', '_', '_', '_'],
      ['_', '_', '_', '_', '_'],
      ['_', '_', '_', '_', '_'],
      ['_', '_', '_', '_', '_']
    ]

    @word_list = {
      horizontal: { 0 => "アップル", 2 => "グレープ" }, # "apple", "grape" in Katakana
      vertical: { 0 => "エンジェル", 4 => "ピーチ" } # "angel", "peach" in Katakana
    }
  end

  def display_grid
    @grid.each do |row|
      puts row.join(" ")
    end
  end

  def insert_word(word, row, col, direction)
    word.chars.each_with_index do |char, index|
      if direction == :horizontal
        @grid[row][col + index] = char
      elsif direction == :vertical
        @grid[row + index][col] = char
      end
    end
  end

  def play
    puts "Welcome to the Crossword Puzzle Game!"
    display_grid

    until solved?
      puts "Enter your word (e.g., 'アップル')"
      word = gets.chomp

      puts "Enter the row number (0-4):"
      row = gets.chomp.to_i

      puts "Enter the column number (0-4):"
      col = gets.chomp.to_i

      puts "Enter the direction (horizontal/vertical):"
      direction = gets.chomp.to_sym

      if valid_word?(word, row, col, direction)
        insert_word(word, row, col, direction)
        display_grid
      else
        puts "Invalid word placement, try again!"
      end
    end

    puts "Congratulations! You solved the puzzle!"
  end

  def valid_word?(word, row, col, direction)
    return false unless @word_list[direction].values.include?(word)

    if direction == :horizontal
      return false if col + word.length > @grid[row].length
    elsif direction == :vertical
      return false if row + word.length > @grid.length
    end

    true
  end

  def solved?
    @word_list[:horizontal].each do |row, word|
      return false unless @grid[row].join.include?(word)
    end

    @word_list[:vertical].each do |col, word|
      vertical_word = (0..@grid.length - 1).map { |r| @grid[r][col] }.join
      return false unless vertical_word.include?(word)
    end

    true
  end
end

# Start the game
game = Crossword.new
game.play
