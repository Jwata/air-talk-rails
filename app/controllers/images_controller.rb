class ImagesController < ApplicationController
  def create
    url = params.require(:url)
    Image.create(url: url)

    redirect_to root_path
  end

  def destroy
    id = params.require(:id)
    Image.destroy(id)

    redirect_to root_path
  end
end
