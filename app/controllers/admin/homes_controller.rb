class Admin::HomesController < ApplicationController
#ログイン済のカスタマーのみにアクセスを許可する
  before_action :authenticate_admin!

  #遷移元によって、処理を変える（要件記載）
  #会員詳細から遷移した場合は、その顧客のみの注文履歴を表示
  #ヘッダーから遷移してきた場合は、全顧客の注文履歴

  def top
    if params[:customer_id]
      #遷移してきたIDをカスタマーIDに入れて、whereで取得
      @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
    else
      #オーダーのデーター全部
      @orders = Order.all.page(params[:page]).per(10)
    end
  end
end
