class Beach

  attr_accessor :name, :status

  def self.all
    beaches = []
    agent = Mechanize.new
    @results = agent.get("http://www.publichealthmdc.com/environmental/water/beaches/")
    @results.search('.outline_box_beaches').each do |el|
      beach = Beach.new
      beach.name = el.search('h2').text
      beach.status = "open" if el.search('.status_open').any?
      beach.status = "closed" if el.search('.status_closed').any?
      beach.status = "unmonitored" unless beach.status
      beaches << beach
    end
    beaches
  end

end