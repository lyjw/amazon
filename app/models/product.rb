class Product < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :category
  belongs_to :user

  before_validation :set_default_sale_price_to_price

  validates :title, presence: true, uniqueness: {message: "already exists"}

  validates :description, presence: true, length: {minimum: 10, message: "too short"}

  validates :price, presence: true, numericality: true

  validates :sale_price, numericality: { less_than_or_equal_to: :price }

  # after_initialize :set_defaults

  def on_sale?
    sale_price < price
  end

  # def belongs_to_current_user?
  #   user == current_user
  # end

  def user_full_name
    user ? user.full_name : "Anonymous"
  end

  def category_name
    category_id ? Category.find(category_id).name : ""
  end

  private

  # def set_defaults
  #   self.price ||= sprintf("%0.02f", 0.00)
  # end

  def set_default_sale_price_to_price
    self.sale_price ||= price
  end

end
