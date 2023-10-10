class Song
  attr_reader :title, :artist

  def initialize(title)
    @title = title
    @artist
  end

  def artist=(name)
    @artist = name.upcase
  end
end

p song = Song.new("Superstition") #=> Returns the object with the instance variable
p song.artist = "Stevie Wonder" #=> "Stevie Wonder"
p song.artist #=> "STEVIE WONDER"