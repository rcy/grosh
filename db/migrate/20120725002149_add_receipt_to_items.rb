class AddReceiptToItems < ActiveRecord::Migration
  def change
    add_column :items, :receipt_id, :integer

  end
end
