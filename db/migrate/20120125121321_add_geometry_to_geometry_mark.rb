class AddGeometryToGeometryMark < ActiveRecord::Migration
  def change
      add_column :geometry_marks, :the_geom, :geometry, :srid => 4269
      add_index :geometry_marks, :the_geom, :spatial => true
  end
end
