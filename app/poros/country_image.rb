class CountryImage
  attr_reader :alt_tag, :url

  def initialize(data)
    raise ArgumentError, "Missing alt_description in image data" if data[:alt_description].nil?
    raise ArgumentError, "Missing urls in image data" if data[:urls].nil?
    
    @alt_tag = data[:alt_description]
    @url = data[:urls][:regular]
  end
end
