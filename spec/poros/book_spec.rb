require 'rails_helper'

RSpec.describe Book do
  it 'exists' do
    data = { docs: [ { title: "The Bozeman Trail",
                      isbn: [
                          "9780803272491",
                          "0404118607",
                          "9780404118600",
                          "0803272502",
                          "0803272499",
                          "9780803272507"
                      ],
                      publisher: [
                        "A.H. Clark",
                        "AMS Press",
                        "University of Nebraska Press",
                        "The Arthur H. Clark Company"
                    ]}]}
    book = Book.new(data)
    expect(book.title).to eq(data[:docs][0][:title])
    expect(book.isbn).to eq(data[:docs][0][:isbn])
    expect(book.publisher).to eq(data[:docs][0][:publisher])
  end
end
