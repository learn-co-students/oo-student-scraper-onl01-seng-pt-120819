require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './student.rb'


class Scraper

  #index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
     
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html) #nested node
    student_card = doc.css(".student-card a")
    
    
    students_arr = []
    
    student_card.each {|s| 
      profile_url = s['href'] #attribute 
      name = s.css(".student-name").text
      location = s.css(".student-location").text
      
      student = {:name => name, :location => location, :profile_url => profile_url}
      
      students_arr << student 
    }
    
    students_arr
  end

  
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html) #nested node
    profile = doc.css(".profile")#2 classes
    
    profile_hash = {}
    
    social_media = profile.css(".social-icon-container a")
    
    social_media.each { |account| 
      account = account['href']
      if account.include?("twitter")
        profile_hash[:twitter] = account
      elsif account.include?("linkedin")
        profile_hash[:linkedin] = account
      elsif account.include?("github")
        profile_hash[:github] = account
      else
         profile_hash[:blog] = account
      end
    }
    
    profile_quote = profile.css(".profile-quote").text
    bio = profile.css(".bio-content .description-holder p").text
    
    profile_hash[:profile_quote] = profile_quote
    profile_hash[:bio] = bio

    profile_hash      
  end

end

#Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
#Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/joe-burgess.html")