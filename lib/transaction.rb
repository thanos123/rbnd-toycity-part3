class Transaction
  attr_reader :product, :customer, :id

  @@transactions = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    @id = @@transactions.count + 1
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

  private

  def add_to_transactions
    @@transactions << self
  end


end