require 'rails_helper'

RSpec.describe ImageService do
  describe 'class methods' do
    describe '::background_image' do
      it 'returns the json image data for the requested image', :vcr do
        response = ImageService.background_image('Bozeman,MT')

        expect(response).to be_a Hash

        expect(response[:results][0]).to have_key :urls
        expect(response[:results][0][:urls]).to be_a Hash

        expect(response[:results][0]).to have_key :alt_description
        expect(response[:results][0][:alt_description]).to be_a String

        expect(response[:results][0]).to have_key :user
        expect(response[:results][0][:user]).to be_a Hash
      end
    end
  end
end
