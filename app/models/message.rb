class Message < ApplicationRecord
  belongs_to :conversation

  enum sender: {
    user: 0,
    system: 1
  }

  after_create_commit { broadcast_append_to self.conversation }
end
