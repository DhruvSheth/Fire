class AddPictureUrlToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :picture_url, :string
  end
end
