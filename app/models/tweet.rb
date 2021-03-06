class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user, counter_cache: :tweets_count
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :reply_users, through: :replies, source: :user

end
