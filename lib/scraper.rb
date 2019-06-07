require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    #binding.pry
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text 
      student_hash[:profile_url] = student.css("a").first["href"]
      #binding.pry
      student_list << student_hash 
    end 
    student_list
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container").each do |icon|
      student_profile[:twitter] = icon.css(a*="twitter")#.first["href"]
      student_profile[:linkedin] = icon.css(a*="linkedin")#.first["href"]
      student_profile[:github] = icon.css(a*="github")#.first["href"]
      binding.pry
    end 
  end

end

