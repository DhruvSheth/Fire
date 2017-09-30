class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end

    add_index :events, :title 
    add_index :events, :start_time
    add_index :events, :end_time
    add_index :events, :location
  end
end
