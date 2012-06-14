class Property
  attr_accessor :house_number, :street_direction, :street_name, :street_type,
                :unit, :uri, :parcel_number, :results, :address, :property_use, :property_class,
                :lot_size, :year_built, :total_living_area

  def initialize params
    @house_number = params[:house_number]
    @street_direction = params[:street_direction]
    @street_name = params[:street_name]
    @street_type = params[:street_type]
    @unit = params[:unit]
    @parcel_number = params[:parcel_number]
    @results = nil
  end

  def search
    agent = Mechanize.new
    page = agent.get("http://www.cityofmadison.com/assessor/property/")
    form = page.form_with(:name => 'addressSearch')
    form.HouseNum = house_number
    form.StreetName = street_name
    form.StType = street_type
    @results = form.submit
    parse_results
  end

  def get
    agent = Mechanize.new
    @results = agent.get("http://www.cityofmadison.com/assessor/property/PropertyData.cfm?ParcelN=#{parcel_number}")
    parse_results
  end

  def parse_results
    @uri = @results.uri
    @parcel_number = uri.query.split("=").last
    matches = @results.search('#propertyData').text.gsub(/(\t|\r|\n)/, '').match regex
    matches.names.each do |name|
      self.send(name+'=', matches[name])
    end
    self
  end

  def regex
    /PROPERTY ADDRESS:(?<address>[ 0-9a-zA-Z]*)P.*Property Use: *(?<property_use>[ 0-9a-zA-Z]*) * Property Class: *(?<property_class>[ 0-9a-zA-Z]*)Z.*Lot Size: *(?<lot_size>[, 0-9]*).*Year Built: *(?<year_built>[0-9]*).*Total Living Area: *(?<total_living_area>[,0-9]*)1st/
  end

end