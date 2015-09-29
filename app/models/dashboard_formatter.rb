class DashboardFormatter
  def self.ordered?
    Order.where(status: 0).count
  end

  def self.paid?
    Order.where(status: 1).count
  end

  def self.cancelled?
    Order.where(status: 2).count
  end

  def self.completed?
    Order.where(status: 3).count
  end
end
