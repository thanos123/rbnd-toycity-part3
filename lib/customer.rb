class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  # looks for a customer with the passed name. returns nil if nothing found
  def self.find_by_name(name)
    @@customers.each do |customer| 
      return customer if name == customer.name
    end
    nil
  end

  # creates a new transaction for this customer with the passed product
  def purchase(product)
    if !product.in_stock?
      raise OutOfStockError, "#{product.title} is out of stock."
    end
    Transaction.new(self, product)
  end

  private

  def add_to_customers
    customer = Customer.find_by_name(@name)
    if ! customer.nil?
      raise DuplicateCustomerError, "#{name} already exists."
    end
    @@customers << self
  end


end