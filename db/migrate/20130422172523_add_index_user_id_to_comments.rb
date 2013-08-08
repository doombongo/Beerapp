class AddIndexUserIdToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.belongs_to :user
    end
    add_index :comments, :user_id
  end
end
