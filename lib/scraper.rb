require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
      student = Nokogiri::HTML(open(index_url))
      scraped_students = []
      student.css(".student-card").each do |s|
      
      students_data =
        { 
         :name => s.css("h4.student-name").text,
         :profile_url => s.css("a").attribute("href").value,
         :location => s.css("p.student-location").text
        }
        scraped_students << students_data
    end 
       scraped_students
  end 


  def self.scrape_profile_page(profile_url)
    
    page= Nokogiri::HTML(open(profile_url))
    

    student = {}
    profile=page.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}

    profile.each do |link|
      
      if link.include? ("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
           student[:linkedin] = link 
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
      end 
    end 
     
    student[:profile_quote] = page.css(".profile-quote").text 
    student[:bio] = page.css("div.description-holder p").text 
    student
  end
 
end
