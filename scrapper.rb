require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


### CSV-way data output
def CSV_output array
  CSV.open("csv-1.csv", "w+") do |csv|
    array.each do |var|
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
CSV_output products



