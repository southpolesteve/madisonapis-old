class FiresController < ApplicationController
  
  def index
    @fires = Fire.page(params[:page] ? params[:page] : 1)
  end

  def show
    @fire = Fire.find(params[:id])
  end

end