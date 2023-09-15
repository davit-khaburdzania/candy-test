class Conversation < ApplicationRecord
  belongs_to :user
  has_many :messages
  after_create_commit { broadcast_append_to 'conversations', locals: {current_conversation: self} }
end
