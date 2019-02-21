require 'open-uri'
require 'nokogiri'
require 'json'

# puts 'start seeding'

# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# ingredients_list = JSON.parse(open(url).read)

# ingredients_list['drinks'].each do |item|
#   Ingredient.create!(name: item['strIngredient1'])
# end

# puts 'finished seeding'

puts 'start seeding cocktails'

url = 'https://vinepair.com/articles/50-most-popular-cocktails-world-2017/'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

array_names = html_doc.search('h3').map do |element|
  element.text.gsub(/\d+\.\s/, '').strip
end

array_p = html_doc.search('h3 + p').map do |element|
  if element.search('img').any?
    { img: element.search('img').attribute('src').value, p: element.text.strip }
  else
    { img: '', p: element.text.strip }
  end
end

array_p.unshift(img: 'https://static.vinepair.com/wp-content/uploads/2017/11/white-russian-inside.jpg',
                p: 'Created in 1949 by a Belgian bartender named Gustave Tops, and popularized by the 1998 film “The Big Lebowski,” the White Russian continues to be a world-wide favorite. The White Russian combines heavy cream (or half and half), vodka, and coffee liqueur for a luxurious nightcap.')
p array_p.count
array_names.delete('Sidecar')
p array_names[2..50]
p array_names[2..50].count

# array_names[3..51].each_with_index do |name, i|
#   image = if array_p[i][:img] == ''
#             'https://images.pexels.com/photos/274192/pexels-photo-274192.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
#           else array_p[i][:img]
#           end
#   Cocktail.new(
#     name: name,
#     description: array_p[i][:p],
#     image: image
#   )
# end

Cocktail.new(
  name: 'Sidecar',
  description: 'Brandy, tragically underrepresented on this list, earns a well-deserved moment in the worldwide spotlight as the star of one of the world’s most-ordered cocktails. The Sidecar is a good place to start for those not familiar with the category-spanning spirit: the drink mixes brandy, lemon, and triple sec, making a tart, refreshing tipple.',
  image: 'https://static.vinepair.com/wp-content/uploads/2017/11/sidecar-inside.jpg'
)


puts 'finished seeding cocktails'
