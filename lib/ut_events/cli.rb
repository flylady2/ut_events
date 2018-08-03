class UtEvents::CLI

  attr_accessor :daily_events

  def initialize
  end

  def start
    puts "Welcome to UT Daily Events"
    daily_events = UtEvents::Scraper.scrape_events
    #binding.pry
    UtEvents::Event.create_from_array(daily_events)
    #binding.pry
    puts "These are the events that are happening today"
    UtEvents::Event.all
    #binding.pry
    #displays a numbered list of events by name
    UtEvents::Event.all.each.with_index(1) do |event, index|
      #binding.pry
      puts "#{index}. #{event.name}"
    end
    #binding.pry
    main_menu
  end



  #def main_menu #?split these up into multiple methods?
    #puts "These are the events that are happening today"
    #UtEvents::Scraper.scrape_events.each.with_index(1) do |event, index|
      #binding.pry
      #puts "#{index}. #{event.name}"
    #end
  #end


  def main_menu


    #Iterating through Event.all to display a numbered list with names

    puts "To view additional details about a particular event, type in its number from the list."
    input = gets.strip
    index = input.to_i - 1

    UtEvents::Event.all[index].each_pair {|key, value|
      if value.class == Array
        puts" #{key.capitalize}: #{value.join(', ')}"
      else
        puts "#{key.capitalize}: #{value}"
      end
    }
    end

    #iterate through Event.all and puts detail about a single event.

    puts "To see a more complete description of the event, enter "#{???}"

    puts "To search for events related to these campus programs, enter the letter corresponding to the program."
    puts "A whatever"
    puts "B whatever"
    puts "C whatever"

    #method for searching Events.all by affiliations.
    #puts returned events
    #need exit case


end
