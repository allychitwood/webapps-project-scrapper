require 'mechanize'

# Author class and methods: Ally Chitwood
# Author methods: Will Greenway and Nathan Simpson
#   Prompts for, processes, checks, and return user input
class InputGrabber

  # Grabs search keywords
  # @return string of keywords
  def self.grab_keywords
    print "Enter Keywords (zero or more): "
    gets.chomp!
  end

  # Lists options with numbers and grabs selected option
  # @params
  #   option_name_str: "Location", "Category", or "Full/Part Time"
  #   options: hash of key value pairs option=>number
  # @return string of selected option
  def self.grab_selected_option(option_name_str, options)
    # Listing options
    puts "#{option_name_str}: "
    options.each { |x, y| puts "#{y}\t #{x}" }

    # Prompting user
    print "Enter Job #{option_name_str} (indicated number or 'any'): "

    # Processing and error checking
    selected_option = gets.chomp!

    until options.has_value?(selected_option)
      print "Error, enter valid option. Enter Job #{option_name_str} (indicated number or 'any'): "
      selected_option = gets.chomp!
    end
    selected_option
  end

  # Grab preference whether to continue or not
  # @return "yes" or "no"
  def self.grab_continue_choice
    print "Would you like to begin another search ('yes' or 'no')? "
    continue = gets.chomp!

    until continue == "yes" || continue == "no"
      print "Error, enter valid option. Would you like to begin another search ('yes' or 'no')? "
      continue = gets.chomp!
    end
    continue
  end
end