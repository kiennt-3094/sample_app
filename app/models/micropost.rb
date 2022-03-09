class Micropost < ApplicationRecord
  belongs_to :user
  scope :recent_posts, ->{order created_at: :desc}
  scope :relate_post, ->(user){where user_id: user.following_ids << user.id}
  has_one_attached :image
  validates :content, presence: true,
             length: {maximum: Settings.settings.micropost.content.max_length}
  validates :image, content_type: {in: Settings.settings.image.type, message: :invalid_format},
             size: {less_than: Settings.settings.image.max_size.megabytes, message: :oversized}
  def display_image
    image.variant resize_to_limit: [Settings.settings.image.limit,
                                    Settings.settings.image.limit]
  end
end
