class ImagesController < ApplicationController
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end
end
