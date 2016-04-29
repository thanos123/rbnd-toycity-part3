class Transaction
  attr_reader :product, :customer, :id

  @@transactions = []
  @@id = 0

  def initialize(customer, product)
    @customer = customer
    @product = product
    @@id += 1
    @id = @@id
    product.stock -= 1
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  # finds a transaction by id
  def self.find(id)
    @@transactions.each do |transaction| 
      return transaction if id == transaction.id
    end
  end

  # removes a transaction
  def self.delete(transaction)
    @@transactions.delete(transaction)
  end

  # find all transactions for customer
  def self.find_by_customer(customer)
    return @@transactions.select do |transaction|
      transaction.customer == customer
    end
  end

  # find all transactions for product
  def self.find_by_product(product)
    return @@transactions.select do |transaction|
      transaction.product == product
    end
  end

  # find all transactions for product and customer
  def self.find_by_product_and_customer(product, customer)
    return @@transactions.select do |transaction|
      transaction.product == product && ransaction.customer == customer
    end
  end

  private

  def add_to_transactions
    @@transactions << self
  end


end