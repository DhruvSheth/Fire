# The relationship between a User attending an event
# and the event the User is attending.`
class EventAttendance < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
