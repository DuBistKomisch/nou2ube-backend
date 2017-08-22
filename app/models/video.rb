# == Schema Information
#
# Table name: videos
#
#  id           :binary(16)       not null, primary key
#  api_id       :string           not null
#  channel_id   :binary(16)       not null
#  title        :string           not null
#  thumbnail    :string           not null
#  duration     :integer          default(0), not null
#  published_at :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_videos_on_api_id      (api_id)
#  index_videos_on_channel_id  (channel_id)
#  sqlite_autoindex_videos_1   (id) UNIQUE
#

class Video < ApplicationRecord
  belongs_to :channel
  has_many :items, dependent: :destroy
  # convenience
  has_many :subscriptions, through: :items
  has_many :users, through: :items

  validates :api_id, presence: true
  validates :title, presence: true
  validates :thumbnail, presence: true

  after_create do
    channel.users.each do |user|
      Item.find_or_create_by(subscription: Subscription.find_by(user: user, channel: channel), video: self)
    end
  end
end
