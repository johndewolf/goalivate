class ChangingGoalsToFloats < ActiveRecord::Migration
  def up
    change_column :goals, :target, :float
    change_column :goals, :starting_point, :float

    change_column :checkpoints, :target, :float
    change_column :checkpoints, :user_input, :float
  end

  def down
    change_column :goals, :target, :integer
    change_column :goals, :starting_point, :integer

    change_column :checkpoints, :target, :integer
    change_column :checkpoints, :user_input, :integer
  end
end
