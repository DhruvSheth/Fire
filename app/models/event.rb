class Event < ApplicationRecord
  validates :picture_url, presence: true

  belongs_to :user

  has_many :event_attendances
  has_many :attending_users, through: :event_attendances, source: :user

  has_many :groups
end
