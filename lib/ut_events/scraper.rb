class UtEvents::Scraper


  BASE_URL = "https://calendar.utexas.edu/calendar"

  def self.scrape_events #scraping the UT calendar events website
    html = open(BASE_URL)
    doc = Nokogiri::HTML(html)
    
    item_content = doc.css(".item_content_medium")
    daily_events = []
    item_content.each do |item| #iterating through each event to obtain individual attributes
      name_of_event = item.css(".heading h3.summary").css("a").text
      description_of_event = item.css("h4.description").text
      event_location = item.css(".location").css("a").text
      event_link = item.css(".heading h3.summary").css("a").attribute("href").value
      event_affiliations =  [] #creating array for event affiliations because there are often more than one
      item.css(".event_filters").css("a").each do |filter| #iterating through each event's affiliations
        event_affiliations << filter.text #adding them to the array
      end
      #creating a hash of each event and shovelling it into the daily_events array
      daily_events << {name: name_of_event, description: description_of_event, location: event_location, event_link: event_link, affiliations: event_affiliations}
    end
    daily_events #returning array
  end

  def self.single_event_scrape(chosen_event) #scraping page of individual event
    url = "#{chosen_event.event_link}"
    event_doc = Nokogiri::HTML(open(url))
    long_description = event_doc.css(".description p").text
    long_description #returning information
  end
end
