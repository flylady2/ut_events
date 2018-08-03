class UtEvents::Event
  attr_accessor :name, :description, :location, :event_link, :affiliations, :long_description
  @@all = []

  def initialize(event_hash)
    event_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    #binding.pry
  end

  def self.all
    @@all
  end

  def self.create_from_array(events_array)
    events_array.each do |event_hash|
      UtEvents::Event.new(event_hash)
    end
  end

  def self.find_by_category(category)
    #UtEvents::Event.all
    #binding.pry
    selected_events = []
    UtEvents::Scraper.scrape_events.each do |item|

      item.each do |key, value|
        #binding.pry
        if key == :affiliations && value.class == Array && value.include?(category)
          selected_events << item
        end
      end
    end


    selected_events
  end


end
