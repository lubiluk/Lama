class AddLayerIdToGeometryMark < ActiveRecord::Migration
  def change
      add_column :geometry_marks, :layer_id, :int
  end
end
