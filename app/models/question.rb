class Question < ApplicationRecord
  belongs_to :deck

  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :question, presence: true
end
