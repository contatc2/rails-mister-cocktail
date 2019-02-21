class CocktailsController < ApplicationController
  def index
    @cocktail = Cocktail.new
  end

  def create
  end
end
