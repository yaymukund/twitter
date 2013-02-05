class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content

  validates :user, presence: true
  validates :content, length: {in: 1..160}
end
