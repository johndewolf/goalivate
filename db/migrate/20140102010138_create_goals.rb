class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :starting_strength, null: false
      t.integer :goal_weight, null: false
      t.datetime :goal_date, null: false
      t.integer :exercise_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
