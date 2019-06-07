require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text 
      student_hash[:profile_url] = student.css("a").first["href"]
      student_list << student_hash 
    end 
    student_list
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    
    doc = Nokogiri::HTML(open(profile_url))
    
    doc.css(".social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
        student_profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
        student_profile[:bio] = doc.css(".description-holder p").text
         
    end
    
    student_profile
  end

end

