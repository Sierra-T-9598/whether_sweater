require 'rails_helper'

RSpec.describe CoordinatesFacade do
  describe 'class methods' do
    describe '::get_coordinates(location)' do
      it 'returns a coordinates object for a given location', :vcr do
      coordinates = CoordinatesFacade.get_coordinates("Bozeman, MT")

      expect(coordinates).to be_an_instance_of(Coordinates)
      end

      it 'returns only lat-lng' do
        coordinates = CoordinatesFacade.get_coordinates("Bozeman, MT")

        expect(coordinates.lat).to_not eq(nil)
        expect(coordinates.lat).to be_a Float
        
        expect(coordinates.lng).to_not eq(nil)
        expect(coordinates.lng).to be_a Float
      end
    end
  end
end
