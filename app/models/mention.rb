class Mention < ActiveRecord::Base
  attr_accessible :tweet, :user
  belongs_to :tweet
  belongs_to :user

  validate :tweet, presence: true
  validate :user, presence: true
end
