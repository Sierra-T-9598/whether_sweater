require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    describe '::get_road_trip(origin, destination)' do
      it 'returns a RoadTrip object', :vcr do
        origin = "Bozeman,MT"
        destination = "Sandpoint,ID"
        trip = RoadTripFacade.get_road_trip(origin, destination)
        expect(trip).to be_a RoadTrip
      end 
    end
  end
end
