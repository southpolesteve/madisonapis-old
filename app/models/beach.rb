class Beach

  attr_accessor :name, :status

  def self.all
    beaches = []
    agent = Mechanize.new
    @results = agent.get("http://www.publichealthmdc.com/environmental/water/beaches/")
    @results.search('.outline_box_beaches').each do |beach|
      new_beach = Beach.new
      new_beach.name = beach.search('h2').text
      new_beach.status = beach.search('.status_open').empty? ? "closed" : "open"
      beaches << new_beach
    end
    beaches
  end

end