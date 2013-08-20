class AddBreweryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :brewery, :string
  end
end
