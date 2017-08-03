class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :search_word, :string
  end
end
