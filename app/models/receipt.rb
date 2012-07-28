class Receipt < ActiveRecord::Base
  validates_presence_of :date

  has_many :items, :dependent => :destroy

  def total
    items.inject(0) {|sum, n| sum + n.total}
  end

  def pretty_total
    ActionController::Base.helpers.number_to_currency(total)
  end
end
