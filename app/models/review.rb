class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :stars, presence: true, inclusion: { in:(1..5), message: "count must be between 1 - 5."}
  # numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }

  def user_full_name
    user ? user.full_name : "Anonymous"
  end

  def product_name
    Product.find(product_id).title
  end

  def show_stars(count)
    star_displays = { 1 => "&#9733;&#9734;&#9734;&#9734;&#9734;",
                      2 => "&#9733;&#9733;&#9734;&#9734;&#9734;",
                      3 => "&#9733;&#9733;&#9733;&#9734;&#9734;",
                      4 => "&#9733;&#9733;&#9733;&#9733;&#9734;",
                      5 => "&#9733;&#9733;&#9733;&#9733;&#9733;"}

    star_displays[count.round]
  end

end
