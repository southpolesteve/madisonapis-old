class Park
  @@parks_url = "http://www.madisonapis.com/parks/"

  attr_accessor :facilities, :id, :results

  def self.all
    parks = []
    agent = Mechanize.new
    page = agent.get("http://www.cityofmadison.com/parks/parks/azparks.cfm")
    elements = page.search('#content ul li')
    elements.each do |park|
      hash = Hash.new
      hash[:id] = get_id(park)
      hash[:name] = park.text
      hash[:href] = @@parks_url + hash[:id].to_s+".json"
      parks << hash
    end
    parks
  end

  def initialize id
    @id = id
  end

  def get
    agent = Mechanize.new
    @results = agent.get("http://www.cityofmadison.com/parks/parks/park.cfm?id=#{@id}")
    @name = results.title.split(" - ").first
    park = Park.new(id)
    @facilities = []
    @results.search('.link_list.facilities li').each do |facility|
      @facilities << facility.text
    end
    @results.search('.body').first.text.match regex 
  end

  private

  def self.get_id(node)
    node.children.first.attributes["href"].value.split("=").last
  end

  def regex
    /Address: (?<address>[ 0-9a-zA-Z]*)Hours: (?<hours>[ \-0-9a-zA-Z:]*)Park Type: (?<park_type>[ \-0-9a-zA-Z:]*)Acres: (?<acres>[0-9.]*)Restroom: (?<restroom>[A-Za-z]*)Drinking Water: (?<drinking_water>[A-Za-z]*)/
  end

end