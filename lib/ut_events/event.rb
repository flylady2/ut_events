class UtEvents::Event
  attr_accessor :name, :description, :location, :event_link, :affiliations, :long_description

  @@all = []

  def initialize(event_hash) #instantiates a new Event object with attributes from an event hash from a single event
    event_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_array(events_array) #iterates through an array of hashes
    events_array.each do |event_hash|
      UtEvents::Event.new(event_hash) #calls Event.new to create an Event object from each hash
    end
  end

  def self.find_by_category(category) #iterates through the Event.all array to select events in the desired category
    UtEvents::Event.all.select {|object|
      object.affiliations.include?(category)}
  end #returns a new array of the selected events

end
