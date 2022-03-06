require 'rails_helper'

RSpec.describe ImageFacade do
  describe 'class methods' do
    describe '::get_background_image(location)' do
      it 'returns an image object for the specified location', :vcr do
        location = 'Denver,CO'
        image = ImageFacade.get_background_image(location)

        expect(image).to be_an Image
      end
    end
  end
end
