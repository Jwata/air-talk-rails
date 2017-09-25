class HomeController < ApplicationController
  def index
    @images = Image.scan
  end
end
