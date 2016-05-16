class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
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
  
  def guess(char)
    
    raise(ArgumentError) if char.nil? || char =~ /[^a-z]/i || char.empty? 
    char.downcase!
    return false if @wrong_guesses.include?(char) || @guesses.include?(char)
    
    if @word.include? char
      @guesses << char
    else
      @wrong_guesses << char
    end
    
    return true
  end
  
  def word_with_guesses
    if guesses.empty? 
      @word.gsub(/[a-z]/i, '-') 
    else
      @word.gsub(/[^#{@guesses}]/i, '-') 
    end
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars.all? {|c| @guesses.include?(c) }
    return :play
  end
  
end
