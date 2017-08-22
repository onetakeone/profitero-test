require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

### CSV data output
def CSV_output array
  CSV.open("csv-multi.csv", "w+") do |csv|
    array.each do |var|
      csv << var
    end
  end
end

doc = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/galletas-granja-para-perro/"))

products = []

doc.css('#right').each do |var|

  title_t = var.at_css('h1')
  title_t.children.each { |c| c.remove if c.name == 'span' }
  title = title_t.text.strip
  
  price = []
  var.css('.attribute_labels_lists .attribute_price').each do |p|
    price.push(p.text.strip)
  end
    
  weight = []
  var.css(".attribute_labels_lists .attribute_name").each do |w|
    weight.push(w.text.strip)
  end
  
  weight.length.times do |i|
    product = []
    product.push(title, weight[i], price[i]) 
    products << product  
  end    
end

puts JSON.pretty_generate(products)
CSV_output products



