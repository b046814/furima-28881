class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_expense
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :period

  has_one_attached :image

  validates :image, :name, :description, :category_id, :condition_id, :ship_expense_id, :prefecture_id, :period_id, :price, presence: true

  validates :price, format: { with: /\A[\d]+\z/ }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :ship_expense_id
    validates :prefecture_id
    validates :period_id
  end

  belongs_to :user
end
