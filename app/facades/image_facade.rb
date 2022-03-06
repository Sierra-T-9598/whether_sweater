class ImageFacade
  def self.get_background_image(location)
    image = ImageService.background_image(location)
    Image.new(image, location)
  end
end
