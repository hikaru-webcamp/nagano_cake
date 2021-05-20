class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum making_status: {着手不可:0, 製作待ち:1,  製作中:2, 製作完了:3}

  after_update do
    if saved_change_to_making_status?
      # making_statusの値が変更されたときにupdate_order_statusを呼び出し
      update_order_status
    end
  end

  private
  
  def update_order_status
    if making_status == "製作中"
      # 商品が「製作中」になったら、注文のステータスも「製作中」に変更
      order.update(order_status: "製作中")

    # 商品が「製作完了」になったら
    elsif making_status == "製作完了"
      # すべての注文商品が「製作完了」になっているか判定するフラグ
      all_finished = true
      # 紐付いている注文の注文商品すべてに対して実行
      order.order_details.each do |order_detail|
        unless order_detail.making_status == "製作完了"
          # 「製作完了」でない商品があったらフラグをfalseに変更
          all_finished = false
        end
      end
      if all_finished
        # すべての注文商品が「製作完了」になったら、紐づく注文のステータスを「発送準備中」に変更
        order.update(order_status: "発送準備中")
      end
    end
  end
end
