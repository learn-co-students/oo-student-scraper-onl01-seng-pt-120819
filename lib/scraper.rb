require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    
    index.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      # url = student.css("a").attribute("href").value
      # student_details[:profile_url] = index_url.chomp("student-scraper-test-page/index.html") + url   
      student_details[:profile_url] = student.css("a").attribute("href").value
      students << student_details 
    end 
    students 
    
    # student: index.css("div.student-card")
    # name: index.css("h4.student-name").text
    # location: index.css("p.student-location").text
    # profile_url: index.css("a").attribute("href").value 
    
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    profile.css("div.social-icon-container a").each do |social_media|      
      if social_media.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social_media.attribute("href").value 
      elsif social_media.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social_media.attribute("href").value
      elsif social_media.attribute("href").value.include?("github")
        student_profile[:github] = social_media.attribute("href").value 
      else 
        student_profile[:blog] = social_media.attribute("href").value
      end 
    end 
    student_profile[:profile_quote] = profile.css("div.vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.details-container .bio-content.content-holder .description-holder p").text
    
    student_profile
    
  end

end

