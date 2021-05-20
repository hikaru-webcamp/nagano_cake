class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum order_status: {入金待ち:0, 入金確認:1,  製作中:2, 発送準備中:3, 発送済み:4}

  after_update do
    if saved_change_to_order_status?
      # order_statusの値が変更されたときにupdate_making_statusを呼び出し
      update_making_status
    end
  end

  private

  # order_statusが「入金待ち」以外に変更されたときに、「着手不可」になっている商品を全て「製作待ち」に変更
  def update_making_status
    if order_status != "入金待ち"
      order_details.each do |order_detail|
        if order_detail.making_status == "着手不可"
          order_detail.update(making_status: "製作待ち")
        end
      end
    end
  end
end
