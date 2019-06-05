class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order(created_at: :desc)}
  scope :feed, ->(following_ids){where user_id: following_ids}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_max}
  validate  :picture_size
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.max_size.megabytes
    errors.add :picture, I18n.t("less_5mb")
  end
end
