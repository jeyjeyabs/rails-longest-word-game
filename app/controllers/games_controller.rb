require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...9).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    char_test = params[:word].chars.all? do |char|
      params[:letters].include?(char)
      end
    if !char_test
      @score_display = "You failed #{params[:word]} cannot be made of #{params[:letters]}"
    elsif english_word?(params[:word])
      @score_display = "Well done #{params[:word]} is an English word"
    else
      @score_display = "Sorry #{params[:word]} is not a valid word"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
