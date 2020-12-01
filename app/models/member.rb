class Member < ApplicationRecord
  # セッションの設定
  has_secure_password

  # モデル間の関連付け
  has_many :entries, dependent: :destroy

  # バリデーション
  validates :number,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than: 100,
              allow_blank: true
            },
            uniqueness: true

  validates :name,
            presence: true,
            format: {
              with: /\A[A-Za-z][A-Za-z0-9]*\z/,
              allow_blank: true,
              message: :invalid_member_name # ja.ymlと対応
            },
            length: { minimum: 2, maximum: 20, allow_blank: true },
            uniqueness: { case_sensitive: false }

  validates :full_name,
            presence: true,
            length: { maximum: 20 }

  validates :email, email: { allow_blank: true } # gemによる拡張表現

  # 現在の（変更前の）パスワード属性
  attr_accessor :current_password

  # パスワードは常に存在するように設定
  validates :password, presence: { if: :current_password }

  # クラスメソッド
  class << self
    def search(query)
      # memberをnumber順にソートする
      rel = order('number')
      if query.present?
        # ソートしたものにnameカラムまたはfull_nameカラムを対象にレコードを絞り込む
        rel = rel.where('name LIKE ? OR full_name LIKE ?',
                        "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
