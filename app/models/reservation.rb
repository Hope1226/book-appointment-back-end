class Reservation < ApplicationRecord
  validates :city, presence: true, length: { minimum: 2 }
  validates :date, presence: true
  belongs_to :user
  has_many :items
end
