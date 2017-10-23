# An interest is a simple tag belonging to a User describing
# his or her interests, used for making groups
class Interest < ApplicationRecord
  belongs_to :user
end
