class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.integer :target_weight, null: false
      t.integer :weight_lifted
      t.integer :goal_id, null: false
      t.timestamps
    end
  end
end
