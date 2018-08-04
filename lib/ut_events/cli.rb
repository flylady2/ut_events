class UtEvents::CLI

  def start
    puts "Welcome to UT Daily Events"
    #scraping data from UT calendar
    daily_events = UtEvents::Scraper.scrape_events
    #creating Event objects from scraped data
    UtEvents::Event.create_from_array(daily_events)
    #displays a numbered list of events by name
    display_menu
  end

  def display_menu
    puts "These are the events that are happening today:"
    puts ""
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

    next_input = gets.strip
    if next_input == "Y"
      #scrapes page of chosen_event and displays longer description
      puts UtEvents::Scraper.single_event_scrape(chosen_event)
      #binding.pry
      category_menu
    else
      category_menu
    end
  end

  def category_menu
    puts ""
    puts "Would you like to see a list of events belonging to one of these categories?"
    puts "A. Research Opportunities & Studies"
    puts "B. Health & Wellness"
    puts "C. Campus & Community"
    puts "If so, enter the letter corresponding to the category:"
    puts ""
    puts "To start over, type 'start'"
    puts "Or type 'exit' to end the program."
    puts ""
    last_input = gets.strip
    case last_input
    when "A"
      UtEvents::Event.find_by_category("Research Opportunities & Studies").each do |event| #iterates through the new array to print out the event names
        puts "#{event.name}"
          end
    when "B"
      UtEvents::Event.find_by_category("Health & Wellness").each do |event|
        puts "#{event.name}"
      end
    when "C"
      UtEvents::Event.find_by_category("Campus & Community").each do |event|
        puts "#{event.name}"
      end
    when "start"
      display_menu
    when 'exit'
      puts "Goodbye y'all!"
    end
  end

end
