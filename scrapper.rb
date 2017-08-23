require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


### CSV-way data output
def CSV_output array
  CSV.open("csv-3.csv", "w+") do |csv|
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
doc.css('.product-container').each do |var|
  single_product = []
  product = []

  title = var.at_css('.product-name').text.strip
  price = var.at_css('.product-price').text.strip.delete "desde  "
  image = var.at_css('.product_img_link img').attr('src')

  ### Scraps each product item from maing page
  #############################################<
  link = var.at_css('.product-name')['href']
  product_page = Nokogiri::HTML(open(link))
  product_page.css('#right').each do |var1|

    # Get title of product
    title_t = var1.at_css('h1')
    # Cut off <span> elements
    title_t.children.each { |c| c.remove if c.name == 'span' }
    title = title_t.text.strip
    
    # Create multiple prices array 
    prices = []
    var1.css('.attribute_labels_lists .attribute_price').each do |p|
      prices.push(p.text.strip)
    end
    
    # Create multiple weights array   
    weights = []
    var1.css(".attribute_labels_lists .attribute_name").each do |w|
      weights.push(w.text.strip)
    end
    
    # Create complete array of product items (title, weight, price)
    weights.length.times do |i|
      prod = []
      prod.push( title: title, weight: weights[i], price: prices[i]) 
      single_product << prod
    end    
  end  
  #puts JSON.pretty_generate(single_product)
  #############################################<

  product.push( name: title, price: price, img_link: image, varieties: single_product)
  products.push(product)
end

### Console data output 
puts JSON.pretty_generate(products)

### Writes output data to csv file
CSV_output products



