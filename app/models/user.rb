class User < ApplicationRecord
  has_many :items, dependent: :destroy

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, presence: { message: 'This field can not be blank' }
end
