class RenameQuantityPerToUnits < ActiveRecord::Migration
  def up
    rename_column :items, :quantity_per, :units
  end

  def down
  end
end
