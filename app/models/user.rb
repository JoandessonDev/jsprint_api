class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :cpf, presence: true, uniqueness: true, format: { with: /\A\d{11}\z/, message: "inválido" }
end
