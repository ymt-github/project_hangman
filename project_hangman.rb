require "json"

class PlayRound

  def initialize(word = "", load_game)
    @hung_man = ["|", "O", "|", "/","\\", "/", "\\"]
    if load_game == true
      self.load
    else
      @word = word.split("")
      @game_board = Array.new(word.length, "_")
      @count = 0
      @wrong = 0
      @picked = []
      @man = Array.new(7, " ")
    end
  end

  def compare(guess)
    correct = false
    @word.each_with_index do |letter, i|
      if letter == guess
        @game_board[i] = "#{guess}"
        correct = true
      end
    end
    correct
  end

  def display_hangman
    puts ""
    puts "  ___________"
    puts "  #{@man[0]}         |"
    puts "  #{@man[1]}         |"
    puts " #{@man[3]}#{@man[2]}#{@man[4]}        |"
    puts " #{@man[5]} #{@man[6]}        |"
    puts "            |"
    puts "  __________| "
    puts ""
  end

  def display
    puts "Enter a letter, or ! to save and quit."
    if @count > 0
      puts "Chosen letters are:"
      puts ""
      puts "#{@picked.sort!.join(" ").to_s}"
    end
    self.display_hangman
    puts @game_board.join.to_s
    puts ""
  end

  def check_if_picked(c)
    was_picked = false
    @picked.each do |letter|
      if letter == c
        was_picked = true
      end
    end
    return was_picked
  end

  def was_not_picked(c)
    @count += 1
    @picked << c
    was_correct = self.compare(c)
    if was_correct == false
      @man[@wrong] = @hung_man[@wrong]
      @wrong += 1
    end
    if @wrong >= 7
      self.display_hangman
      puts "Hangman. Game Over."
      puts @word.join.to_s
      return false
    end
    if self.check_for_win
      puts "You Win!"
      return false
    end
  end

  def check_for_win
    if @word == @game_board
      return true
    else
      return false
    end
  end

  def save
    save_data = {:word=>@word, :game_board=>@game_board, :wrong=>@wrong, :picked=>@picked, :count=>@count, :man=>@man}.to_json
    file = File.open("save.txt","w")
    file.puts save_data
    file.close
  end

  def load
    file = File.open("save.txt", "r")
    save_data = file.readline
    save_data = JSON.parse(save_data).to_hash
    @word = save_data["word"]
    @game_board = save_data["game_board"]
    @wrong = save_data["wrong"]
    @picked = save_data["picked"]
    @count = save_data["count"]
    @man = save_data["man"]  
    file.close
  end

end


def get_word_array(dif)
  file = File.open("google-10000-english-no-swears.txt", "r")
  contents = file.read
  file.close
  temp_contents = contents.split("\n")
  trimmed_contents = []
  temp_contents.each do |word|
    if word.length >= dif[0] && word.length <= dif[1]
      trimmed_contents << word
    end
  end
  n = rand(trimmed_contents.length)
  word = trimmed_contents[n]  
end

def get_difficulty()
  difficulty = ""
  while difficulty != "e" && difficulty != "m" && difficulty != "h"
    puts "Welcome to Hangman! You know the rules!"
    puts "Want easy, medium, or hard?"
    difficulty = gets.downcase.chr
    if difficulty != "e" && difficulty != "m" && difficulty != "h"
      puts "Just enter one of those choices."
    end
  end
  choice_array = difficulty_choice(difficulty)
end

def difficulty_choice(difficulty)
  if difficulty == "e"
    choice_array = [2,4]
  elsif difficulty == "m"
    choice_array = [4,7]
  else
    choice_array = [5,100]
  end
  choice_array
end


def valid_entry(c)
  case c
  when "a"
    return true
  when "b"
    return true
  when "c"
    return true
  when "d"
    return true
  when "e"
    return true
  when "f"
    return true
  when "g"
    return true
  when "h"
    return true
  when "i"
    return true
  when "j"
    return true
  when "k"
    return true
  when "l"
    return true
  when "m"
    return true
  when "n"
    return true
  when "o"
    return true
  when "p"
    return true
  when "q"
    return true
  when "r"
    return true
  when "s"
    return true
  when "t"
    return true
  when "u"
    return true
  when "v"
    return true
  when "w"
    return true
  when "x"
    return true
  when "y"
    return true
  when "z"
    return true
  when "!"
    return true
  else
    return false
  end
end

def yes_or_no(text)
  while true
    puts text
    choice = gets.downcase.chr
    if choice == "y"
      return true
    elsif choice == "n"
      return false
    else 
      puts "Please answer yes or no."
    end
  end
end 

def play_a_round(round)
  keep_going = true
  while keep_going
    round.display
    c = gets.downcase.chr
    if valid_entry(c)
      if c == "!"
        puts "Save and quit?"
        if gets.chr.downcase == "y"
          round.save
          break
        end      
      elsif round.check_if_picked(c) == false
        if round.was_not_picked(c) == false
          keep_going = false
        end
      else
        puts "You've already picked that letter."
      end
    else
      puts "#{c} is not a letter."
    end
  end
  puts ""
end

def play()
  keep_going = true
  while keep_going == true
    if File.exist?("save.txt")
      load_game = yes_or_no("Would you like to load a previous save?")
    end
    if load_game != true
      choose_difficulty = get_difficulty()
      word = get_word_array(choose_difficulty)
    end
    round = PlayRound.new(word, load_game)
    play_a_round(round)
    keep_going = yes_or_no("Would you like to play again?")
  end    
  puts "Thank you for playing!"
end

play()