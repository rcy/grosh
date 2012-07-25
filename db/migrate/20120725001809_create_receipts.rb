class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :store
      t.datetime :date

      t.timestamps
    end
  end
end
