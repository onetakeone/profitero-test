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
single_product = []

### Scrapping 
doc.css('.product-container').each do |var|
  product = []
  title = var.at_css('.product-name').text.strip
  price = var.at_css('.product-price').text.strip.delete "desde  "
  image = var.at_css('.product_img_link img').attr('src')

    ################################################
    link = var.at_css('.product-name')['href']
    product_page = Nokogiri::HTML(open(link))
    

    product_page.css('#right').each do |var|
      title_t = var.at_css('h1')
      title_t.children.each { |c| c.remove if c.name == 'span' }
      title = title_t.text.strip
      
      prices = []
      var.css('.attribute_labels_lists .attribute_price').each do |p|
        prices.push(p.text.strip)
      end
        
      weights = []
      var.css(".attribute_labels_lists .attribute_name").each do |w|
        weights.push(w.text.strip)
      end
      
      weights.length.times do |i|
        prod = []
        product.push(title, weights[i], prices[i]) 
        single_product << prod
      end    
    end
    
    # CSV_output products
    ################################################

  product.push(title, price, image, link)
  products.push(product)
end

### Console data output 
puts JSON.pretty_generate(single_product)
puts JSON.pretty_generate(products)

### Writes output data to csv file
# CSV_output products



