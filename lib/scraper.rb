require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css("div.student-card").each do |student_card|
      student_array << {
        :name => student_card.css("a div.card-text-container h4.student-name").text, 
        :location => student_card.css("a div.card-text-container p.student-location").text, 
        :profile_url => student_card.css("a")[0]["href"]
      }
    end
    student_array 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {
      :profile_quote => doc.css("div.vitals-text-container div.profile-quote").text,
      :bio => doc.css("div.description-holder p").text
    }

    vitals = doc.css("div.social-icon-container a").collect {|icon| icon["href"] }
    
    vitals.each do |vital|
      if vital.include?("twitter")
        student_hash[:twitter] = vital 
      elsif vital.include?("linkedin")
        student_hash[:linkedin] = vital
      elsif vital.include?("github")
        student_hash[:github] = vital
      elsif vital.include?(".com")
        student_hash[:blog] = vital 
      end
    end

    student_hash 



    # student_hash = {
    #     :twitter => vitals[0]["href"],
    #     :linkedin => vitals[1]["href"],
    #     :github => vitals[2]["href"],
    #     :blog => vitals[3]["href"],
    #     :profile_quote => doc.css("div.vitals-text-container div.profile-quote").text,
    #     :bio => doc.css("div.description-holder p").text
    # }
  end

end

