class Deck < ApplicationRecord
  belongs_to :user

  # has_many :chats, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_one :chat, dependent: :destroy

  validates :title, presence: true
end
