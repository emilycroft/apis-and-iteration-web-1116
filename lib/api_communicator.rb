require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters = character_hash["results"]

  array_of_film_hashes = []

  characters.each do |character_hash|
    array_of_film_hashes = character_hash["films"] if character_hash["name"].downcase == character
  end
  array_of_film_hashes.map! do |url|
    url = JSON.parse(RestClient.get(url))
  end

  # make a conditional that checks character_hash["results"], which is an array of character hashes
  # iterate over that array and check the name key
  # if the name key == user input
  # return the array corresponding to the films key

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  titles = []
  films_hash.each do |film|
    titles << film["title"]
  end
  puts "This character appears in #{titles[0...-1].join(", ")}, and #{titles.last}."
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
