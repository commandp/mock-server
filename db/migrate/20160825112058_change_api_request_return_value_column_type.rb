class ChangeApiRequestReturnValueColumnType < ActiveRecord::Migration[5.0]
  def change
    remove_column :api_requests, :return_value
    add_column :api_requests, :return_json, :json
  end
end
