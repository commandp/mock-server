class ChangeApiRequestsReturnCodeColumnTypeToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :api_requests, :return_code
    add_column :api_requests, :status_code, :integer
  end
end
