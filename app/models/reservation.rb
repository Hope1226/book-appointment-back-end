class Reservation < ApplicationRecord
  validates :city, presence: true, length: { minimum: 2 }
  validates :date, presence: true
  belongs_to :user
  belongs_to :space
end
