class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver    
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending' && self.valid? && self.sender.balance > self.amount
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = 'complete'
    else
      reject_transfer
    end
  end
  
  def reverse_transfer
    if self.status == 'complete' && self.valid? && self.receiver.balance > self.amount
      self.receiver.balance -= self.amount
      self.sender.balance += self.amount
      self.status = 'reversed'
    else 
      reject_transfer
    end    
  end
  
  def reject_transfer
    self.status = 'rejected'
    'Transaction rejected. Please check your account balance.'
  end
end
