class Product < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  before_validation :set_default_sale_price_to_price

  validates :title, presence: true, uniqueness: {message: "already exists"}

  validates :description, presence: true, length: {minimum: 10, message: "too short"}

  validates :price, presence: true, numericality: true

  validates :sale_price, numericality: { less_than_or_equal_to: :price }

  # after_initialize :set_defaults

  def on_sale?
    sale_price < price
  end

  private

  # def set_defaults
  #   self.price ||= sprintf("%0.02f", 0.00)
  # end

  def set_default_sale_price_to_price
    self.sale_price ||= price
  end

end
