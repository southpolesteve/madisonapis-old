class Fire
  attr_accessor :id, :title, :type, :alarm, :arrival, :controlled, :location, :href, :units, :details

  def initialize params
    @id = params[:id]
  end

  def self.page(page_number)
    fires = []
    agent = Mechanize.new
    page = agent.get("http://www.cityofmadison.com/fire/reports/reportlist.cfm?page=#{page_number}")
    @results = page
    @results.search('#cs_information tbody tr').each do |el|
      fire = Fire.new(:id => get_link)
      fire.title = el.search('td[headers="title"]').text
      fire.type = el.search('td[headers="type"]').text
      fire.alarm = el.search('td[headers="date"]')[0].text
      fire.arrival = el.search('td[headers="date"]')[1].text
      fire.controlled = el.search('td[headers="date"]')[2].text
      fire.location = el.search('td[headers="location"]').text
      fire.href = "http://www.madisonapis.com/fires/#{fire.id}"
      fires << fire
    end
    fires
  end

  def self.find(id)
    agent = Mechanize.new
    page = agent.get("http://www.cityofmadison.com/fire/reports/report.cfm?r=#{id}")
    results = page
    fire = Fire.new({id: id})
    fire.location = results.search('#general td[headers="location"]').text
    fire.alarm = results.search('#general td[headers="alarmdatetime"]').text
    fire.arrival = results.search('#general td[headers="arrivaldatetime"]').text
    fire.controlled = results.search('#general td[headers="controlleddatetime"]').text
    fire.units = results.search('#general td[headers="units"]').text
    fire.details = results.search('#narrative').text
    fire
  end

  def self.parse_results
  end

  def self.get_link
    @results.search('#cs_information tbody tr').first.search('td[headers="title"] a').first.attributes['href'].text.split("=").last
  end

end