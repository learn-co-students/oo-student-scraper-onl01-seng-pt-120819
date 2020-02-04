require 'open-uri'
require 'pry'

class Scraper
  
  # :name => student.css(".student-name").text
  # :location => student.css(".student-location").text
  # :profile_url => student.attr("href")
  

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    
    student_card = page.css("div.student-card a")
    student_card.collect do |student|
      {:name => student.css(".student-name").text,
       :location => student.css(".student-location").text,
       :profile_url => student.attr("href")
      }
    end
  end
  
  # :twitter=>
  # :linkedin=>
  # :github=>
  # :blog=>
  # :profile_quote=>
  # :bio=>
  
  
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    
    return_hash = {}
    
    social_media = page.css(".vitals-container .social-icon-container a")
    social_media.each do |element| #iterate through each of the social elements and assign the keys if the item exists
      
      if element.attr("href").include?("twitter")
        return_hash[:twitter] = element.attr("href")
      elsif element.attr("href").include?("linkedin")
        return_hash[:linkedin] = element.attr("href")
      elsif element.attr("href").include?("github")
        return_hash[:github] = element.attr("href")
      elsif element.attr("href").include?(".com")
        return_hash[:blog] = element.attr("href")
      end
    end 
      return_hash[:profile_quote] = page.css(".profile-quote").text
      return_hash[:bio] = page.css(".description-holder p").text
      
      return_hash
  end

end

