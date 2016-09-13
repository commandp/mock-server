class CreateHeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :headers do |t|
      t.string :key
      t.text :value
      t.belongs_to :api_request, foreign_key: true

      t.timestamps
    end
  end
end
