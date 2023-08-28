class Cart < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many :cart_products

  scope :not_finished,-> { where(finished: :false) }
end
