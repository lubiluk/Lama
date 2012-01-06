class CreatePointMarks < ActiveRecord::Migration
  def change
    create_table :point_marks do |t|
      t.string :name

      t.timestamps
    end
  end
end
