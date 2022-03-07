class Book
  attr_reader :title, :publisher, :isbn
  def initialize(data)
    
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
  end
end
