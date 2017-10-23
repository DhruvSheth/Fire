# An event for Users to attend, containing a description, location,
# and event name, and event creator.
class Event < ApplicationRecord
  validates :picture_url, presence: true

  # The creator of this event.
  belongs_to :user

  # Has many attending users through all event attendances associated
  # with this Event.
  has_many :event_attendances
  has_many :attending_users, through: :event_attendances, source: :user

  has_many :groups
end
