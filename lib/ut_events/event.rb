class UtEvents::Event
  attr_accessor :name, :description, :location, :event_link, :affiliations, :long_description

  @@all = []

  def initialize(event_hash)
    event_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_array(events_array) #instantiates an Event object from each hash in the array
    events_array.each do |event_hash|
      UtEvents::Event.new(event_hash)
    end
  end

  def self.find_by_category(category) #iterates through the Event.all array to select events in the desired category
    selected_events = []
    UtEvents::Event.all.each do |object|
      if object.affiliations.include?(category)
        selected_events << object #puts the selected events into a new array
      end
    end
    selected_events.each do |event| #iterates through the new array to print out the event names
      puts "#{event.name}"
    end

    def self.destroy_all
      @@all.clear
    end
  #  UtEvents::Scraper.scrape_events.each do |item|

    #  item.each do |key, value|
    #    binding.pry
    #    if key == :affiliations && value.class == Array && value.include?(category)
    #      selected_events << item
    #    end
    #  end
    #end
    #selected_events

  end

  # UtEvents::Event.all.collect do |object|
  #   if object.affiliations.include?(category)
  # =>  object
  # => end
  # end


end
