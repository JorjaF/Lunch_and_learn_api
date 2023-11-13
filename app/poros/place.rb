class Place
  attr_reader :name, :address, :city, :state, :zip, :phone, :type
  
  def initialize(data)
    @name = data[:name]
    @address = data[:address]
    @city = data[:city]
    @state = data[:state]
    @zip = data[:zip]
    @phone = data[:phone]
    @type = data[:type]
  end
end
