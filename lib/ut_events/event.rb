class UtEvents::Events
  attr_accessor :name, :brief_description, :location, :affiliations
  @@all = []

  def initialize(name, brief_description, location, affiliations)
    @name = name
    @brief_description = brief_description
    @location = location
    @affiliations = affiliations
  end

  def self.all
    @@all
  end

  #def create_from_array(UtEvents::Scraper.daily_events)


end
