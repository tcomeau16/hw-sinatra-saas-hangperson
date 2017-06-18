class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end


 def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
 end

  def guess(letter)
    
    # Not a valid character
    if (letter.nil?) || (letter.length == 0) || ((letter =~ /[a-zA-Z]/).nil? == true)
      raise ArgumentError.new("Invalid guess.") 

    elsif (@guesses.upcase.include?(letter.upcase) == true) || (@wrong_guesses.upcase.include?(letter.upcase) == true) 
      raise ArgumentError.new("You have already used that letter.") 

    # Letter exists in word
    elsif (@word.upcase.include?(letter.upcase) == true)
      @guesses += letter
      true
      
    # Letter doesn't exist in word or has already been guessed
    else
      @wrong_guesses += letter
      true
    end
   
  end
  
  def guess_several_letters(game, multi_letter)
    multi_letter.each_char { |letter| game.guess(letter)}
  end
  
  def word_with_guesses
    new_word = ''
    word.each_char{ |x| if guesses.include?(x) == true
                          new_word += x
                        else
                          new_word += "-"
                        end
                  }
    new_word
  end
  
  def check_win_or_lose
    if @wrong_guesses.length > 6
      :lose
    elsif word_with_guesses.include?("-")
      :play
    else
      :win
    end
  end
end

