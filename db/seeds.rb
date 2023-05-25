# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'rest-client'

puts 'Seeding...'

response = RestClient.get 'https://tmdb.lewagon.com/movie/top_rated'
repos = JSON.parse(response)
# => repos is an `Array` of `Hashes`.

repos['results'].each do |h|
  movie = Movie.new(
    title: h['title'],
    overview: h['overview'],
    poster_url: "https://image.tmdb.org/t/p#{h['poster_path']}",
    rating: h['vote_average']
  )
  movie.save!
  puts movie.title
end

puts 'End!'
