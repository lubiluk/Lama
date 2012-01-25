class CreateMapStates < ActiveRecord::Migration
  def change
    create_table :map_states do |t|
      t.float :x
      t.float :y
      t.float :zoom

      t.timestamps
    end
  end
end
