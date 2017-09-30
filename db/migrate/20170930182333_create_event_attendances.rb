class CreateEventAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :event_attendances do |t|
      t.references :user
      t.references :event

      t.timestamps
    end

    add_index :event_attendances, [:user_id, :event_id], unique: true
  end
end
