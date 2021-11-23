require 'open-uri'
require 'nokogiri'

# ingredient = 'chocolate'
url = "https://www.boardgamegeek.com/xmlapi2/hot?boardgame"

html_file = URI.open(url).read
html_doc = Nokogiri::XML(html_file)

# puts html_doc

html_doc.root.xpath('item').each do |item|
  name = item.at('name')['value']
  thumbnail = item.at('thumbnail')['value']
  yearpublished = item.at('yearpublished')['value']

  puts "#{name}"
  puts "#{yearpublished}"
  puts "#{thumbnail}"
end
