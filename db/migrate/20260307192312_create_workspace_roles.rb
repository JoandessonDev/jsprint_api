class CreateWorkspaceRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :workspace_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
