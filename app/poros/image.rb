class Image
  attr_reader :id, :location, :description, :urls, :photographer_credit

  def initialize(data, location)
    @id = nil
    @location = location
    @description = data[:results][0][:alt_description]
    @urls = all_urls(data[:results][0][:urls])
    @photographer_credit = credits(data[:results][0][:user])
  end

  def all_urls(url_data)
    {
      raw: url_data[:raw],
      full: url_data[:full],
      regular: url_data[:regular],
      thumb: url_data[:thumb]
    }
  end

  def credits(photographer_data)
    {
      name: photographer_data[:name],
      bio: photographer_data[:bio],
      portfolio: photographer_data[:links][:portfolio]
    }
  end
end
