class PropertiesController < ApplicationController
  def index
    if params[:house_number] && params[:street_name] && params[:street_type]
      @property = Property.new(params)
      @property.search
      render :show
    end
  end

  def show
    if params[:id]
      @property = Property.new({:parcel_number => params[:id]})
      @property.get
    end
  end

end
