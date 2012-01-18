class AddPolygonToPolygonMark < ActiveRecord::Migration
  def change
      add_column :polygon_marks, :the_geom, :polygon, :srid => 4269
      add_index :polygon_marks, :the_geom, :spatial => true 
  end
end
