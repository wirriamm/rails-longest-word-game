require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    if word_in_letters?(@word, @letters)
      if word_valid?(@word)
        @result = "Congratulations! #{@word} is a valid English word."
      else
        @result = "Sorry but #{@word} is not a valied English word."
      end
    else
      @result = "Sorry but #{@word} cannot be built out of #{@letters.join(',')}"
    end
  end

  private

  def word_in_letters?(word, letters)
    word.chars.each do |letter|
      return false unless letters.any?(letter)
    end
    return true
  end

  def word_valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    output_serialised = open(url).read
    output = JSON.parse(output_serialised)
    output['found']
  end
end
