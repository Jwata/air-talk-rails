class HomeController < ApplicationController
  def index
    @images = Image.all.reverse
  end
end
