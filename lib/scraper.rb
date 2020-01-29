require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    hashyhash = []
    x = doc.css(".student-card a")

    x.each do |y|
      hashyhash << { :name =>"#{y.css('.student-name').text}", :location => "#{y.css('.student-location').text}", :profile_url => "#{y.attr('href')}"}
      # binding.pry
    end
    
    hashyhash
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    x = doc.css('.profile .vitals-container .social-icon-container a')

    hashyhash = {}
    
    doc.css('.profile .vitals-container .social-icon-container').children.css('a').map do |y|
      # binding.pry
      if y.attr('href').include?('twitter')
        hashyhash[:twitter] = y.attr('href')
      elsif y.attr('href').include?('linkedin')
        hashyhash[:linkedin] = y.attr('href')
      elsif y.attr('href').include?('github')
        hashyhash[:github] = y.attr('href')
      elsif y.attr('href').include?('http')
        hashyhash[:blog] = y.attr('href')
      end
      # binding.pry
    end 
    hashyhash[:profile_quote] = doc.css('.profile .vitals-text-container .profile-quote').text
    hashyhash[:bio] = doc.css('.profile .details-container .description-holder p').text
    hashyhash
  end

end


