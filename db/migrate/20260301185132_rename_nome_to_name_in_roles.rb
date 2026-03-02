class RenameNomeToNameInRoles < ActiveRecord::Migration[8.1]
  def change
    rename_column :roles, :nome, :name
  end
end
