class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event

  has_many :interests

  def is_attending?(event)
    self.event_attendances.where(event_id: event.id).any?
  end
end
