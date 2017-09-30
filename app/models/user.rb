class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event

  has_many :interests

  has_many :groups

  def is_attending?(event)
    self.event_attendances.where(event_id: event.id).any?
  end

  def get_members(group)
    members = []

    if (Group.where(event_id: group.event_id).count > 1)
      members << self
    else
      similar_groups = Group.find(event_id: group.event_id)
    
      similar_groups.each do |group|
        members << User.find(group.user_id)
      end
    end

    return members
  end
end
