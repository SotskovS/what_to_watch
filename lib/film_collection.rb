class FilmCollection
  def initialize(films)
    @films = films
  end

  def directors
    (@films.map { |film| film.director }).uniq
  end
end
