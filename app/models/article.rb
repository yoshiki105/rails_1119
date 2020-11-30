class Article < ApplicationRecord
  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 80 }
  validates :body, length: { maximum: 2000 }

  def no_expiration
    expired_at.nil?
  end

  def no_expiration=(val)
    # 引数valがtrueまたは1の時、@no_expirationをtrueにする。
    @no_expiration = val.in?([true, "1"])
  end

  before_validation do
    self.expired_at = nil if @no_expiration
  end

  # errors.add(:expired_at, :expired_at_too_old)

  # 誰でも見れる記事を取得
  scope :open_to_the_public, -> { where(member_only: false)}

  # 現在日時が掲載開始日時と掲載終了日時の間にある記事を取得
  scope :visible, -> do
    now = Time.current

    where("released_at <= ?", now)
    .where("expired_at > ? OR expired_at IS NULL", now)
  end
end
