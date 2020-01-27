require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
 
    page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info= {
        :name => name,
        :location => location,
        :profile_url => profile_url,
      }
      students << student_info
      end
    students
 end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    students = {}
    social = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      social.each do |link|
      if link.include?("twitter")
        students[:twitter] = link
      elsif link.include?("linkedin")
      students[:linkedin] = link
      elsif link.include?("github")
        students[:github]= link
      elsif link.include?(".com")
        students[:blog] = link
      end
    end
      :profile_quote => page.css(".profile-quote").text,
      :bio => page.css("div.description-holder p").text
    students
  end

end

