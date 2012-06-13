class Property
  attr_accessor :house_number, 
                :street_direction,
                :street_name,
                :street_type,
                :unit,
                :uri,
                :parcel_number

  def initialize params
    @house_number = params[:house_number]
    @street_direction = params[:street_direction]
    @street_name = params[:street_name]
    @street_type = params[:street_type]
    @unit = params[:unit]
    @results = nil
  end

  def get
    agent = Mechanize.new
    page = agent.get("http://www.cityofmadison.com/assessor/property/")
    form = page.form_with(:name => 'addressSearch')
    form.HouseNum = house_number
    form.StreetName = street_name
    form.StType = street_type
    @results = form.submit
    @uri = @results.uri
    @parcel_number = uri.query.split("=").last
    @results.search('#propertyData tr')[1]
  end

end