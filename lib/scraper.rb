require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    source_page = Nokogiri::HTML(open(index_url))
    scraped_students = []

    source_page.css("div.roster-cards-container").each do |roster|
      roster.css(".student_card a").each do |student|
        #assign scraped details to variables
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr('href')}" #<a href="ryan-johnson.html">
        scraped_students << {name: student_name, location: student_location, profile: student_profile_url} #each hash is one student

      end
    end
    scraped_students
  end
  binding.pry
  def self.scrape_profile_page(profile_url)

  end

end
