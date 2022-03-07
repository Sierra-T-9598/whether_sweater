require 'rails_helper'

RSpec.describe MapService do
  describe 'class methods' do
    describe '::coordinates(location)' do
      it 'returns the geocoding data of the provided location as a json object', :vcr do
        response = MapService.coordinates("Bozeman,MT")

        expect(response).to be_a Hash
        expect(response).to have_key(:results)
        expect(response[:results]).to be_an Array

        expect(response[:results][0]).to have_key(:locations)
        expect(response[:results][0][:locations]).to be_an Array

        expect(response[:results][0][:locations][0]).to have_key(:latLng)
        expect(response[:results][0][:locations][0][:latLng]).to be_a Hash

        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end
    end

    describe '::directions(from, to)' do
      describe 'happy path- route between two points' do
        it 'returns the directions data between the two arguments', :vcr do
          from = "lyons,CO"
          to = "bozeman,MT"
          response = MapService.directions(from, to)

          expect(response).to be_a Hash
          expect(response).to have_key(:route)
          expect(response[:route]).to be_a Hash

          expect(response[:route]).to have_key(:routeError)
          expect(response[:route][:routeError]).to be_a Hash

          expect(response[:route]).to have_key(:formattedTime)
          expect(response[:route][:formattedTime]).to be_a String

          expect(response[:route]).to have_key(:realTime)
          expect(response[:route][:realTime]).to be_an Integer
        end
      end

      describe 'sad path- impossible route between to points(driving)' do
        it 'returns a route Error error code euqal to two', :vcr do
          from = "lyons,CO"
          to = "london, Enlgand"
          error_response = MapService.directions(from, to)

          expect(error_response).to be_a Hash
          expect(error_response).to have_key(:route)
          expect(error_response[:route]).to be_a Hash

          expect(error_response[:route]).to have_key(:routeError)
          expect(error_response[:route][:routeError][:errorCode]).to eq(2)
        end
      end
    end
  end
end
