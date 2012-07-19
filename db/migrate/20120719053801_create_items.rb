class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :store
      t.datetime :date
      t.string :code
      t.decimal :quantity
      t.string :quantity_per
      t.decimal :price
      t.string :price_per
      t.string :description
      t.decimal :total
      t.string :tax_code

      t.timestamps
    end
  end
end
