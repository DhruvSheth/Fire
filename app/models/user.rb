# A User can attend events and join groups based on his or her interests,
# login and session information is handled by Devise.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event

  has_many :interests

  has_many :groups

  has_many :messages

  # Is this User attending the given event?
  def is_attending?(event)
    self.event_attendances.where(event_id: event.id).any?
  end

  # Returns an array of members with like interests who are interested
  # in joining the given group.
  def get_members(group)
    members = []

    if (Group.where(event_id: group.event_id).count <= 1)
      members << self
    else
      similar_groups = Group.where(event_id: group.event_id)
    
      similar_groups.each do |group|
        user = User.find(group.user_id)

        members << user unless members.include?(user) || !interested_in(user)
      end
    end

    if (Group.where(event_id: group.event_id).count > 1 && members.size < 5)
      similar_groups = Group.where(event_id: group.event_id)
    
      similar_groups.each do |group|
        user = User.find(group.user_id)

        members << user unless members.include?(user) || members.size == 5
      end
    end

    return members
  end

  # Gets all the messages the User has sent in his or her
  # group for the current event.
  def get_messages_in(event)
    current_group = groups.where(event_id: event.id).first

    current_group.messages
  end

  private

    # Does the given User share in enough interests as this User
    # for them to enjoy being grouped up.
    def interested_in(user)
      user_interests = user.interests

      same_interests = 0;
      user_interests.each do |interest|
        same_interests += 1 if interests.include?(interest)
      end

      return same_interests >= 2
    end
end
