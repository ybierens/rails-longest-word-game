require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    response = URI.open("https://dictionary.lewagon.com/#{@word}")

    if !@word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      @result = "the word is not allowed"
    elsif !JSON.parse(response.read)['found']
      @result = "the word is not valid"
    else
      @result = "it's valid!"
    end
  end
end
