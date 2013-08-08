class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
    add_index :products, :user_id
  end
end
