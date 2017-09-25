class ImagesController < ApplicationController
  def create
    url = params.require(:url)
    Image.new(id: SecureRandom.hex, url: url).save!

    redirect_to root_path
  end

  def destroy
    id = params.require(:id)
    Image.find(id: id).delete!

    redirect_to root_path
  end
end
