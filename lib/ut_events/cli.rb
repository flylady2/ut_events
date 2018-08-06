class UtEvents::CLI

  def start
    puts "Welcome to UT Daily Events"
    #scraping data from UT calendar
    #creating Event objects from scraped data
    UtEvents::Event.create_from_array(UtEvents::Scraper.scrape_events)
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
    puts "Or type 'exit' to quit the program."
    user_input = ""
    user_input = gets.strip
    if user_input == 'exit'
      early_exit
    end
    index = user_input.to_i - 1
    if index < 0
      puts "Please try again"
      puts "To view additional details about a particular event, type in its number from the list."
      index = gets.strip.to_i
        if index.between?(0, UtEvents::Event.all.size - 1)

    #identifies event within Event.all array and shows its attributes
      chosen_event = UtEvents::Event.all[index]
      puts "Name: #{chosen_event.name}"
      puts "Location: #{chosen_event.location}"
      puts "Brief description: #{chosen_event.description}"
      puts "Affilations: #{chosen_event.affiliations.join(', ')}"
      puts "url: #{chosen_event.event_link}"
      puts ""
    end
      puts "Would you like to see a more detailed description of this event? (Y/n)"
      next_input = gets.strip.downcase
      if next_input == "y"
        #scrapes page of chosen_event and displays longer description
        puts UtEvents::Scraper.single_event_scrape(chosen_event)
        category_menu
      else
        category_menu
      end
    end
  end

  def early_exit
    puts "Goodbye"
  end

  def category_menu
    puts ""
    puts "Would you like to see a list of events belonging to one of these categories?"
    puts "A. Research Opportunities & Studies"
    puts "B. Health & Wellness"
    puts "C. Campus & Community"
    puts "If so, enter the letter corresponding to the category."
    puts "To see all the events again, type 'again'"
    puts "Or type 'done' to end the program."
    puts ""
    last_input = gets.strip.downcase
    case last_input
    when "a"
      UtEvents::Event.find_by_category("Research Opportunities & Studies").each do |event| #iterates through the new array to print out the event names
        puts "#{event.name}"
          end
    when "b"
      UtEvents::Event.find_by_category("Health & Wellness").each do |event|
        puts "#{event.name}"
      end
    when "c"
      UtEvents::Event.find_by_category("Campus & Community").each do |event|
        puts "#{event.name}"
      end
    when "again"
      display_menu
    when 'done'
      puts "Goodbye y'all!"
    end
  end

end
