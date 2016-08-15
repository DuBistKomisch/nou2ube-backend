# == Schema Information
#
# Table name: items
#
#  id              :uuid(16)         not null, primary key
#  subscription_id :uuid(16)         not null
#  video_id        :uuid(16)         not null
#  state           :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_items_on_subscription_id  (subscription_id)
#  index_items_on_video_id         (video_id)
#  sqlite_autoindex_items_1        (id) UNIQUE
#

class Item < ActiveRecord::Base
  include ActiveUUID::UUID
  natural_key :created_at

  enum state: [ :state_new, :state_later ]

  belongs_to :subscription
  belongs_to :video
  # convenience
  has_one :channel, through: :video
  has_one :user, through: :subscription

  # TODO on destroy, destroy associated video if no other items for it exist
end