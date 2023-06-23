class Item < ApplicationRecord
  has_one_attached :image
  
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :price, numericality: true
  validates :image, presence: true

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
