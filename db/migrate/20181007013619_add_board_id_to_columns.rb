class AddBoardIdToColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :board_id, :int
  end
end
