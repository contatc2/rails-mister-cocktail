require 'open-uri'
require 'json'

puts 'start seeding'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_list = JSON.parse(open(url).read)

ingredients_list['drinks'].each do |item|
  Ingredient.create!(name: item['strIngredient1'])
end

puts 'finished seeding'
