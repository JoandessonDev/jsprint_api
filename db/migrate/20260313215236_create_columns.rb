class CreateColumns < ActiveRecord::Migration[8.1]
  def change
    create_table :columns do |t|
      t.string :name
      t.integer :position
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
