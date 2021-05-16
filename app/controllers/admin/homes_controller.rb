class Admin::HomesController < ApplicationController

#ログイン済のカスタマーのみにアクセスを許可する
  before_action :authenticate_admin!

  #遷移元によって、処理を変える（要件記載）
  #会員詳細から遷移した場合は、その顧客のみの注文履歴を表示
  #ヘッダーから遷移してきた場合は、全顧客の注文履歴

  def top
    path = Rails.application.routes.recognize_path(request.referer)
    #もし遷移元のコントローラーがadmin/customersであり、かつアクションがshowだったら
    if path[:controller]=="admin/customers" && path[:action] == "show"
    #遷移してきたIDをカスタマーIDに入れて、whereで取得
      @orders = Order.where(customer_id: path[:id])
    else
    #オーダーのデーター全部
      @orders = Order.all
    end
  end
end
