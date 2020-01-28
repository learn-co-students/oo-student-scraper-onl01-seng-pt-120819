require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    hashyhash = []
    student_names = doc.css(".student-card a .card-text-container .student-name").text
    student_location = doc.css(".student-card a .card-text-container .student-location").text
    # student_urls = 
    x = doc.css(".student-card a")




    # doc.css(".student-card a .card-text-container .student-name").each do |namez|
    #   hashyhash << { ':name' => namez.text }
    # end

    # doc.css(".student-card a .card-text-container .student-location").each do |loc|
    #   hashyhash << {':location' => loc.text }
    # end

    # doc.css('.student-card a').each do |link|
    #    hashyhash << {':profile_url' => link['href']}
    # end
x.each do |x|
  hashyhash << { :name =>"#{x.css('.student-name').text}", :location => "#{x.css('.student-location').text}", :profile_url => "#{x.first[1]}"}
end

    # binding.pry
    pp hashyhash
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
=begin
stn.each do |names|
  puts names.text.strip
end -------------- this is a loop that puts all the names

stn.each do |names|
  puts names
end

{
  name
  location
  profile_url
}



=end