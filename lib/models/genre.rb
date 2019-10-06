class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(genre_name)
    new_genre = Genre.new(genre_name)
    new_genre.save
    new_genre
  end

  def artists
    self.songs.collect {|song| song.artist}.uniq
  end
end
