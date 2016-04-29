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

  # transactions getter
  def transactions
    Transaction.find_by_customer(self)
  end

  # creates a new transaction for this customer with the passed product
  def purchase(product)
    if !product.in_stock?
      raise OutOfStockError, "#{product.title} is out of stock."
    end
    Transaction.new(self, product)
  end

  # a method for returning products
  def return(product)
    # first check if transaction for this product exists exists
    transactions.each do |transaction|
      if transaction.product == product
        product.stock += 1
        Transaction.delete(transaction)
        return
      end
    end
    raise NotPurchasedError, "#{self.name} did not purchase #{product.title}."
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