class AddingColumnsToUpdateGoals < ActiveRecord::Migration

  def up
    add_column :goals, :title, :string, null: false
    add_column :goals, :description, :text
    add_column :goals, :unit_of_measurement, :string, null: false
    remove_column :goals, :exercise_id
    rename_column :goals, :starting_max, :starting_point
    rename_column :goals, :target, :target
  end

  def down
    remove_column :goals, :title
    remove_column :goals, :description
    remove_column :goals, :unit_of_measurement
    add_column :goals, :exercise_id, :integer, null: false
    rename_column :goals, :starting_max, :starting_point
    rename_column :goals, :target, :target
  end
end

