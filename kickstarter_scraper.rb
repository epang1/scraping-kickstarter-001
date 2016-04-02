# require libraries/modules here

require 'pry'
require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  hash = {}

  projects = kickstarter.css("li.project.grid_4")


  projects.each do |project|

    title =  project.css("h2.bbcard_name strong a").text
    image = project.css("div.project-thumbnail a img").attribute("src")
    description = project.css("p.bbcard_blurb").text
    location = project.css("ul.project-meta li a location-name").text
    funded = project.css("li.first funded strong").text.gsub("%","").to_i

    hash[title.to_sym] = {:title => title, :image_link => image, :description => description, :location => location, :percent_funded => funded}

  end

  hash
end


