class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, presence: { message: 'This field can not be blank' }

  has_many :spaces, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def admin?
    role == 'admin'
  end
end
