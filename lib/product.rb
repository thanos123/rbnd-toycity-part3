class Product
  attr_reader :title

  @@products = []

  def initialize(options={})
    @title = options[:title]
    add_to_products
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    product = Product.find_by_title(@title)
    if ! product.nil?
      raise DuplicateProductError, "#{title} already exists."
    end
    @@products << self
  end

  # looks for a product with the tile. returns nil if nothing found
  def self.find_by_title(title)
    @@products.each do |product| 
      return product if title == product.title
    end
    nil
  end
end