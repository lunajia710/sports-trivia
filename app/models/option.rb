class Option < ApplicationRecord
  belongs_to :question

  validates :response, presence: true
  validates :is_solution, inclusion: { in: [true, false] }
end
