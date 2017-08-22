require 'open-uri'
require 'nokogiri'

# Set data to file function
def output array
  output = File.open "scrapper.csv", "w"
  array.each do |var|  
    output.write " #{var},  \n"  
  end 
  output.close
end

# Create Nokogiri INSTANCE
doc = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/"))

products = []


doc.css('.top-product-meta').each do |showing|
  title = showing.at_css('.product-name').text.strip
  price_1 = showing.at_css('.product-price')
  price =  price_1.text.strip.delete "desde  "
  products.push(" #{title}, #{price}")
end

output products

