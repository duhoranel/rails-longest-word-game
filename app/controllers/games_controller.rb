class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    # @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def letter_in_grid
    @word.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_found = open(url).read
    word = JSON.parse(word_found)
    word['found']
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Sorry, but #{@word.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@word.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@word.upcase} does not seem to be an English word."
    else letter_in_grid && english_word
      @result = "Congratulation! #{@word.upcase} is a valid English word."
    end
  end
end
