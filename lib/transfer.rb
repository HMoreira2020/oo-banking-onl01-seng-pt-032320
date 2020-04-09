class Transfer
  attr_accessor :sender, :receiver, :amount, :status 
  
  
  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver 
    @amount = amount 
    @status = "pending" 
  end 
  
  def valid? 
    sender.valid? && receiver.valid? && sender.balance > self.amount
  end
  
  def execute_transaction 
    transfer = Transfer.new(sender, receiver, amount) 
    if !(transfer.valid?)
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif self.status == "complete"
      "This transaction has already been completed."
    else 
      receiver.deposit(self.amount)
      sender.balance -= self.amount 
      self.status = "complete"
    end 
  end 
  
  def reverse_transfer 
    if self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.balance -= self.amount 
      self.status = "reversed" 
    end 
  end 
  
end
