class Question < ApplicationRecord
  belongs_to :my_pool
  has_many :answers
  validates :description, presence: true, length: { minimum: 10}

  validates :my_pool, presence: true
end
