class MapService
    def self.coordinates(location)
      get_data("v1/address?location=#{location}")
    end

    private

    def self.conn
      Faraday.new('http://www.mapquestapi.com/geocoding/') do |faraday|
          faraday.params['key'] = ENV['map_quest_api_key']
        end
    end

    def self.get_data(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
