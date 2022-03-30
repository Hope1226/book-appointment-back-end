class Space < ApplicationRecord
  # Validations
  validates :name, presence: { message: 'field can not be blank' }
  validates :price, presence: { message: 'field can not be blank' }
  validates :image, presence: { message: 'field can not be blank' }
  validates :description, presence: { message: 'field can not be blank' }

  belongs_to :user
end
