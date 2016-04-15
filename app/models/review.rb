class Review < ActiveRecord::Base
  belongs_to :product

  validates :stars, presence: true, inclusion: { in:(1..5), message: "count must be between 1 - 5."}
  # numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }

end
