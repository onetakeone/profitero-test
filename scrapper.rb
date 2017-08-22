require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/"))

products = []

doc.css('.top-product-meta').each do |showing|
  title = showing.at_css('.product-name').text.strip
  products.push(title,)
end


output = File.open "scrapper.csv", "w"

products.each do |var|  
    output.write " #{var},  \n"  
end 

output.close