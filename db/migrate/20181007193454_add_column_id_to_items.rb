class AddColumnIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :column_id, :int
  end
end
