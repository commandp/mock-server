class AddNameAndDescriptionToApiRequests < ActiveRecord::Migration[5.0]

  def change
    add_column :api_requests, :name, :string, default: "", null: false
    add_column :api_requests, :description, :text, default: "", null: false
  end

end
