class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy

#画像アップ用のメソッド（attachment）を追加
  attachment :image

#バリデーションの記述(空でないこと)
  validates :name, presence: true
  validates :price, presence: true
  
  # 税込の計算
  def tax_price
    tax_price = self.price * 1.08
    return tax_price.floor.to_s(:delimited, delimiter: ",")
  end
  
end
