class User < ActiveRecord::Base
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :reviews, source: :review
  has_many :dislike, dependent: :destroy
  has_many :disliked_reviews, through: :reviews, source: :review

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
