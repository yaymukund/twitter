class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content

  validates :user, presence: true
  validates :content, presence: true,
                      length: {in: 1..160}
end
