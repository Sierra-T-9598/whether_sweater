class MapService
    def self.coordinates(location)
      get_data("geocoding/v1/address?location=#{location}")
    end

    def self.directions(from, to)
      get_data("directions/v2/route?from=#{from}&to=#{to}")
    end

    private

    def self.conn
      Faraday.new('http://www.mapquestapi.com/') do |faraday|
          faraday.params['key'] = ENV['map_quest_api_key']
        end
    end

    def self.get_data(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
