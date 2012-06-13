class ParksController < ApplicationController
  
  def index
    @parks = Park.all
    respond_to do |format|
      format.json { render :json => @parks.to_json }
      format.html
    end
  end

  def show
    @park = Park.new(params[:id])
    @park.get
    respond_to do |format|
      format.json
    end
  end

end
