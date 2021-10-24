class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(valid)
  	if valid == '' or valid.nil?
  		raise ArgumentError
  	end
  	valid = valid.downcase
  	if "abcdefghijklmnopqrstuvwxyz".index(valid) == nil
  		raise ArgumentError
  	end
  	if @guesses.index(valid) or @wrong_guesses.index(valid)
  		false
  	elsif word.index(valid)
  		@guesses += valid
  	else 
  		@wrong_guesses += valid
  	end
  end
  
  def word_with_guesses
  	@displayed = ''
  	@word.each_char{|s|
  		if @guesses.index(s)
  			@displayed += s
  		else
  			@displayed += '-'
  		end
		}
  	@displayed
	end
	
	def check_win_or_lose
		puts @word, @guesses
		if word_with_guesses == @word
			:win
		elsif @guesses == ''
			:lose
		else
			:play
		end
	end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end

class ArgumentError < StandardError
	 attr_reader :reason
   def initialize(reason)
      @reason = reason
   end
end
