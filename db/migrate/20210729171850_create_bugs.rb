class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.datetime :deadline
      t.string :bug_type
      t.string :bug_status

      t.timestamps
    end
  end
end
