class Entry < ApplicationRecord
  # モデル間の関連付け
  belongs_to :author, class_name: 'Member', foreign_key: 'member_id'
end
