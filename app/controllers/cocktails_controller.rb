class CocktailsController < ApplicationController
  before_action :find_cocktail, only: %i[show update]

  def index
    @query = params[:query]
    @cocktails = if @query
      Cocktail.where('LOWER(name) like ?', "%#{@query.downcase}%")
    else
      Cocktail.all
    end
  end

  def saved
    @cocktails = Cocktail.where(saved: true)
  end

  def show
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
    @image = @cocktail.images.build
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      params[:images]&.each { |image| @cocktail.images.create(image: image) }
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def update
    @cocktail.update(cocktail_params)
    redirect_to cocktail_path(@cocktail)
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :saved, images_attributes: [:image, :cocktail_id])
  end
end
