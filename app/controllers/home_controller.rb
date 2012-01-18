class HomeController < ApplicationController

  def index
    @layers = Layer.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
