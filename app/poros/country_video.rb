class CountryVideo
  attr_reader :title, :video_id, :id

  def initialize(data)
    @id = nil
    @title = data[:snippet][:title]
    @video_id = data[:id][:videoId]
  end
end
