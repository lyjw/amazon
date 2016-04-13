class Product < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {message: "already exists"}

  validates :description, presence: true, length: {minimum: 10, message: "too short"}

  validates :price, presence: true, numericality: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.price ||= sprintf("%0.02f", 0.00)
  end

end
