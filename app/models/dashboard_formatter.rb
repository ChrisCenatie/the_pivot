class DashboardFormatter
  attr_reader :order, :link_options_map

  def initialize(order, link_options_map = Hash.new({}))
    @order            = order
    @link_options_map = link_options_map.merge(default_link_options)
  end

  def find_links
    link_options_map[order.status]
  end

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

  def default_link_options
    { "ordered" => { "Cancel" => "cancelled", "Mark as paid" => "paid" },
    "paid" => { "Cancel" => "cancelled", "Mark as completed" => "completed" } }
  end
end
