class ChangingTargetMaxColumnInGoals < ActiveRecord::Migration
  def up
    rename_column :goals, :goal_max, :target
  end

  def down
    rename_column :goals, :target_max, :goal_max
  end
end
