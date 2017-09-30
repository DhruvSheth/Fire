class Event < ApplicationRecord
  validates :picture_url, presence: true
end
