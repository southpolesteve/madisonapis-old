class BeachesController < ApplicationController
  
  def index
    @beaches = Beach.all
  end

end