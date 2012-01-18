class AddLayerIdToPointMark < ActiveRecord::Migration
  def change
    add_column :point_marks, :layer_id, :int
  end
end
