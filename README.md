# Project 3
### Web Scraping

### Roles
* Overall Project Manager: Will Greenway
* Coding Manager: Carter Brown
* Testing Manager: Ally Chitwood
* Documentation: Daniel Greer

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

Carter:

- Implemented find_jobs method
- Helped with output_jobs method with Daniel and Ally
- Helped with formatting text output

Daniel:

- Wrote output_jobs method with Carter and Ally
- Used Mechanize to get the starting webpage and form
- Wrote hashes for options for the search form

Ally:

- Wrote input_grabber class
- Added loop for repeated searches
- Helped refactor output_jobs

Will:

- Wrote input_grabber methods with Ally and Nathan
- Modified option hashes with Daniel
- Implemented protection from bad user input with Nathan


Nathan:

- Wrote input grabber method with Ally and Will
- Implemented protection from bad user input with Will

### Dependencies and Run Instructions
The script is dependent on the Ruby gems Mechanize and Nokogiri.
To run the script, use the command $ruby web_scraper.rb
