class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  # 全角カタカナと長音符にマッチする正規表現
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  # 半角数字にマッチする正規表現
  NUMBER_REGEXP = /\A[0-9]+\z/

  #バリデーションの記述(空でないこと)
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: KATAKANA_REGEXP, message: "は全角カタカナのみで入力して下さい" }
  validates :first_name_kana, presence: true, format: { with: KATAKANA_REGEXP, message: "は全角カタカナのみで入力して下さい" }
  validates :email, presence: true
  validates :postal_code, presence: true, format: { with: NUMBER_REGEXP, message: "は半角数字のみで入力して下さい" }
  validates :address, presence: true
  validates :tel, presence: true, format: { with: NUMBER_REGEXP, message: "は半角数字のみで入力して下さい" }

  # 退会したアカウントはログインできないようにする
  def active_for_authentication?
    super && self.is_deleted == false
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "ユーザー"
      user.last_name = "ゲスト"
      user.first_name_kana = "ユーザー"
      user.last_name_kana = "ゲスト"
      user.postal_code = "000"
      user.address = "テストデータ住所1"
      user.tel = "0800000"
    end
  end
end
