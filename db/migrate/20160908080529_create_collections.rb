class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.belongs_to :project

      t.timestamps
    end
    add_column :api_requests, :collection_id, :integer
    add_index :api_requests, :collection_id
  end
end
