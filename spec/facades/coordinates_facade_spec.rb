require 'rails_helper'

RSpec.describe CoordinatesFacade do
  describe 'class methods' do
    describe '::get_coordinates(location)' do
      it 'returns a coordinates object for a given location', :vcr do
      coordinates = CoordinatesFacade.get_coordinates("Bozeman, MT")

      expect(coordinates).to be_a Coordinates
      end 
    end
  end
end
