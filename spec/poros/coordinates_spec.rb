require 'rails_helper'

RSpec.describe Coordinates do
  it 'exists' do
    data = { results:
      [ locations: [
        { latLng:
          { lat: 45.679294, lng: -111.046611}}]]}
    coordinates = Coordinates.new(data)

    expect(coordinates.lat).to eq(45.679294)
    expect(coordinates.lng).to eq(-111.046611)
  end
end
