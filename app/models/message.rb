# A message of a User in a specific Group.
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
