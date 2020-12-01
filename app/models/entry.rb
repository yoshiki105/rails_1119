class Entry < ApplicationRecord
  # モデル間の関連付け
  belongs_to :author, class_name: 'Member', foreign_key: 'member_id'

  STATUS_VALUES = %w[draft member_only public].freeze

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: 'public') }
  scope :published, -> { where('status <> ?', 'draft') }
  scope :full, lambda { |_member|
    where('status <> ? OR member_id = ?', 'draft', member_id)
  }
  scope :readable_for, lambda(member) { member ? full(member) : common }
end
