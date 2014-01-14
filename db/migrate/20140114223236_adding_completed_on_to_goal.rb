class AddingCompletedOnToGoal < ActiveRecord::Migration
  def up
    add_column :goals, :completed_on, :date
  end

  def down
    remove_column :goals, :completed_on
  end
end
