require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

def output array
  CSV.open("csv-test.csv", "w+") do |csv|
    array.each do |var|
      csv << var
    end
  end
end

csv = []
1.upto(12) do |i|
  page = Nokogiri::HTML(open("https://www.petsonic.com/snacks-huesos-para-perros/?p=#{i}"))  
  page.xpath('//*[@id="center_column"]/div/div/div/div/div/div/div/div/h5/a').each do |var|   
    product = Nokogiri::HTML(open(var['href']))
    title = product.xpath('//*[@id="right"]/div/div[1]/div/h1/text()')
    image = product.xpath('//*[@id="bigpic"]').attr('src')    
    product_info = []
    product_info.push(title, image)
    product.xpath('//*[@id="attributes"]/fieldset/div/ul[@class="attribute_labels_lists"]/li/span[position() <= 2]/text()').each do |weight_price|
      product_info.push(weight_price)
    end
    csv << product_info
  end  
end
#puts JSON.pretty_generate(csv) 
output csv
