class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.string :tag
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :interests, :tag
    add_index :interests, [:tag, :user_id], unique: true
  end
end
