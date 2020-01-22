require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    source_page = Nokogiri::HTML(open(index_url)) # Where are you getting your info from?
    scraped_students = [] # set empty array to push acquired information into

    source_page.css("div.roster-cards-container").each do |roster| #iterate roster
      roster.css(".student-card a").each do |student| # go in one level and iterate to gather information about students
        #assign scraped details to variables
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr('href')}" #<a href="ryan-johnson.html">
        # set up hash with keys and variables as the values to be pushed into array; each hash is a different student
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile_url} #each hash is one student

      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
