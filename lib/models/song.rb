class Song
  #extend Findable #Take all of the methods in the Findable module and add them as class methods

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all #class reader
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(song_name)
    new_song = self.new(song_name)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(file)
    file = file.gsub(".mp3","")
    artist, song, genre = file.split(" - ")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    song = Song.new(song, artist, genre)
  end

  def self.create_from_filename(file)
    new_song = new_from_filename(file)
    new_song.save
  end
end
