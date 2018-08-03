class UtEvents::CLI

  attr_accessor :daily_events

  def initialize
  end

  def start
    puts "Welcome to UT Daily Events"
    #scraping data from UT calendar
    daily_events = UtEvents::Scraper.scrape_events
    #creating Event objects from scraped data
    UtEvents::Event.create_from_array(daily_events)
    #displays a numbered list of events by name
    puts "These are the events that are happening today:"

    UtEvents::Event.all.each.with_index(1) do |event, index|
      puts "#{index}. #{event.name}"

    end
    puts ""
    main_menu
  end

  def main_menu
    puts "To view additional details about a particular event, type in its number from the list."
    input = gets.strip
    index = input.to_i - 1
    #identifies event within Event.all array and shows its attributes
    chosen_event = UtEvents::Event.all[index]
    puts "Name: #{chosen_event.name}"
    puts "Location: #{chosen_event.location}"
    puts "Brief description: #{chosen_event.description}"
    puts "Affilations: #{chosen_event.affiliations.join(', ')}"
    puts "url: #{chosen_event.event_link}"
    puts ""
    puts "Would you like to see a more detailed description of this event? (Y/n)"
    #{}puts "To quit, type exit"
    #{}puts "To see a "
    next_input = gets.strip
    if next_input == "Y"

      puts UtEvents::Scraper.single_event_scrape(event)

      #puts "#{event.long_description}"
    else
      puts "To quit UT Daily Events, type 'exit'"
    end
    puts "Would you like to see a list of events belonging to one of these categories?"
    puts "A. Research Opportunities & Studies"
    puts "B. Health & Wellness"
    puts "C. Campus & Community"
    puts "If so, enter the letter corresponding to the category"
    last_input = gets.strip
    case last_input
    when "A"
      UtEvents::Event.find_by_category("Research Opportunities & Studies")

    when "B"
      UtEvents::Event.find_by_category("Health & Wellness")
    when "C"
      UtEvents::Event.find_by_category("Campus & Community")
    end


  end

    # if value.class == Array
      #  puts" #{key.capitalize}: #{value.join(', ')}"
    #  else
      #  puts "#{key.capitalize}: #{value}"
    #  end
  #  }
  #  end

    #iterate through Event.all and puts detail about a single event.



    #method for searching Events.all by affiliations.
    #puts returned events
    #need exit case


end
