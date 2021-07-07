require 'pry'
require 'nokogiri'
require 'open-uri'





class Scraper



  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
    #binding.pry
    students_array = []

    doc.css(".student-card").each do |student|
      id = {}
      id = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute('href').value
        #binding.pry
      }
      students_array << id
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    #binding.pry
    profile = {}
    doc.css(".social-icon-container").each do |social|

      if social.css("a:nth-child(1)").attribute('href') != nil
          handle_1 = social.css("a:nth-child(1)").attribute('href').value
          if handle_1.to_s.include?("twitter")
            profile[:twitter] = handle_1
          elsif handle_1.to_s.include?("linkedin")
            profile[:linkedin] = handle_1
          elsif handle_1.to_s.include?("github")
            profile[:github] = handle_1
          else
            profile[:blog] = handle_1
          end
        end

      if social.css("a:nth-child(2)").attribute('href') != nil
          handle_2 = social.css("a:nth-child(2)").attribute('href').value
          if handle_2.to_s.include?("twitter")
            profile[:twitter] = handle_2
          elsif handle_2.to_s.include?("linkedin")
            profile[:linkedin] = handle_2
          elsif handle_2.to_s.include?("github")
            profile[:github] = handle_2
          else
            profile[:blog] = handle_2
          end
        end

      if social.css("a:nth-child(3)").attribute('href') != nil
          handle_3 = social.css("a:nth-child(3)").attribute('href').value
          if handle_3.to_s.include?("twitter")
            profile[:twitter] = handle_3
          elsif handle_3.to_s.include?("linkedin")
            profile[:linkedin] = handle_3
          elsif handle_3.to_s.include?("github")
            profile[:github] = handle_3
          else
            profile[:blog] = handle_3
          end
        end

      if social.css("a:nth-child(4)").attribute('href') != nil
          handle_4 = social.css("a:nth-child(4)").attribute('href').value
          if handle_4.to_s.include?("twitter")
            profile[:twitter] = handle_4
          elsif handle_4.to_s.include?("linkedin")
            profile[:linkedin] = handle_4
          elsif handle_4.to_s.include?("github")
            profile[:github] = handle_4
          else
            profile[:blog] = handle_4
          end
      end

    end
    profile[:profile_quote] = doc.css(".vitals-container .profile-quote").text
    profile[:bio] = doc.css(".details-container .description-holder p").text
    #binding.pry
    profile
  end
end
