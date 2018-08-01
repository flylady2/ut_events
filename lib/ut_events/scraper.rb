class UtEvents::Scraper

  BASE_URL = "https://calendar.utexas.edu/calendar"

  def self.scrape_events
    html = open(BASE_URL)
    doc = Nokogiri::HTML(html)
    item_content = doc.css(".item_content_medium")
    events = []
    item_content.each do |item|
      name_of_event = item.css(".heading h3.summary").css("a").text
      description_of_event = item.css("h4.description").text
      event_location = item.css(".location").css("a").text
      event_link = item.css(".heading h3.summary").css("a").attribute("href").value
      event_affiliations =  []
      item.css(".event_filters").css("a").each do |filter|
        event_affiliations << filter.text
      end
      events << {name: name_of_event, description: description_of_event, location: event_location, link: event_link, affiliations: event_affiliations}
    end
  end
