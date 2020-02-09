require 'pry'
require 'nokogiri'
require 'open-uri'





class Scraper

  #attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
#binding.pry
    students = []

    doc.css(".student-card").each do |student|
      id = student.css("h4").text
      students[id.to_sym] = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css("a").attribute('href').value
      #binding.pry
    }

  end

  # return the projects hash
   students
  end

  def self.scrape_profile_page(profile_url)

  end

end
