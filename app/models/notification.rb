class Notification < ApplicationRecord
  belongs_to :user

  scope :unseen, -> { where(seen: false) }

  after_create_commit { broadcast_append_to self.user }
end
