require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

def CSV_output array
  CSV.open("csv-test.csv", "w+") do |csv|
    array.each do |var|
      csv << var
    end
  end
end

page = Nokogiri::HTML(open("https://www.petsonic.com/es/perros/snacks-y-huesos-perro/"))
deploy = []
page.xpath('//*[@id="center_column"]/div/div/div/div/div/div/div/div/h5/a').each do |var|   
  hh = []
  product = Nokogiri::HTML(open(var['href']))
  title = product.xpath('//*[@id="right"]/div/div[1]/div/h1/text()')
  image = product.xpath('//*[@id="bigpic"]').attr('src')    
  hh.push(title, image)
  product.xpath('//*[@id="attributes"]/fieldset/div/ul[@class="attribute_labels_lists"]/li/span[position() <= 2]/text()').each do |temp|
    hh.push(temp)
  end
  deploy << hh
end
CSV_output deploy


#puts JSON.pretty_generate(hh)  

#title = var.xpath('//*[@id="center_column"]/div/div/div/div/div/div/div/div/h5/a').each do |temp|
  #  hh.push(temp.text)
  #end



#title = doc.xpath('//*[@id="center_column"]/div/div/div/div/div/div/div/div/h5/a').each do |var|
# hh.push(var.text.strip)
# end
# puts JSON.pretty_generate(hh)

#products = []

  #link = var.at_css('.product-name')['href']
  #product_page = Nokogiri::HTML(open(link))
  
  #title = var.at_css('.product-name').text.strip
  #price = var.at_css('.product-price').text.strip.delete "desde  "
  #image = var.at_css('.product_img_link img').attr('src')
    
  # product_page = Nokogiri::HTML(open(link))

  # single_product = []
  # product_page.css('#right').each do |var1|
  #   title_t = var1.at_css('h1')
  #   title_t.children.each { |c| c.remove if c.name == 'span' }
  #   title = title_t.text.strip
   
  #   prices = []
  #   var1.css('.attribute_labels_lists .attribute_price').each do |p|
  #     prices << p.text.strip
  #   end
   
  #   weights = []
  #   var1.css(".attribute_labels_lists .attribute_name").each do |w|
  #     weights << w.text.strip
  #   end
    
  #   weights.length.times do |i|
  #     single_product.push( title.strip, weights[i], prices[i]) 
  #   end   
  # end  
  #hh = []
  
  #products.push(hh)
  #puts JSON.pretty_generate(products)
  



#CSV_output products



