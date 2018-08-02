class UtEvents::Events
  attr_accessor :name, :description, :location, :event_link, :affiliations, :extended_description
  @@all = []

  def initialize(event_hash)
    event_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_array(daily_events)
    daily_events.each do |event|
      Event.new(event)
    end
  end


end
