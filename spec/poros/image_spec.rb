require 'rails_helper'

RSpec.describe Image do
  it 'exists' do
    location = 'Bozeman, MT'
    data = { results: [{ alt_description: "white and brown goat on rocky mountain during daytime",
            urls: { raw: 'placeholder', full: 'placeholder', regular: 'placeholder', small: 'placeholder', thumb: 'placeholder'},
            user: { name: "Lee Peters", bio: "Sharing experiences through photography",links: { portfolio: 'placeholder'}
              }}]}
    image = Image.new(data, location)

    expect(image.id).to eq(nil)
    expect(image.location).to eq('Bozeman, MT')
    expect(image.description).to eq("white and brown goat on rocky mountain during daytime")

    expect(image.urls).to be_a Hash
    expect(image.urls).to have_key :raw
    expect(image.urls).to have_key :thumb

    expect(image.photographer_credit).to be_a Hash
    expect(image.photographer_credit).to have_key :name
    expect(image.photographer_credit).to have_key :portfolio
  end
end
