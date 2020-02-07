require 'nokogiri'
require 'open-uri'
require 'pry'


doc.css(".inlineMobileLeft-2Yo002.imageTextBlockGrid3-2XAK6G")

class Scraper

  #attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html/")
    doc = Nokogiri::HTML(html)

    students = {}

    doc.css("div.roster-cards-container").each do |card|
     students[card] = {
      :name => project.css("#ryan-johnson-card > a > div.card-text-container > h4").text,
      :location => project.css("#ryan-johnson-card > a > div.card-text-container > p").text,
      :profile_url => project.css("#ryan-johnson-card > a").text.gsub("%","").to_i
    }
  end

  # return the projects hash
  projects
  end

  def self.scrape_profile_page(profile_url)

  end

end
