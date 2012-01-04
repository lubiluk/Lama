class AddPointToPointMark < ActiveRecord::Migration
  def change
    add_column :point_marks, :the_geom, :point, :srid => 4269
    add_index :point_marks, :the_geom, :spatial => true 
  end
end
