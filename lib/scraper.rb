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
    source_page = Nokogiri::HTML(open(profile_url))
    profile = {}
    #Some students don't have a Twitter or some other social link. Be sure to be able to handle that.
    #     {
    #   :twitter=>"http://twitter.com/flatironschool",
    #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
    #   :github=>"https://github.com/learn-co",
    #   :blog=>"http://flatironschool.com",
    #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #   :bio=> "I'm a school"
    # }
    links = source_page.css(".social-icon-container").children.css("a").map { |p_url| p_url.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
  
  profile[:profile_quote] = source_page.css(".profile-quote").text if source_page.css(".profile-quote")
  profile[:bio] = source_page.css("div.bio-content.content-holder div.description-holder p").text if source_page.css("div.bio-content.content-holder div.description-holder p")

  profile

  end

end
