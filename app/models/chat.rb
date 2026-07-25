class Chat < ApplicationRecord
  belongs_to :deck
  has_many :messages
end
