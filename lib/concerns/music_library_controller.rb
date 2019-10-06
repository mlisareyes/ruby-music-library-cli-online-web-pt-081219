class MusicLibraryController

  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    user_input = ""
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

    user_input = gets.chomp

    case user_input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end



  def list_songs
    Song.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|artist, index| puts "#{index}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|genre, index| puts "#{index}. #{genre.name}"}

  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    if Artist.find_by_name(user_input)
      artist = Artist.find_by_name(user_input)
      artist.songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    if Genre.find_by_name(user_input)
      genre = Genre.find_by_name(user_input)
      genre.songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp.to_i
    #songs = Song.all
    #songs.each.with_index(1) {|song, index| puts "Playing #{song.name} by #{song.artist.name}"}
    if user_input.between?(1, Song.all.size)
      song = Song.all.sort {|a, b| a.name <=> b.name}[user_input - 1]
        puts "Playing #{song.name} by #{song.artist.name}"
    else
      false
    end
  end
end
