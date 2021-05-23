class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy

#画像アップ用のメソッド（attachment）を追加
  attachment :image

#バリデーションの記述(空でないこと)
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :image, presence: true
  
  # 税込の計算
  def tax_price
     # 税率
    tax_rate = 1.08
    tax_price = self.price * tax_rate
    return tax_price.floor
  end
end
