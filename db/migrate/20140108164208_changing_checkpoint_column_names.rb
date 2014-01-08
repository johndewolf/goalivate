class ChangingCheckpointColumnNames < ActiveRecord::Migration
  def up
    rename_column :checkpoints, :target_weight, :target
    rename_column :checkpoints, :weight_lifted, :user_input
  end

  def down
    rename_column :checkpoints, :target, :target_weight
    rename_column :checkpoints, :user_input, :weight_lifted
  end
end
