class Item < ActiveRecord::Base
  belongs_to :receipt
  validates_presence_of :receipt_id
end
