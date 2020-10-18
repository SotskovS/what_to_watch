require 'uri'
require 'net/http'
require 'mechanize'
require_relative 'lib/film'
require_relative 'lib/film_collection'

agent = Mechanize.new
html = 'https://ru.wikipedia.org/wiki/250_%D0%BB%D1%83%D1%87%D1%88%D0%B8%D1%85_%D1%84%D0%B8%D0%BB%D1%8C%D0%BC%D0%BE%D0%B2_%D0%BF%D0%BE_%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B8_IMDb'
page = agent.get(html)

film_list = page.search("//*[@id='mw-content-text']/div/table/tbody/tr")
film_list.shift

films = []
film_list.each do |item|
  title = item.at('td[2]/a').text()
  year = item.at('td[3]/a').text()
  director = item.at('td[4]/a').text()

  films << Film.new(title, director, year)  
end

collection = FilmCollection.new(films)
directors = collection.directors

puts "Фильм на вечер!"
puts "Фильм какого режисера будем смотреть? (укажите номер в списке)"

directors.each_with_index { |director, index| puts "#{index + 1}. #{director}" }
user_choice_director = STDIN.gets.to_i - 1
user_choice_director = directors[user_choice_director]

until directors.include?(user_choice_director)
  puts "Введите режисера из списка!"
  user_choice_director = STDIN.gets.to_i - 1
end

selected_user_films = films.select { |film| film.director == user_choice_director }
film_for_user = selected_user_films.sample

puts
puts "И сегодня вечером рекомендую посмотреть:"
puts film_for_user.info
