class CreateWorkspaceMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :workspace_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true
      t.references :workspace_role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
