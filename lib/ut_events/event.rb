class UtEvents::Event
  attr_accessor :name, :description, :location, :event_link, :affiliations, :extended_description
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


end
