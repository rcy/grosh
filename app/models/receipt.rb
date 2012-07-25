class Receipt < ActiveRecord::Base
  has_many :items
end
