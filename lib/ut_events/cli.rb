class UtEvents::CLI

  def initialize
  end

  #def start
    #puts "Welcome to UT Events"
    #Utevents::Scraper.scrape_events
    #main_menu
  #end

  #def main_menu#?split these up into multiple methods?
    #puts "These are the events that are happening today"
    #UtEvents::Scraper.scrape_events.each.with_index(1) do |event, index|
      #binding.pry
      #puts "#{index}. #{event.name}"
    #end
  #end
  def main_menu
    #displays a list of events
    #Iterating through Event.all to display a numbered list with names
    puts "Welcome to UT Daily Events"
    puts "To view additional details about a particular event, type in its number from the list."
    input = gets.strip
    index = input.to_i - 1
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

end
