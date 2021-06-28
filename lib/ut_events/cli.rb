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
    puts "Type 'Cat' to see a list of event categories."
    puts "Or type 'exit' to quit the program."
    user_input = ""
    user_input = gets.strip
    if user_input == 'exit'
      early_exit
    elsif user_input.to_i.between?(1, UtEvents::Event.all.size)
      index = user_input.to_i - 1
      chosen_event(index)
    elsif user_input == "Cat" || user_input == "cat"
      category_menu
    else
      puts "Please try again"
      main_menu
    end
  end

  def chosen_event(index)
    #identifies event within Event.all array and shows its attributes
    puts "Name: #{UtEvents::Event.all[index].name}"
    puts "Location: #{UtEvents::Event.all[index].location}"
    puts "Brief description: #{UtEvents::Event.all[index].description}"
    puts "Affilations: #{UtEvents::Event.all[index].affiliations.join(', ')}"
    puts "url: #{UtEvents::Event.all[index].event_link}"
    puts ""
    puts "Would you like to see a more detailed description of this event? (Y/n)"
    next_input = gets.strip.downcase
    if next_input == "y"
      #scrapes page of chosen_event and displays longer description
      puts UtEvents::Scraper.single_event_scrape(UtEvents::Event.all[index])
      category_menu
    else
      category_menu
    end
  end

  def early_exit
    puts "Goodbye"
  end

  def category_menu
    puts ""
    puts "Would you like to see a list of events belonging to one of these categories?"
    puts "Ac.  Academics"
    puts "Ar.  Arts & Humanities"
    puts "B.   Business & Economy"
    puts "C.   Campus & Community"
    puts "D.   Diversity"
    puts "H.   Health & Wellness"
    puts "P.   Policy & Law"
    puts "R.   Research Opportunities & Studies"
    puts "Sci. Science & Tech"
    puts "Soc. Social Justicer"
    puts "Spo. Sports & Recreation"
    puts "W.   World & Culture"
    puts "If so, enter the letter(s) corresponding to the category."
    puts "To see all the events again, type 'again'"
    puts "Or type 'done' to end the program."
    puts ""
    last_input = gets.strip.downcase

    case last_input
    when "ac"
      UtEvents::Event.find_by_category("Academics").each do |event| #iterates through the new array to print out the event names
        puts "#{event.name}"
          end
    when "ar"
      UtEvents::Event.find_by_category("Arts & Humanities").each do |event| #iterates through the new array to print out the event names
        puts "#{event.name}"
          end
    when "b"
      UtEvents::Event.find_by_category("Business & Economy").each do |event| #iterates through the new array to print out the event names
        puts "#{event.name}"
          end
    when "c"
      UtEvents::Event.find_by_category("Campus & Community").each do |event|
        #puts "#{event.name}"
        display_event(event)
      end
      second_look()
    when "d"
      UtEvents::Event.find_by_category("Diversity").each do |event|
        puts "#{event.name}"
      end
    when "h"
      UtEvents::Event.find_by_category("Health & Wellness").each do |event|
        puts "Event"
        puts "-#{event.name}"
        puts "-#{event.location}"
        puts "-#{event.description}"
        puts "-url: #{event.event_link}"
        puts "---------------------------"
      end
    when "p"
      UtEvents::Event.find_by_category("Policy & Law").each do |event|
        puts "#{event.name}"
      end
    when "r"
      UtEvents::Event.find_by_category("Research Opportunities & Studies").each do |event|
        puts "#{event.name}"
      end
    when "sci"
      UtEvents::Event.find_by_category("Science & Tech").each do |event|
        puts "#{event.name}"
      end
    when "soc"
      UtEvents::Event.find_by_category("Social Justice").each do |event|
        puts "#{event.name}"
      end
    when "spo"
      UtEvents::Event.find_by_category("Sports & Recreation").each do |event|
        puts "#{event.name}"
      end
    when "w"
      UtEvents::Event.find_by_category("World & Culture").each do |event|
        puts "#{event.name}"
      end
    when "again"
      display_menu
    when 'done'
      puts "Goodbye y'all!"
    end
  end

  def display_event(event)
    puts "********Event**************"
    puts "-#{event.name}"
    puts "-#{event.location}"
    puts "-#{event.description}"
    puts "-url: #{event.event_link}"
    puts "---------------------------"
  end

  def second_look
    puts "Do you want to see all the events again?"
    puts "Type y for yes, n to exit the program"
    user_input = ""
    user_input = gets.strip
    if user_input == 'n' || user_input == 'N'
      puts "Goodbye y'all!"
    else
      main_menu
    end
  end

end
