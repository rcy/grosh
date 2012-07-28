class AddDefaultToItemTotal < ActiveRecord::Migration
  def change
    change_column_default :items, :total, 0
  end
end
