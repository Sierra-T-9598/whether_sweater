require 'rails_helper'

RSpec.describe ImageFacade do
  describe 'class methods' do
    describe '::get_background_image(location)' do
      it 'returns an image object for the specified location', :vcr do
        location = 'Denver,CO'
        image = ImageFacade.get_background_image(location)

        expect(image).to be_an Image
      end

      it 'returns only certain data', :vcr do
        location = 'Denver,CO'
        image = ImageFacade.get_background_image(location)

        expect(image.location).to eq(location)
        expect(image.description).to be_a String
        expect(image.urls).to be_a Hash
        expect(image.photographer_credit).to be_a Hash
      end
    end
  end
end
