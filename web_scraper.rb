require_relative 'input_grabber'
require 'mechanize'

# Method to find the jobs after the search form was submitted
# Author: Carter Brown
# @params
#   agent: Mechanize instance
#   page: Mechanize::Page
# @return number of jobs in search
def find_jobs(agent, page)
  search_count = 0

  loop do
    # Strip html tags
    links = page.search "//div//h3//a"

    # Print jobs and links
    output_jobs(links) if links.length > 0

    # Update cumulative number of jobs
    search_count += links.length

    # Look to see if there are multiple pages
    nodes = page.xpath('//a[contains(@class, "next_page")]')

    break if nodes.empty?

    # Go to next page
    path = nodes.first['href']
    page = agent.get("https://www.jobsatosu.com#{path}")
    sleep 1
  end
  search_count
end

# Method to output the jobs found, if any, along with their respective links
# Authors: Daniel, Ally, Carter
# @params
#   links: a node list of Mechanize link objects
def output_jobs(links)
  links.length
  links.each { |link| puts link.text + "\n\t" + "https://www.jobsatosu.com" + link['href']}
end


# Main processing begins here
# Run searches on the jobsatosu.com website
loop do
  puts "Beginning search for careers at Ohio State."
  puts "You will first be able to enter any keywords."
  puts "Then, you will be able to select from possible job locations, categories, and full or part time.\n"

  # Initialize Mechanize object
  agent = Mechanize.new
  page = agent.get('https://www.jobsatosu.com/postings/search')
  search_form = page.form(:name=>nil)

  # Grab keywords to narrow search
  inputed_keywords = InputGrabber.grab_keywords
  puts

  # List locations and let user select one option
  location_options = {"No Selection" => 'any', "Columbus" => '1', "Lima" => '2', "Mansfield" => '3', "Marion" => '4', "Newark" => '5', "Wooster" => '6', "Delaware" => '8', "Springfield" => '9', "Piketon" => '10', "Dayton" => '11'}
  selected_location = InputGrabber.grab_selected_option "Location", location_options
  puts

  # List categories and let user select one option
  category_options = {"No Selection" => 'any', "Instructional-Faculty" => '2', "Administrative" => '3', "IT" => '4', "Research" => '5', "Civil Service" => '6'}
  selected_category = InputGrabber.grab_selected_option "Category", category_options
  puts

  # List work times and let user select one option
  full_part_time_options = {"No Selection" => 'any', "Full-time" => '4', "Part-time" => '5', "Temporary" => '6', "Term": '7'}
  selected_full_part_time = InputGrabber.grab_selected_option "Full/Part Time", full_part_time_options
  puts

  # Fill out search form accordingly
  search_form.field(:name=>'query').value = inputed_keywords
  search_form.field(:name=>'591[]').value = selected_location
  search_form.field(:name=>'580[]').value = selected_category
  search_form.field(:name=>'581[]').value = selected_full_part_time

  page = agent.submit(search_form)

  # Find job based on search forms
  number_jobs = find_jobs(agent, page)

  # Print number of jobs and summarize search criteria
  puts "Your Search:"
  puts "Keywords\t\t #{inputed_keywords}"
  puts "Location\t\t #{location_options.key(selected_location)}"
  puts "Category\t\t #{category_options.key(selected_category)}"
  puts "Full/Part Time\t #{full_part_time_options.key(selected_full_part_time)}"
  puts "#{number_jobs} Jobs Founds"
  puts

  # Allow user to enter another job search
  continue = InputGrabber.grab_continue_choice
  break if continue == "no"
  puts

end
