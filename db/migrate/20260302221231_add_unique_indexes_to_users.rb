class AddUniqueIndexesToUsers < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :cpf, unique: true
  end
end
