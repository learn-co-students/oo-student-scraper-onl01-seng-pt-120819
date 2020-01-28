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
    # twitter = x[0].attr('href')
    # linkedin = x[1].attr('href')
    # github = x[2].attr('href')
    # blog = x[3].attr('href')


    # hashyhash = {
    #   :twitter => twitter ? twitter : nil,
    #   :linkedin => linkedin ? linkedin : nil,
    #   :github => github ? github : nil,
    #   :blog => blog ? blog : nil,
    #   :profile_quote => doc.css('.profile .vitals-text-container .profile-quote').text,
    #   :bio => doc.css('.profile .details-container .description-holder p').text
    # }

    hashyhash = {
    }
    doc.css('.profile .vitals-container .social-icon-container').each do |y|
      if y.css('a').attr('href').value.include?('twitter')
        hashyhash[:twitter] = y.css('a').attr('href').value
      elsif y.css('a').attr('href').value.include?('linkedin')
        hashyhash[:linkedin] = y.css('a').attr('href').value 
      elsif y.css('a').attr('href').value.include?('github')
        hashyhash[:github] = y.css('a').attr('href').value 
      elsif y.css('a').attr('href').value.include?('rss')
        hashyhash[:blog] = y.css('a').attr('href').value
      end
      # binding.pry
    end 
pp hashyhash
    # x.each do |y|
    #   # puts y.attr('href')
    #   hashyhash[key] = y.attr('href')
    #   # binding.pry
    # end
    # binding.pry
    # x.attr('href').value == twitter
  end

end


