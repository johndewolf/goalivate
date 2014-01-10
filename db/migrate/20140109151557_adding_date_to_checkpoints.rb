class AddingDateToCheckpoints < ActiveRecord::Migration
  def up
    add_column :checkpoints, :complete_by, :datetime, null: false
  end

  def down
    remove_column :checkpoints, :complete_by
  end
end
