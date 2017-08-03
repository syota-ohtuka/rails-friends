class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.timestamps

      t.index :from_user_id
      t.index :to_user_id
      t.index [:from_user_id, :to_user_id], unique: true
    end
  end
end
