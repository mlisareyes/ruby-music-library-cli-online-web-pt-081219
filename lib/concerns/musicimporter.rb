class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = []
    Dir.new(path).each do |file|
      files << file if file.end_with?('.mp3')
    end
    files
  end

  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end

end
