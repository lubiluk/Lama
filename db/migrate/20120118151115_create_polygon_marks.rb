class CreatePolygonMarks < ActiveRecord::Migration
  def change
    create_table :polygon_marks do |t|
      t.string :name
      t.integer :layer_id

      t.timestamps
    end
  end
end
