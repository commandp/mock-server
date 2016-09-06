class CreateParameters < ActiveRecord::Migration[5.0]
  def change
    create_table :parameters do |t|
      t.boolean :required, dafault: false
      t.string :name, null: false
      t.text :value, default: ''
      t.string :param_type, null: false
      t.belongs_to :api_request

      t.timestamps
    end
  end
end
