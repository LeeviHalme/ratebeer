class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  validate :unique_membership, on: :create

  private

  def unique_membership
    return unless Membership.exists?(user_id: user.id, beer_club_id: beer_club.id)

    errors.add(:base, "You are already a member of this club")
  end
end
