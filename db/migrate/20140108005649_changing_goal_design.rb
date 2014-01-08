class ChangingGoalDesign < ActiveRecord::Migration
  def up
    rename_column :goals, :starting_strength, :starting_max
    rename_column :goals, :goal_weight, :target_max
    rename_column :goals, :goal_date, :end_date
  end

  def down
    rename_column :goals, :starting_max, :starting_strength
    rename_column :goals, :target_max, :goal_weight
    rename_column :goals, :end_date, :goal_date
  end
end
