class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  #----------------------my code is below
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @current_status = :play
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(the_letter)
    if the_letter.nil? || the_letter.empty? || the_letter =~/[^a-zA-Z]+/
      raise ArgumentError
    end
  
  the_letter=the_letter.downcase
  if (!@guesses.include? the_letter) && (!@wrong_guesses.include? the_letter)
      if @word.include? the_letter
        @guesses += the_letter
        if !word_with_guesses.include?('-') && @current_status != :lose
          @current_status = :win
        end
          return true
      else
        @wrong_guesses += the_letter
        if @wrong_guesses.length >=7
          @current_status = :lose
        end
        return true
      end
    end
    return false
    
  end

  def word_with_guesses
    temp=''
    @word.split('').each do |c|
      if @guesses.include? c
        temp +=c
      else
        temp +='-'
      end
    end
  return temp
  end
  
  def check_win_or_lose
    return @current_status
  end

#----------------------------------------------------------------------

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
