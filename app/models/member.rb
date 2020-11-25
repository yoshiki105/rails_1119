class Member < ApplicationRecord
  # クラスメソッド
  class << self
    def search(query)
      # memberをnumber順にソートする
      rel = order("number")
      if query.present?
        # ソートしたものにnameカラムまたはfull_nameカラムを対象にレコードを絞り込む
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
            "%#{query}%", "%#{query}%")
      end
      return rel
    end

  end
end
