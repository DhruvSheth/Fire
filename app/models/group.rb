class Group < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_many :messages
end
