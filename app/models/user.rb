class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  has_many :conversations
  has_many :notifications
end
