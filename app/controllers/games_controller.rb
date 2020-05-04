require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...9).map { ('A'..'Z').to_a[rand(26)] }  
  end

  def score
    @letters = params[:letters].split
    @word = (params[:attempt] || "").upcase
    @english_word = english_word?(@word)
    @included = included?(@word, @letters)
  end
  
  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = JSON.parse(open(url).read)
    result['found']
  end

  def included?(word, letters)
    word.chars.all? do |letter| 
      word.count(letter) <= letters.count(letter)
    end
  end

end
