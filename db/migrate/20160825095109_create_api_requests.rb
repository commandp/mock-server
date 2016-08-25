class CreateApiRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :api_requests do |t|
      t.string :request_method
      t.string :request_path
      t.string :return_code
      t.text :return_value

      t.timestamps
    end
  end
end
