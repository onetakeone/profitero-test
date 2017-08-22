require 'open-uri'
require 'nokogiri'
require 'json'

### Set data to file function
def output array
  output = File.open "scrapper.csv", "w"
  array.each do |var|  
    output.write " #{var},  \n"  
  end 
  output.close
end

### Create Nokogiri INSTANCE
doc = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/"))

### Create an array to fill with product data
products = []

### Scrapping 
doc.css('.product-container').each do |showing|
  title = showing.at_css('.product-name').text.strip
  price = showing.at_css('.product-price').text.strip.delete "desde  "
  image = showing.at_css('.product_img_link img').attr('src')
  products.push(" #{title}, #{price}, #{image}")
end

puts JSON.pretty_generate(products)
#output products

