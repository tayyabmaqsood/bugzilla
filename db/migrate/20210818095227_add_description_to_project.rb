class AddDescriptionToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_description, :string
  end
end
