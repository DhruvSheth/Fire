# Relates a User to an Event he or she wants to find
# a group to join.
#
# TODO: Remodel this so a group contains a list of Users,
# and handle all the group creating here.
class Group < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_many :messages
end
