require 'open-uri'
require 'nokogiri'
require 'json'

puts 'start seeding ingredients'

Ingredient.all.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_list = JSON.parse(open(url).read)

ingredients_list['drinks'].each do |item|
  Ingredient.create!(name: item['strIngredient1'])
end

puts 'finished seeding'

puts 'start seeding cocktails'

Cocktail.all.destroy_all

url = 'https://vinepair.com/articles/50-most-popular-cocktails-world-2017/'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

array_names = html_doc.search('h3').map do |element|
  element.text.strip
  # element.next_element.text
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
# p array_p
# p array_p.count
array_names.delete('30. Sidecar')
array_names.delete('5. Manhattan')
# p array_names[2..49]
# p array_names[2..49].count
sidecar = Cocktail.create(
  name: '30. Sidecar',
  description: 'Brandy, tragically underrepresented on this list, earns a well-deserved moment in the worldwide spotlight as the star of one of the world’s most-ordered cocktails. The Sidecar is a good place to start for those not familiar with the category-spanning spirit: the drink mixes brandy, lemon, and triple sec, making a tart, refreshing tipple.'
)
cocktail_image = sidecar.images.build
cocktail_image.remote_image_url = 'https://static.vinepair.com/wp-content/uploads/2017/11/sidecar-inside.jpg'
cocktail_image.save

array_names[2..49].each_with_index do |name, i|
  image = if array_p[i][:img] == ''
    'https://images.pexels.com/photos/33400/champagner-toasting-new-year-s-eve-drink.jpg?auto=compress&cs=tinysrgb&dpr=1&w=50'
  else array_p[i][:img]
  end
  cocktail = Cocktail.create(
    name: name,
    description: array_p[i][:p]
  )
  cocktail_image = cocktail.images.build
  cocktail_image.remote_image_url = image
  cocktail_image.save
end

manhattan = Cocktail.create(
  name: '5. Manhattan',
  description: 'It’s hard to stray from the Manhattan, and the recent rise of rye whiskey makes it even more difficult. Spicy rye, sweet vermouth, and two dashes of Angostura, stirred, strained, and garnished with a brandied cherry can make you feel like a true class act.'
)
cocktail_image = manhattan.images.build
cocktail_image.remote_image_url = 'https://static.vinepair.com/wp-content/uploads/2017/11/manhattan-inside.jpg'
cocktail_image.save

puts 'finished seeding cocktails'
