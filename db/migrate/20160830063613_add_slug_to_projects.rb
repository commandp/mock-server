class AddSlugToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :slug, :string, uniq: true
    add_index :projects, :slug
  end
end
