require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

### Simple data record via file.open 
def fileopen_output array
  output = File.open "scrapper.csv", "w"
  array.each do |var|  
    output.write " #{var},  \n"  
  end 
  output.close
end

### CSV-way data output
def CSV_output array
  CSV.open("csv-scrapper.csv", "wb") do |csv|
    products.each do |var|
      csv << var
    end
  end
end

### Create Nokogiri INSTANCE
doc = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/"))

### Create an array to fill with product data
products = []

### Scrapping 
doc.css('.product-container').each do |showing|
  product = []
  title = showing.at_css('.product-name').text.strip
  price = showing.at_css('.product-price').text.strip.delete "desde  "
  image = showing.at_css('.product_img_link img').attr('src')
  product.push(title, price, image)
  products.push(product)
end

### Console data output 
puts JSON.pretty_generate(products)

### Writes output data to csv file
fileopen_output products
CSV_output products



