class Round < ApplicationRecord
  belongs_to :deck
  belongs_to :user
  # has_many :answers, dependent: :destroy
end
