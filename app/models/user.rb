class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :last_name_k, format: { with: /\A[ァ-ン]+\z/ }
  validates :first_name_k, format: { with: /\A[ァ-ン]+\z/ }
  validates :nickname, :last_name, :first_name, :last_name_k, :first_name_k, :birth_date, presence: true

  has_many :items
  has_many :orders
end
