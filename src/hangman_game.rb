#Handles a single round of Hangman
class HangmanGame
    
  # User receives 7 chances
  MAX_NUMBER_OF_CHANCES = 7

  # Placeholder for the word for the user to guess
  attr_reader :secret_word
  # Array of characters that make up the secret word
  attr_reader :secret_word_letters
  # Dictionary of words in the game
  attr_reader :word_list
  # Variable to retrieve user's input
  attr_reader :letter
  # Keeps track of all letters input by the user
  attr_reader :guessed_letters
  # Number of chances the user has
  attr_reader :chances
  # Flag indicating game is over
  attr_reader :game_over

  def initialize #:notnew:
    @game_over = false
    @guessed_letters = []
    @chances = MAX_NUMBER_OF_CHANCES
    @word_list = ["gedact", "ieda", "inviable", "stoper", "nonblasphemy", "eucrite", "presupplementary", "qualmishness", "camphorated", "encapsuled", "foster", "coker", "orchestraless", "unprecipitated", "evader", "unscavenged", "exteriorizing", "accelerable", "strobilation", "picolinic", "missyllabification", "fossilizing", "interaxes", "antiliturgy", "serein", "noncatechistical", "dandiacally", "geom", "almondlike", "yaff", "outbalanced", "reevidenced", "murchison", "nonfermentative", "coachable", "noticer", "tractate", "duckier", "articulate", "colcannon", "theogony", "nonreformation", "silty", "adeline", "enthroned", "faceteness", "monovalent", "besiege", "feretory"]
  end

  # Begins a round of Hangman with the user
  def play
    @secret_word = get_random_word
    @secret_word_letters = @secret_word.chars.to_a
    print_instructions
    play_loop
  end
  
  # Retrieve word for the user to guess
  def get_random_word
    @word_list.sample
  end
  
  # Prints intructions to user before game begins
  def print_instructions
    puts "Welcome!  Enter a letter to make a guess and if you're right, the correct letters will be revealed in the word.  If you're wrong, your hangman will become more complete and you'll be one step closer to losing the game!"
    puts "Good luck!"
  end
  
  # Game begins
  def play_loop
    while !@game_over
      puts self
      get_letter

      if !repeated_guess?
        @guessed_letters << @letter

        if !won?
          get_response
        else
          puts "You won! That was a close one!"
          puts "The word is #{@secret_word}"
          end_game
        end
      end
    end
  end
  
  #Get user's input
  def get_letter
    @letter = gets.chomp.downcase
  end
  
  # Check to see if user has previously entered the same letter
  # Returns true if user has entered the same letter from a previous turn
  def repeated_guess?
    if @guessed_letters.include? @letter
        puts "You have already guessed the letter #{@letter}, try again."
        return true
    end
  end
  
  # Check to see if user has chances left
  def have_lives?
    @chances >= 1
  end
  
  # Check to see if user has won
  # Returns true if user has guessed all letters in the word
  def won?
    (@secret_word_letters - @guessed_letters).length == 0
  end
  
  # Checks to see if user's input is correct or not or invalid
  def get_response
    if @letter.size != 1
        puts "Invalid input, try again"
    elsif @secret_word_letters.include? @letter
        puts "Yes! This word does include #{@letter}!"
    elsif @chances > 1
        @chances -= 1
        puts "#{@letter} is not a letter in the word. You have #{@chances} guesses left."
    else
        lost
    end
  end
  
  # Handles when the user has lost the game
  def lost
    @chances -= 1
  	puts self
    puts "Too late! The word was #{@secret_word}."
    puts "Better luck next time!"
    end_game
  end
  
  # Flag indicating game is over
  def end_game
    @game_over = true
  end

  # Prints hangman to screen based on user's number of chances
  def to_s
    output = ""

    t = @chances

    ascii = <<-eos
    _____
    |    #{t<7 ? '|':' '}
    |    #{t<6 ? 'O':' '}
    |   #{t<2 ? '/':' '}#{t<5 ? '|':' '}#{t<1 ? '\\':' '}
    |   #{t<4 ? '/':' '} #{t<3 ? '\\':' '}
    |
   ====
   eos

   output << ascii

   @secret_word_letters.each do |l|
       output << (@guessed_letters.include?(l) ? l : '__') + ' '
   end
    output
  end
  
end
