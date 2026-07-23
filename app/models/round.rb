class Round < ApplicationRecord
  belongs_to :deck
  belongs_to :user
  # has_many :answers, dependent: :destroy
  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
