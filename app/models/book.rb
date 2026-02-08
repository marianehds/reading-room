class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1000,
              less_than_or_equal_to: -> { Date.current.year }
            }
end
