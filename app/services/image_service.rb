class ImageService
  def self.background_image(location)
    get_data("search/photos?query=#{location}")
  end

  private

  def self.conn
    Faraday.new('https://api.unsplash.com/') do |faraday|
        faraday.params['client_id'] = ENV['image_api_key']
      end
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
