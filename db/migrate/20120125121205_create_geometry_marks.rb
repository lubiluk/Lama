class CreateGeometryMarks < ActiveRecord::Migration
  def change
    create_table :geometry_marks do |t|
      t.string :name
      t.float :radius

      t.timestamps
    end
  end
end
