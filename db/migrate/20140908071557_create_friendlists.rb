class CreateFriendlists < ActiveRecord::Migration
  def change
    create_table :friendlists do |t|
      t.integer :user_id
      t.integer :friendid
      t.integer :status

      t.timestamps
    end
    add_index :friendlists, [:user_id, :friendid], unique: true
  end
end
