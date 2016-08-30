class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_column :api_requests, :project_id, :integer
    add_index :api_requests, :project_id
  end
end
