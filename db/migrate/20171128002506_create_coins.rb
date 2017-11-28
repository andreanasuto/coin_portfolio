class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.integer :user_id
      t.string :name
      t.float :quantity
    end
  end
end
